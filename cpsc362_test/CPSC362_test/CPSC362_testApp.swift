//
//  CPSC362_testApp.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/2/23.
//
import FirebaseCore
import SwiftUI

let types = ["Choose Type", "Groceries", "Food", "Entertainment", "Shopping", "Transportation", "School", "Savings"]

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct CPSC362_testApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
