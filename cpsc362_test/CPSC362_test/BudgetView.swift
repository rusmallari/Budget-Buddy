//
//  BudgetView.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/2/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct BudgetView: View {
    @StateObject private var viewModel: BudgetViewViewModel = BudgetViewViewModel()
    @State private var budget: [String: Float] = Dictionary(uniqueKeysWithValues: types.map { ($0, 0) })

    var body: some View {
        NavigationView {
            List(types.dropFirst(), id: \.description) { type in
                Section(type) {
                    Text(String(format: "spent: $%.2f", viewModel.sum[type]!))
                    Text(String(format: "budget: $%.2f", budget[type]!))
                }
            }
            .navigationTitle("Budget")
            .toolbar {
                NavigationLink(destination: SetBudgetView(budget: $budget)) {
                    Text("Set budget")
                }
            }
        }
    }
}

struct SetBudgetView: View {
    @Binding var budget: [String: Float]

    var body: some View {
        Form {
            ForEach(types.dropFirst(), id: \.self) { type in
                Section(header: Text(type)) {
                    TextField("Enter budget for \(type)", value: Binding(
                        get: { budget[type] ?? 0 },
                        set: { newValue in
                            budget[type] = Float(newValue)
                        }
                    ), formatter: {
                        let formatter = NumberFormatter()
                        formatter.numberStyle = .decimal
                        formatter.minimumFractionDigits = 2
                        return formatter
                    } ())
                    .keyboardType(.decimalPad)
                }
            }
        }
        .navigationTitle("Set Budget")
        Button("Set budget") {
            guard let uid = Auth.auth().currentUser?.uid else {
                print("User not authenticated")
                return
            }
            
            let db = Firestore.firestore()
            var budgetData: [String: Float] = [:]
                for (budgetType, amount) in budget {
                    budgetData[budgetType] = amount
                }
                let budgetItem: [String: Any] = [
                    "uid": uid,
                    "budgetData": budgetData
                ]
                        
                db.collection("budgets").addDocument(data: budgetItem) { error in
                    if let error = error {
                        print("Error saving budget: \(error.localizedDescription)")
                } else {
                    print("Budget data saved")
                }
            }
        }
    }
}

struct BudgetView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            //SetBudgetView(budget: [
            //    "Food":0,
            //    "Entertainment":0,
            //    "Education":0,
            //    "Transportation":0,
            //    "Others":0
            //])
            BudgetView()
        }
    }
}
