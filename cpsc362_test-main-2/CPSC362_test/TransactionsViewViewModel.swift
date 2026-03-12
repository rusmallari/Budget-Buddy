//
//  TransactionsViewViewModel.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/9/23.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation

class TransactionsViewViewModel: ObservableObject {
    @Published var transactions:[Transaction]=[]
    
    @Published var type:String="All"
    @Published var dateFrom=Date(timeIntervalSince1970: 0)
    @Published var dateTo=Date()
    @Published var graphType:String="Category"
    
    init(){
        getTransactions()
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
                print("getDocument success")
            }
        }
    }
}
