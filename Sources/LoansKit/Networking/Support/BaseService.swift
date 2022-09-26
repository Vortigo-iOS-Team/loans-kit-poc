//
//  BaseService.swift
//  LoansKit
//
//  Created by Douglas Pfeifer on 24/09/22.
//

import Foundation

internal enum ServiceResult {
    case success(Decodable)
    case failure(APIError)
}

internal class BaseService {
    internal typealias Result = ServiceResult
}
