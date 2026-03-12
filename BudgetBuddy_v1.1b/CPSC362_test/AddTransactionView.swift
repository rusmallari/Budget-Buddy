//
//  AddTransactionView.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/8/23.
//

import SwiftUI

struct AddTransactionView: View{
    @StateObject var viewModel:AddTransactionViewViewModel
    
    init(_ refreshTransactionPage:@escaping ()->Void){
        _viewModel=StateObject(wrappedValue: AddTransactionViewViewModel(refreshTransactionPage))
    }
    
    var body: some View{
        VStack{
            TextField("Item", text: $viewModel.item)
                .padding()
                .frame(width: 290, height: 50)
                .background(Color.white.opacity(0.5))
                .cornerRadius(125)
            TextField("Cost", text: $viewModel.costStr)
                .keyboardType(.numberPad)
                .padding()
                .frame(width: 290, height: 50)
                .background(Color.white.opacity(0.5))
                .cornerRadius(125)
            HStack{
                Text("Type")
                    .padding(.horizontal)
                Spacer()
                Picker("Type", selection: $viewModel.type) {
                    ForEach(TYPES,id: \.description){
                        Text($0).tag($0)
                    }
                }
            }
            .frame(width: 290, height: 50)
            .background(Color.white.opacity(0.5))
            .cornerRadius(125)
            
            DatePicker(selection: $viewModel.datetime) {
                Text("Date")
                    .padding(.leading)
            }
            .frame(width: 290, height: 50)
            .background(Color.white.opacity(0.5))
            .cornerRadius(125)
            
            Button(action: {
                viewModel.addTransaction()
            }) {
                Text("Add")
                    .padding()
                    .foregroundColor(.white)
                    .frame(width: 290, height: 40)
                    .background(Color.mint)
                    .cornerRadius(125)
            }
            .alert(viewModel.alertMessage, isPresented: $viewModel.isAlert) {}
            Spacer()
            HStack{Spacer()}
        }
        .navigationTitle("Add Transaction")
        .background(LinearGradient(gradient: Gradient(colors: [.mint, .white]), startPoint: .top, endPoint: .bottom))
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView({
            print("refresh")
        })
    }
}
