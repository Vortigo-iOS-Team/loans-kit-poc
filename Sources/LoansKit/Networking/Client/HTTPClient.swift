//
//  HTTPClient.swift
//  LoansKit
//
//  Created by Douglas Pfeifer on 24/09/22.
//

import Foundation

internal enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

internal protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
