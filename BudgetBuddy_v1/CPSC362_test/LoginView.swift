//
//  LoginView.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/2/23.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel=LoginViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    viewModel.login()
                }) {
                    Text("Log in")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                NavigationLink("Need an account? Sign in", destination: SignupView())
                
                if viewModel.isError {
                    Text(viewModel.message)
                        .multilineTextAlignment(.center)
                        .padding()
                        .foregroundColor(.red)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Login")
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
