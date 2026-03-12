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
    //@Published var sum:[String:Double]=Dictionary(uniqueKeysWithValues: types.map{($0,0)})
    
    @Published var type:String="All"
    @Published var graphType:String="Category"
    
    init(){
        getTransactions()
    }
    
    func getTransactions(){
        self.transactions.removeAll()
        //for type in sum.keys { sum[type]=0 }
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
                        //self.sum[transaction.type]!+=transaction.cost
                    } catch {
                        print(error)
                    }
                }
                print("getDocument success")
            }
        }
    }
}
