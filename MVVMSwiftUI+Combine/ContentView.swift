//
//  ContentView.swift
//  MVVMSwiftUI+Combine
//
//  Created by Manoj Shivhare on 13/06/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ResponseViewModel(service: ServiceManager())
    var body: some View {
        NavigationView{
            List(viewModel.arrayItems){ item in
                VStack(alignment: .leading){
                    Text(item.title)
                        .font(.headline)
                    Text(item.body)
                        .font(.subheadline)
                }
                .padding()
            }
            .navigationTitle("Content list")
        }
    }
}

#Preview {
    ContentView()
}
