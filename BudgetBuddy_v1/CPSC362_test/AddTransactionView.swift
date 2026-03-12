//
//  AddTransactionView.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/8/23.
//

import SwiftUI

struct AddTransactionView: View{
    @StateObject var viewModel=AddTransactionViewViewModel()
    var body: some View{
        Form{
            TextField("Item", text: $viewModel.item)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Cost", text: $viewModel.costStr)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Picker("Type", selection: $viewModel.type) {
                ForEach(types,id: \.description){
                    Text($0).tag($0)
                }
            }
            .pickerStyle(.automatic)
            
            DatePicker("Date",selection: $viewModel.datetime)
            Button(action: {
                viewModel.addTransaction()
            }) {
                Text("Add")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .alert(viewModel.alertMessage, isPresented: $viewModel.isAlert) {}
        .navigationTitle("Add Transaction")
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView()
    }
}
