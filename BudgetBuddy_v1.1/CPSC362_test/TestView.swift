//
//  TestView.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/3/23.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseAuth
import Charts

func randomDouble()->Double{
    let roundedString = String(format: "%.2f", Double.random(in: 100..<700))
    return Double(roundedString)!
}

let item:String="HamBurger"
let cost:Double=12
let type:String="Food"
let datetime:Date=Date()
func f(){
}

var testEntry:[User]=[]
struct TestView: View {
    //@StateObject var viewModel=BudgetViewViewModel()
    @State var testBool:Bool=false
    @State var testDate:Date=Date()
    @FirestoreQuery(collectionPath: "transactions",predicates: [.where("uid", isEqualTo: Auth.auth().currentUser?.uid ?? "")]) var transactions:[Transaction]
    var body: some View {
        List(transactions){ transaction in
            TransactionItemView(transaction: transaction)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
