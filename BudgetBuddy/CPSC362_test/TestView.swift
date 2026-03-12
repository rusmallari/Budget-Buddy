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

struct TestView: View {
    //@StateObject var viewModel=BudgetViewViewModel()
    @State var testBool:Bool=false
    @State var testDate:Date=Date()
    @State var testInt:Int=1
    
    @FirestoreQuery(collectionPath: "transactions",predicates: [.where("uid", isEqualTo: Auth.auth().currentUser?.uid ?? "")]) var transactions:[Transaction]
    
    var body: some View {
        VStack{
            Text(String(transactions.sum("Food")))
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
