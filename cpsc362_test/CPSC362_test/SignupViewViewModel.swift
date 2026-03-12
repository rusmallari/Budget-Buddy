//
//  SignupViewViewModel.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/8/23.
//

import FirebaseAuth
import Foundation

class SignupViewViewModel: ObservableObject{
    @Published var email:String=""
    @Published var password:String=""
    @Published var message:String=""
    @Published var isError:Bool=false
    
    init(){}
    
    func signup(){
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                // Handle the error (e.g., display an error message)
                self.isError=true
                self.message=error.localizedDescription
                print("Error creating user: \(error.localizedDescription)")
            } else if let user = authResult?.user {
                // User account was successfully created
                self.isError=false
                self.message="user created: \(self.email)"
                print("User created: \(user.uid)")
            }
        }
    }
}
