//
//  Environment.swift
//  LoansKit
//
//  Created by Douglas Pfeifer on 24/09/22.
//

import Foundation

internal struct Environment {
    internal enum EnvironmentType {
        case dev
        case pre
    }
    
    internal enum Endpoint {
        case tutorial
    }
    
    internal static func getUrl(for endpoint: Endpoint, _ environment: EnvironmentType) -> URL {
        var urlString = getBaseUrl(for: environment)
        switch endpoint {
        case .tutorial:
            urlString += "/crd-loan/v1/loan/persons/tutorial"
        }
        return URL(string: urlString)!
    }
    
    private static func getBaseUrl(for environment: EnvironmentType) -> String {
        switch environment {
        case .dev:
            return "https://liveapi.dev.gruposuperdigital.com"
        case .pre:
            return "https://live.apis.pre.gruposuperdigital.com"
        }
    }
}
