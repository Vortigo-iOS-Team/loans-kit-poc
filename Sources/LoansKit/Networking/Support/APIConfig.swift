//
//  APIConfig.swift
//  LoansKit
//
//  Created by Douglas Pfeifer on 24/09/22.
//

import Foundation

internal struct APIConfig {
    private static let mockBearerToken = ""
    private static let mockXCountry = "AR"
    
    internal enum RequestHeaders {
        case basic
    }
    
    internal static func request(with url: URL, headerType: RequestHeaders) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue(mockBearerToken, forHTTPHeaderField: "Authorization") // PersonInfo.shared.jwtToken
        request.setValue(mockXCountry, forHTTPHeaderField: "x-country") // AppContextHelper.share.getDefaultCountryCode().rawValue
        
        switch headerType {
        case .basic:
            return request
        }
    }
}
