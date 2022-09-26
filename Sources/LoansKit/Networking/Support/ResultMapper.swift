//
//  ResultMapper.swift
//  LoansKit
//
//  Created by Douglas Pfeifer on 24/09/22.
//

import Foundation

internal struct ResultMapper {
    internal static func map<T: Decodable>(_ data: Data, from response: HTTPURLResponse, to type: T.Type) -> ServiceResult {
        if response.statusCode == 200,
           let result = try? JSONDecoder().decode(T.self, from: data) {
            return .success(result)
        } else if response.statusCode == 200,
                  let apiError = try? JSONDecoder().decode(APIError.self, from: data) {
            return .success(apiError)
        }
        return .failure(APIError(type: .defaultError))
    }
    
    internal static func map(_ error: NSError) -> ServiceResult {
        switch error.code {
        case 401:
            return .failure(APIError(type: .authenticationError))
        case 404:
            return .failure(APIError(type: .reachabilityError))
        default:
            return .failure(APIError(type: .defaultError))
        }
    }
}
