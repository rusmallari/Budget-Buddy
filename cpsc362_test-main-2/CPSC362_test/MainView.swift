//
//  MainView.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/8/23.
//

import SwiftUI
import FirebaseAuth

class MainViewViewModel: ObservableObject {
    @Published var currentUserId=""
    private var handler:AuthStateDidChangeListenerHandle?
    init(){
        handler = Auth.auth().addStateDidChangeListener({ [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        })
    }
    public var isLoggedIn:Bool {
        return Auth.auth().currentUser != nil
    }
}

struct MainView: View {
    @StateObject var viewModel:MainViewViewModel=MainViewViewModel()
    var body: some View {
        if viewModel.isLoggedIn, !viewModel.currentUserId.isEmpty {
            HomeView()
        }
        else {
            LoginView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
