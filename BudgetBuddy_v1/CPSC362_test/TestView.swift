//
//  TestView.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/3/23.
//

import SwiftUI
import FirebaseFirestore
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
    let uid="vLX8IuYanAf2TUg7yjfqG1BR98y1"
    
    Firestore.firestore().collection("users").document(uid).setData([
        "budget":Dictionary(uniqueKeysWithValues: types.map{($0,0)}),
        "uid":uid
    ])
    print("User created: \(uid)")
}

var testEntry:[User]=[]
struct TestView: View {
    //@StateObject var viewModel=BudgetViewViewModel()
    @State var testBool:Bool=false
    @State var testDate:Date=Date()
    var body: some View {
        VStack{
            Button("test"){
                f()
            }
            Button("show uid"){
                guard let uid=Auth.auth().currentUser?.uid else {
                    print("no uid")
                    return
                }
                print(uid)
            }
            DatePicker("a date", selection: $testDate).padding()
            Text(Date().formatted())
            Text(String(testDate.year()))
            Text(String(testDate.month()))
            Text(String(testDate.day()))
        }
        .alert("test alert", isPresented: $testBool) {}
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
