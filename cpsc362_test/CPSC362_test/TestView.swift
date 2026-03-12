//
//  TestView.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/3/23.
//

import SwiftUI
import Charts

struct TestView: View {
    @StateObject var viewModel=TestViewViewModel()
    var body: some View {
        Button("test") {
            viewModel.g2()
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
