//
//  LoginView.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/2/23.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @StateObject var viewModel=LoginViewViewModel()
    
    var body: some View {
        NavigationView {
            ZStack{
                Color.mint.ignoresSafeArea()
                Circle()
                    .scale(1.55)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.25)
                    .foregroundColor(.white)
                
                VStack {
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    TextField("Email", text: $viewModel.email)
                        .padding()
                        .frame(width: 250, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(125)
                    
                    SecureField("Password", text: $viewModel.password)
                        .padding()
                        .frame(width: 250, height: 40)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(125)
                    
                    Button(action: {
                        viewModel.login()
                    }) {
                        Text("Log in")
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 250, height: 40)
                            .background(Color.mint)
                            .cornerRadius(125)
                    }
                    NavigationLink("Need an account? Sign in", destination: SignupView())
                    NavigationLink(destination: HomeView()) {
                        Text("Home")
                    }
                    
                    if viewModel.isError {
                        Text(viewModel.message)
                            .multilineTextAlignment(.center)
                            .padding()
                            .foregroundColor(.red)
                    }
                }
                .navigationBarBackButtonHidden(true)
                .padding()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
