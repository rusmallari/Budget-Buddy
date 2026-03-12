//
//  SetBudgetView.swift
//  CPSC362_test
//
//  Created by csuftitan on 10/7/23.
//
import SwiftUI

struct SetBudgetView: View {
    @StateObject var viewModel:SetBudgetViewViewModel
    
    init(_ currentBudget:[String:Double],_ refreshBudgetPage:@escaping ()->Void){
        _viewModel=StateObject(wrappedValue: SetBudgetViewViewModel(currentBudget,refreshBudgetPage))
    }
    
    var body: some View {
        VStack{
            ForEach(TYPES, id: \.self) { type in
                HStack{
                    Text(type)
                    Spacer()
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
                    .padding()
                    .frame(width: 175, height: 50)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(125)
                    .keyboardType(.decimalPad)
                }
            }
            .padding(.horizontal)
            Button(action: viewModel.setBudget) {
                Text("Set Budget")
                    .padding()
                    .foregroundColor(.white)
                    .frame(width: 250, height: 40)
                    .background(Color.mint)
                    .cornerRadius(125)
            }
            .padding()
            .alert(viewModel.alertMessage,isPresented: $viewModel.isAlert){}
            Spacer()
        }
        .navigationTitle("Set Budget")
        .background(LinearGradient(gradient: Gradient(colors: [.mint, .white]), startPoint: .top, endPoint: .bottom))
    }
}

struct SetBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        SetBudgetView(Dictionary(uniqueKeysWithValues: TYPES.map{($0,0)}),{
            print("refresh")
        })
    }
}
