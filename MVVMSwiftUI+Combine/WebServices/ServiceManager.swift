//
//  ServiceManager.swift
//  MVVMSwiftUI+Combine
//
//  Created by Manoj Shivhare on 13/06/24.
//

import Foundation
import Combine

class ServiceManager {
    
    var cancellable = Set<AnyCancellable>()
    
    func getServiceData() -> Future<[ResponseModel], ResponseError>{
        return Future{ promise in
            
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else{
                return promise(.failure(.networkError(description: "Invalid url")))
            }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .tryMap { (data, response) in
                    guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                        throw ResponseError.networkError(description: "Invalid response")
                    }
                     
                    return data
                }
                .decode(type: [ResponseModel].self, decoder: JSONDecoder())
                .sink { completion in
                    if case let .failure(error) = completion{
                        switch error{
                        case _ as DecodingError:
                            return promise(.failure(.parsingError(description: "Failed to decode date")))
                        default:
                            return promise(.failure(.parsingError(description: "Failde to get data")))
                        }
                    }
                } receiveValue: { response in
                    return promise(.success(response))
                }
                .store(in: &self.cancellable)

        }
    }
}
