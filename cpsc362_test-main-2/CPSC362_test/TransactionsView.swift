//
//  TransactionsView.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/2/23.
//

import SwiftUI
import Charts

struct TransactionsView: View {
    @StateObject var viewModel:TransactionsViewViewModel=TransactionsViewViewModel()
    
    var body: some View {
        NavigationView(){
                VStack{
                    List {
                        Section("Graph"){
                            Picker("Graph", selection: $viewModel.graphType) {
                                Text("Category").tag("Category")
                                Text("Month").tag("Month")
                            }
                            .pickerStyle(.segmented)
                            
                            if viewModel.graphType=="Category" {
                                Chart(viewModel.transactions){
                                    BarMark(
                                        x: .value("Type", $0.type),
                                        y: .value("Cost", $0.cost)
                                    )
                                    .foregroundStyle(.linearGradient(colors:[.green,.mint], startPoint: .bottom, endPoint: .top))
                                    .alignsMarkStylesWithPlotArea()
                                    
                                }
                                .padding()
                                .aspectRatio(2, contentMode: .fit)
                            }
                            
                            if viewModel.graphType=="Month" {
                                Chart(viewModel.transactions){
                                    BarMark(
                                        x: .value("Date", $0.datetime, unit: .month),
                                        y: .value("Cost", $0.cost)
                                    )
                                    .foregroundStyle(.linearGradient(colors:[.green,.mint], startPoint: .bottom, endPoint: .top))
                                    .alignsMarkStylesWithPlotArea()  }
                                .padding()
                                .aspectRatio(2, contentMode: .fit)
                            }
                        }
                        
                        Section("Filter"){
                            Picker("Category", selection: $viewModel.type) {
                                Text("All").tag("All")
                                ForEach(types,id: \.description){
                                    Text($0).tag($0)
                                }
                            }
                            DatePicker("From",selection: $viewModel.dateFrom)
                            DatePicker("To",selection: $viewModel.dateTo)
                        }
                        
                        Section("Transactions"){
                            ForEach(viewModel.transactions){
                                if(viewModel.dateFrom<=$0.datetime && $0.datetime<=viewModel.dateTo){
                                    if(viewModel.type=="All") {
                                        TransactionItemView(transaction: $0)
                                    } else {
                                        if($0.type==viewModel.type) {
                                            TransactionItemView(transaction: $0)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .refreshable {
                        viewModel.getTransactions()
                    }
                }
                .navigationTitle("Transactions")
                .toolbar{
                    NavigationLink( destination: AddTransactionView()){
                        Text("add transaction")
                    }
                }
            }
        }
    }
    struct TransactionsView_Previews: PreviewProvider {
        static var previews: some View {
            TransactionsView()
        }
    }
