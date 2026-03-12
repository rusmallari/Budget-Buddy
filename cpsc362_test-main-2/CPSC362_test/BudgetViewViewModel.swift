//
//  BudgetViewViewModel.swift
//  CPSC362_test
//
//  Created by csuftitan on 9/28/23.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation

class BudgetViewViewModel: ObservableObject{
    @Published var sum:[String:Float]=Dictionary(uniqueKeysWithValues: types.map{($0,0)})
    @Published var total=0
    
    init(){
        getBudget()
    }
    
    func getBudget(){
        for type in sum.keys { sum[type]=0 }
        guard let uid=Auth.auth().currentUser?.uid else {
            print("no one is logged in???")
            return
        }
        let db=Firestore.firestore()
        let query=db
            .collection("transactions")
            .whereField("uid", isEqualTo: uid)
            .order(by: "datetime",descending: true)
        query.getDocuments() { (querySnapshot, error) in
            if let error=error {
                print("Error getDocuments: \(error)")
            }
            else {
                for doc in querySnapshot!.documents {
                    do {
                        let transaction=try doc.data(as: Transaction.self)
                        //print("xxx \(doc.data())")
                        if self.sum.keys.contains(transaction.type) {
                            self.sum[transaction.type]!+=transaction.cost
                        }
                        else {
                            self.sum["Others"]!+=transaction.cost
                        }
                    } catch {
                        print(error)
                    }
                }
                print("getBudget success")
            }
        }
    }
}
