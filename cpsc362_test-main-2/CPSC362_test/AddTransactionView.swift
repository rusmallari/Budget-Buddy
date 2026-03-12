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
        NavigationView{
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
                        .padding()
                        .frame(width: 275, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(125)
                    TextField("Type", text: $viewModel.type)
                        .padding()
                        .frame(width: 275, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(125)
                    DatePicker("Date",selection: $viewModel.datetime)
                    Button(action: {
                        viewModel.addTransaction()
                    }) {
                        Text("Add")
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 275, height: 40)
                            .background(Color.mint)
                            .cornerRadius(125)
                    }
                }
                .padding()
            }
        }
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView()
    }
}
