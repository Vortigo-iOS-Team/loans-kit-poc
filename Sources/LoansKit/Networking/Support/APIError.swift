//
//  APIError.swift
//  LoansKit
//
//  Created by Douglas Pfeifer on 24/09/22.
//

import Foundation

internal struct APIError: Decodable, Equatable {
    internal struct APIErrorModel: Decodable, Equatable {
        static func == (lhs: APIErrorModel, rhs: APIErrorModel) -> Bool {
            lhs.errorCode == rhs.errorCode && lhs.message == rhs.message
        }
        
        internal var errorCode: String
        internal var message: String
    }
    
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        lhs.code == rhs.code && lhs.id == rhs.id &&
        lhs.message == rhs.message && lhs.errors == rhs.errors
    }
    
    internal var code: String
    internal var id: String
    internal var message: String
    internal var errors: [APIErrorModel]
    
    internal enum APIErrorType {
        case defaultError
        case authenticationError
        case reachabilityError
    }
    
    internal init(code: String,
                  id: String,
                  message: String,
                  errors: [APIErrorModel]) {
        self.code = code
        self.id = id
        self.message = message
        self.errors = errors
    }
    
    internal init(type: APIErrorType) {
        code = ""
        message = ""
        id = ""
        
        var errorModel = APIErrorModel(errorCode: "", message: "")
        
        switch type {
        case .defaultError:
            errorModel.message = "defaultError"
        case .reachabilityError:
            errorModel.message = "reachabilityError"
        case .authenticationError:
            errorModel.message = "authenticationError"
        }
        
        errors = [errorModel]
    }
}
