//
//  URLSessionHTTPClient.swift
//  LoansKit
//
//  Created by Douglas Pfeifer on 24/09/22.
//

import Foundation

internal class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    
    internal init(session: URLSession = .shared) {
        self.session = session
    }
    
    private struct UnexpectedValuesRepresentation: Error {}
    
    internal func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        let request = APIConfig.request(with: url, headerType: .basic)
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data,
                      let response = response as? HTTPURLResponse {
                completion(.success(data, response))
            } else {
                completion(.failure(UnexpectedValuesRepresentation()))
            }
        }.resume()
    }
}
