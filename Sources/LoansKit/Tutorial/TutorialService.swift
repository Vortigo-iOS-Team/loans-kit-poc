//
//  TutorialService.swift
//  LoansKit
//
//  Created by Douglas Pfeifer on 25/09/22.
//

import Foundation

internal class TutorialService: BaseService {
    private let baseUrl: URL
    private let client: HTTPClient
    
    internal init(client: HTTPClient = URLSessionHTTPClient()) {
        self.baseUrl = Environment.getUrl(for: .tutorial, .dev)
        self.client = client
    }
    
    internal func fetchTutorial(completion: @escaping (Result) -> Void) {
        client.get(from: baseUrl) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success(data, response):
                completion(ResultMapper.map(data, from: response, to: TutorialModel.self))
            case let .failure(error as NSError):
                completion(ResultMapper.map(error))
            }
        }
    }
}
