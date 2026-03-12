//
//  SetBudgetViewViewModel.swift
//  CPSC362_test
//
//  Created by csuftitan on 10/11/23.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation

class SetBudgetViewViewModel: ObservableObject{
    @Published var budget: [String: Double]
    @Published var isAlert:Bool=false
    @Published var alertMessage:String=""
    
    var refreshBudgetPage:()->Void
    
    init(_ currentBudget:[String:Double],_ refreshBudgetPage:@escaping ()->Void){
        self.budget=currentBudget
        self.refreshBudgetPage=refreshBudgetPage
    }

    func alert(_ message:String){
        alertMessage=message
        isAlert=true
    }
    
    func isValid()->Bool{
        for type in TYPES {
            if budget[type]!<0 {
                return false
            }
        }
        return true
    }

    func setBudget(){
        guard let uid=Auth.auth().currentUser?.uid else {
            print("error getting uid")
            return
        }
        
        guard isValid() else {
            alert("Invalid Input")
            return
        }

        let docRef=Firestore.firestore().collection("users").document(uid)
        docRef.updateData(["budget":budget]) { error in
            if let error = error {
                self.alert(error.localizedDescription)
            } else {
                self.alert("Budget successfully updated")
                self.refreshBudgetPage()
            }
        }
    }
}
