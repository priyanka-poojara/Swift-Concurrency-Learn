//
//  viewModel.swift
//  ConcurrencySwift
//
//  Created by Priyanka on 16/10/24.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var todos: [UserData] = []
    @Published var errorMessage: String? = nil
    
    private let apiService: APIService
    
    init(apiService: APIService = APIManager()) {
        self.apiService = apiService
    }
    
    func fetchTodo() async {
        do {
            let todos: [UserData] = try await apiService.fetchData(from: "https://jsonplaceholder.typicode.com/todos")
            
            DispatchQueue.main.async {
                self.todos = todos
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
        
    }
}
