//
//  BudgetView.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/2/23.
//

import SwiftUI
import Charts

struct BudgetView: View {
    @ObservedObject private var viewModel:DataManager
    
    init(_ dataManager:DataManager){
        viewModel=dataManager
    }
    
    var body: some View {
        ZStack{
            NavigationView {
                List(TYPES,id: \.description){ type in
                    Section(type) {
                        Chart {
                            BarMark(
                                x: .value("Amount", viewModel.transactions.filter({$0.datetime.month()==Date().month()}).sum(type)),
                                y: .value("", "")
                            )
                            .annotation{
                                Text("$\(viewModel.transactions.filter({$0.datetime.month()==Date().month()}).sum(type), specifier: "%.2f")")
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
                        .chartXScale(domain: [0,viewModel.transactions.filter({$0.datetime.month()==Date().month()}).sum(type)+viewModel.budget[type]!])
                        .frame(height: 50.0)
                        
                        HStack{
                            Text("Spent")
                            Spacer()
                            Text(String(format: "$%.2f", viewModel.transactions.sum(type)))
                        }
                        HStack{
                            Text("Budget left")
                            Spacer()
                            Text(String(format: "$%.2f", viewModel.budget[type]!))
                        }
                    }
                }
                .refreshable(action: {
                    viewModel.getTransactions()
                    viewModel.getBudget()
                })
                .navigationTitle("Budget")
                .toolbar{
                    NavigationLink( destination: SetBudgetView(viewModel.budget,viewModel.getBudget)){
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
            BudgetView(DataManager())
        }
    }
}
