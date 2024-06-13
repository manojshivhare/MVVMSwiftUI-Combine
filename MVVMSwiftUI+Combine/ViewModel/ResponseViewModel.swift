//
//  ResponseViewModel.swift
//  MVVMSwiftUI+Combine
//
//  Created by Manoj Shivhare on 13/06/24.
//

import Foundation
import Combine

class ResponseViewModel: ObservableObject {
    
    @Published var arrayItems:[ResponseModel] = []
    var cancellable = Set<AnyCancellable>()
    var service:ServiceManager
    
    init(service: ServiceManager) {
        self.service = service
        getResponseData()
    }
    
    private func getResponseData(){
        service.getServiceData()
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print("error:", error.localizedDescription)
                case.finished: print("<<finished>>")
                }
            } receiveValue: {[weak self] response in
                self?.arrayItems = response
            }
            .store(in: &self.cancellable)
    }
}
