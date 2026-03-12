//
//  AddTransactionViewViewModel.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/8/23.
//
import FirebaseFirestore
import FirebaseAuth
import Foundation

class AddTransactionViewViewModel: ObservableObject{
    @Published var item:String=""
    @Published var costStr:String=""
    @Published var cost:Double=0
    @Published var type:String="Food"
    @Published var datetime:Date=Date()
    @Published var isAlert:Bool=false
    @Published var alertMessage:String=""
    
    init(){}
    
    func alert(_ message:String){
        alertMessage=message
        isAlert=true
    }
    func isValidInput()->Bool{
        guard let temp=Double(costStr) else {return false}
        cost=temp
        return (item != "" && cost > 0 && types.contains(type))
    }
    func addTransaction(){
        guard let uid=Auth.auth().currentUser?.uid else {
            print("no user logged in??")
            return
        }
        guard isValidInput() else {
            alert("Invalid Input")
            return
        }
        let db=Firestore.firestore()
        // prepare doc ref for read and write
        let userRef=db.collection("users").document(uid)
        let transactionRef=db.collection("transactions").document()
        db.runTransaction { transaction, errorPointer in
            // make snapshot variable to store read
            let doc:DocumentSnapshot
            do {
                try doc = transaction.getDocument(userRef)
            } catch let fetchError as NSError {
                errorPointer?.pointee = fetchError
                return nil
            }
            // get the data from read
            guard let budget = doc.data()?["budget"] as? [String:Double] else {
                let error = NSError(
                    domain: "AppErrorDomain",
                    code: -1,
                    userInfo: [
                        NSLocalizedDescriptionKey: "Unable to retrieve budget from snapshot \(doc)"
                    ]
                )
                errorPointer?.pointee = error
                return nil
            }
            // do logic with data
            let budgetAmount:Double=budget[self.type]!
            guard budgetAmount >= self.cost else {
                let error = NSError(
                    domain: "AppErrorDomain",
                    code: -2,
                    userInfo: [NSLocalizedDescriptionKey: "Insufficient Budget $\(budgetAmount). Need $\(self.cost-budgetAmount) more budget."]
                )
                errorPointer?.pointee = error
                return nil
            }
            // write data (set,update,delete.etc)
            transaction.updateData(["budget.\(self.type)":budgetAmount-self.cost], forDocument: userRef)
            transaction.setData([
                "item":self.item,
                "cost":self.cost,
                "type":self.type,
                "datetime":self.datetime,
                "uid":uid
            ], forDocument: transactionRef)
            return budgetAmount-self.cost
        } completion: { object, error in
            if let error=error {
                self.alert(error.localizedDescription)
            }
            else {
                self.alert("Transaction Successful, Budget Left: $\(object as! Double)")
            }
        }

    }
}
