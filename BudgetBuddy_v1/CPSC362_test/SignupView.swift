//
//  SignupView.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/2/23.
//
import SwiftUI

struct SignupView: View {
    @StateObject var viewModel=SignupViewViewModel()
    
    var body: some View {
        VStack {
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                // Simulate signup success for demonstration purposes
                viewModel.signup()
            }) {
                Text("Sign up")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Text(viewModel.message)
                .multilineTextAlignment(.center)
                .padding()
                .foregroundColor(viewModel.isError ? .red : .green)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Sign Up")
    }
}


struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
