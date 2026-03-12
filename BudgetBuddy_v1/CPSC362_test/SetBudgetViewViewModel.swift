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
    
    init(_ currentBudget:[String:Double]){
        budget=currentBudget
    }

    func alert(_ message:String){
        alertMessage=message
        isAlert=true
    }

    func setBudget(){
        guard let uid=Auth.auth().currentUser?.uid else {
            print("error getting uid")
            return;
        }

        let docRef=Firestore.firestore().collection("users").document(uid)
        docRef.updateData(["budget":budget]) { error in
            if let error = error {
                self.alert("Error updating document: \(error)")
            } else {
                self.alert("Document successfully updated")
            }
        }
    }
}
