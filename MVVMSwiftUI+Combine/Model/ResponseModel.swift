//
//  ResponseModel.swift
//  MVVMSwiftUI+Combine
//
//  Created by Manoj Shivhare on 13/06/24.
//

import Foundation

struct ResponseModel: Codable,Identifiable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
