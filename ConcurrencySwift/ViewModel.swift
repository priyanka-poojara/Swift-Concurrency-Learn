//
//  viewModel.swift
//  ConcurrencySwift
//
//  Created by Priyanka on 16/10/24.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var todos: [UserData] = []
    @Published var errorMessage: String? = nil
    
    private let apiService: APIService
    
    init(apiService: APIService = APIManager()) {
        self.apiService = apiService
    }
    
    @MainActor
    func fetchTodo() async {
        do {
            let todos: [UserData] = try await apiService.fetchData(from: "https://jsonplaceholder.typicode.com/todos")
            self.todos = todos
        } catch {
            self.errorMessage = error.localizedDescription
        }
        
    }
}
