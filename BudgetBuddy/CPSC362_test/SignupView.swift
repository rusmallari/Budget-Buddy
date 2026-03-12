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
        ZStack{
            Color.mint.ignoresSafeArea()
            Circle()
                .scale(1.55)
                .foregroundColor(.white.opacity(0.15))
            Circle()
                .scale(1.25)
                .foregroundColor(.white)
            
            VStack {
                Text("Sign Up")
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
                    .frame(width: 250, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(125)
                
                Button(action: {
                    // Simulate signup success for demonstration purposes
                    viewModel.signup()
                }) {
                    Text("Sign up")
                        .padding()
                        .foregroundColor(.white)
                        .frame(width: 250, height: 40)
                        .background(Color.mint)
                        .cornerRadius(125)
                }
                Text(viewModel.message)
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(viewModel.isError ? .red : .green)
                
            }
            .padding()
        }
    }
}


struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
