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
        ZStack{
            Color.mint
                .ignoresSafeArea()
            Circle()
                .scale(1.55)
                .foregroundColor(.white.opacity(0.15))
            Circle()
                .scale(1.25)
                .foregroundColor(.white)
            VStack{
                Text("Add Transaction")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                TextField("Item", text: $viewModel.item)
                    .padding()
                    .frame(width: 275, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(125)
                TextField("Cost", text: $viewModel.costStr)
                    .keyboardType(.numberPad)
                    .padding()
                    .frame(width: 275, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(125)
                HStack{
                    Text("Type")
                        .padding(.horizontal)
                    Spacer()
                    Picker("Type", selection: $viewModel.type) {
                        ForEach(types,id: \.description){
                            Text($0).tag($0)
                        }
                    }
                }
                .frame(width: 275, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(125)
                
                DatePicker("   Date",selection: $viewModel.datetime)
                    .frame(width: 275, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(125)
                Button(action: {
                    viewModel.addTransaction()
                }) {
                    Text("Add")
                        .padding()
                        .frame(width: 275, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(125)
                }
            }
            .alert(viewModel.alertMessage, isPresented: $viewModel.isAlert) {}
            .navigationTitle("Add Transaction")
        }
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView()
    }
}
