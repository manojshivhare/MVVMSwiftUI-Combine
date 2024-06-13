//
//  ResponseError.swift
//  MVVMSwiftUI+Combine
//
//  Created by Manoj Shivhare on 13/06/24.
//

import Foundation

enum ResponseError: Error{
    case networkError(description: String)
    case parsingError(description: String)
}
