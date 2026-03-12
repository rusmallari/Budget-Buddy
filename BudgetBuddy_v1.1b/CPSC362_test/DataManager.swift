//
//  DataManager.swift
//  CPSC362_test
//
//  Created by csuftitan on 10/14/23.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class DataManager: ObservableObject{
    @Published var transactions:[Transaction]=[]
    @Published var budget:[String:Double]=Dictionary(uniqueKeysWithValues: TYPES.map{($0,0)})
    
    // for transaction page
    @Published var type:String="All"
    @Published var graphType:String="Category"
    
    init(){
        refresh()
    }
    
    func refresh(){
        getTransactions()
        getBudget()
    }
    
    func getTransactions(){
        self.transactions.removeAll()
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
                        self.transactions.append(transaction)
                    } catch {
                        print(error)
                    }
                }
                print("getTransaction success")
            }
        }
    }
    
    func getBudget(){
        guard let uid=Auth.auth().currentUser?.uid else {
            print("no one is logged in???")
            return
        }
        
        let db=Firestore.firestore()
        let docRef=db.collection("users").document(uid)
        docRef.getDocument { document, error in
            if let error=error {
                print(error.localizedDescription)
            }
            do {
                if let budget = try document?.data(as: User.self).budget {
                    self.budget=budget
                    print("getBudget success")
                }
            } catch {
                print("getBudget error: codable conversion")
            }
        }
    }
}
