import FirebaseFirestore
import FirebaseAuth
import Foundation

class AddTransactionViewViewModel: ObservableObject {
    @Published var item: String = ""
    @Published var costStr: String = ""
    @Published var cost: Float = 0
    @Published var type: String = "Choose Type"
    @Published var datetime: Date = Date()
    //let presetTypes = ["Choose Type", "Groceries", "Food", "Entertainment", "Shopping", "Transportation", "School", "Savings"]
    
    init() {}
    
    func log() {
        if let temp = Float(costStr) {
            cost = temp
            print("item=\(item), cost=\(cost), type=\(type)")
        } else {
            print("invalid float value: cost")
        }
    }
    
    func addTransaction() {
        log()
        if let uid = Auth.auth().currentUser?.uid {
            print("uid: \(uid)")
            let db = Firestore.firestore()
            let colRef = db.collection("transactions")
            let data = [
                "item": item,
                "cost": cost,
                "type": type,
                "datetime": datetime,
                "uid": uid
            ] as [String : Any]
            var docRef: DocumentReference? = nil
            docRef = colRef.addDocument(data: data) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(docRef!.documentID)")
                }
            }
        } else {
            print("no user logged in")
        }
    }
}
