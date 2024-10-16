//
//  APIManager.swift
//  ConcurrencySwift
//
//  Created by Priyanka on 16/10/24.
//

import Foundation

protocol APIService {
    func fetchData<T: Decodable>(from urlString: String) async throws -> T
}

class APIManager: APIService {
    
    private let decoder: DataDecoder
    
    init(decoder: DataDecoder = JSONDataDecoder()) {
        self.decoder = decoder
    }
    
    func fetchData<T: Decodable>(from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let decodedData: T = try decoder.decode(data)
        
        return decodedData
    }
    
    
//    func fetchData() async throws -> [UserData] {
//        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else {
//            throw URLError(.badURL)
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        let (data, _) = try await URLSession.shared.data(for: request)
//        let decodedData = try JSONDecoder().decode([UserData].self, from: data)
//        
//        return decodedData
//    }
    
}

protocol DataDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

class JSONDataDecoder: DataDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}

struct UserData: Codable {
    let userID, id: Int
    let title: String
    let completed: Bool

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, completed
    }
}
