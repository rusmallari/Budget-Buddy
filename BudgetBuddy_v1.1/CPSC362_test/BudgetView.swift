//
//  BudgetView.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/2/23.
//

import SwiftUI
import Charts

struct BudgetView: View {
    @StateObject private var viewModel:BudgetViewViewModel=BudgetViewViewModel()
    var budget:[String:Double]=Dictionary(uniqueKeysWithValues: types.map{($0,0)})
    
    var body: some View {
        ZStack{
            NavigationView {
                List(){
                    ForEach(types,id: \.description){ type in
                        Section(type) {
                            Chart {
                                BarMark(
                                    x: .value("Amount", viewModel.sum[type]!),
                                    y: .value("", "")
                                )
                                .annotation{
                                    Text("$\(viewModel.sum[type]!, specifier: "%.2f")")
                                }
                                .foregroundStyle(.linearGradient(colors:[.green,.mint], startPoint: .leading, endPoint: .trailing))
                                BarMark(
                                    x: .value("Amount", viewModel.budget[type]!),
                                    y: .value("", "")
                                )
                                .annotation{
                                    Text("$\(viewModel.budget[type]!, specifier: "%.2f")")
                                }
                            }
                            .padding(.horizontal)
                            .chartXScale(domain: [0,viewModel.sum[type]!+viewModel.budget[type]!])
                            .frame(height: 50.0)
                            
                            HStack{
                                Text("Spent")
                                Spacer()
                                Text(String(format: "$%.2f", viewModel.sum[type]!))
                            }
                            HStack{
                                Text("Budget left")
                                Spacer()
                                Text(String(format: "$%.2f", viewModel.budget[type]!))
                            }
                        }
                    }
                }
                .refreshable(action: {
                    viewModel.getSum()
                    viewModel.getBudget()
                })
                .navigationTitle("Budget")
                .toolbar{
                    NavigationLink( destination: SetBudgetView(viewModel.budget)){
                        Text("Set budget")
                    }
                }
                .scrollContentBackground(.hidden)
                .background(LinearGradient(gradient: Gradient(colors: [.mint, .white]), startPoint: .top, endPoint: .bottom))
            }
        }
    }
}

struct BudgetView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            BudgetView()
        }
    }
}
