//
//  ContentView.swift
//  ConcurrencySwift
//
//  Created by Priyanka on 16/10/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            
            List(viewModel.todos, id: \.id) { todo in
                VStack(alignment: .leading) {
                    Text(todo.title)
                        .font(.headline)
                    Text("Completed: \(todo.completed ? "Yes" : "No")")
                        .font(.subheadline)
                }
            }
            .navigationTitle("Todos")
            .task {
                await viewModel.fetchTodo()
            }
        }
    }
}

#Preview {
    ContentView()
}
