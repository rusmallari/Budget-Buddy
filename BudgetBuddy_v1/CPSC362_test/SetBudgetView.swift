//
//  SetBudgetView.swift
//  CPSC362_test
//
//  Created by csuftitan on 10/7/23.
//
import SwiftUI

struct SetBudgetView: View {
    @StateObject var viewModel:SetBudgetViewViewModel
    
    init(_ currentBudget:[String:Double]){
        _viewModel=StateObject(wrappedValue: SetBudgetViewViewModel(currentBudget))
    }

    var body: some View {
        Form {
            ForEach(types, id: \.self) { type in
                Section(header: Text(type)) {
                    TextField("Enter budget for \(type)", value: Binding(
                        get: { viewModel.budget[type] ?? 0 },
                        set: { newValue in
                            viewModel.budget[type] = Double(newValue)
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
            Button("Set budget") {
                viewModel.setBudget()
            }
            .alert(viewModel.alertMessage,isPresented: $viewModel.isAlert){}
        }
        .navigationTitle("Set Budget")
    }
}

struct SetBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        SetBudgetView(Dictionary(uniqueKeysWithValues: types.map{($0,0)}))
    }
}
