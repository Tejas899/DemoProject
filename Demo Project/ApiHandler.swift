//
//  ApiHandler.swift
//  Demo Project
//
//  Created by Tejas Kashyap on 10/11/23.
//

import Foundation
import Combine
import SwiftUI


struct CourseData: Codable {
    let status: String
    var branches: [Branch]
}

// MARK: - Branch
struct Branch: Codable {
    let id: Int
    var name, short: String
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case short = "short"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        short = try container.decodeIfPresent(String.self, forKey: .short) ?? ""
    }
}

class UsersViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    let apiHandler =  ApiHandler()
   @Published var courseData: CourseData = CourseData(status: "", branches: [])
    
    func fetchUsers() {
        apiHandler.request(ofType: CourseData.self, Apidata(url: URL(string: "https://api.msigma.in/btech/v2/branches")!, method: .get))
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .failure(let error): print("Api request failed: \(error)")
                case .finished: print("Publisher is finished")
                }
            }, receiveValue: {[weak self] data in
                self?.courseData = data
                
            }).store(in: &cancellables)
        
    }
}



class ApiHandler {
    
    
    func request <T: Codable>(ofType type: T.Type, _ apiData: Apidata) -> AnyPublisher<T, Error>{
        var request = URLRequest(url: apiData.url)
        request.httpMethod = apiData.method.rawValue
        
        apiData.headers?.forEach { request.addValue($0.value as! String, forHTTPHeaderField: $0.key) }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw APIError.invalidResponse
                }
                return data
            }
            .decode(type: type, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}





struct Apidata {
    var url: URL
    var headers: [String: Any]?
    var parameters: [String: Any]?
    var method: HTTPMethod
    
}


protocol APIEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum APIError: Error {
    case invalidResponse
    case invalidData
}
