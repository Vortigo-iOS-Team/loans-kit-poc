//
//  TutorialServiceTests.swift
//  LoansKitTests
//
//  Created by Douglas Pfeifer on 25/09/22.
//

import XCTest
@testable import LoansKit

final class TutorialServiceTests: XCTestCase {
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()

        XCTAssertTrue(client.requestedURLs.isEmpty)
    }

    func test_fetchTutorial_requestsDataFromURL() {
        let url = Environment.getUrl(for: .tutorial, .dev)
        let (sut, client) = makeSUT()

        sut.fetchTutorial { _ in }

        XCTAssertEqual(client.requestedURLs, [url])
    }

    func test_fetchTutorial_requestsDataFromURLTwice() {
        let url = Environment.getUrl(for: .tutorial, .dev)
        let (sut, client) = makeSUT()

        sut.fetchTutorial { _ in }
        sut.fetchTutorial { _ in }

        XCTAssertEqual(client.requestedURLs, [url, url])
    }

    func test_fetchTutorial_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()

        expect(sut, toCompleteWith: .failure(APIError(type: .defaultError)), when: {
            let clientError = NSError(domain: "test", code: 0)
            client.complete(with: clientError)
        })
    }
    
    func test_fetchTutorial_deliversAuthenticationErrorOn401HTTPResponse() {
        let (sut, client) = makeSUT()

        expect(sut, toCompleteWith: .failure(APIError(type: .authenticationError)), when: {
            let clientError = NSError(domain: "test", code: 401)
            client.complete(with: clientError)
        })
    }
    
    func test_fetchTutorial_deliversReachabilityErrorOn404HTTPResponse() {
        let (sut, client) = makeSUT()

        expect(sut, toCompleteWith: .failure(APIError(type: .reachabilityError)), when: {
            let clientError = NSError(domain: "test", code: 404)
            client.complete(with: clientError)
        })
    }
    
    func test_fetchTutorial_deliversDefaultErrorOn200HTTPResponseWithInvalidJSON() {
        let (sut, client) = makeSUT()
        
        expect(sut, toCompleteWith: .failure(APIError(type: .defaultError)), when: {
            let invalidData = Data("invalid json".utf8)
            client.complete(withStatusCode: 200, data: invalidData)
        })
    }
    
    func test_fetchTutorial_deliversAPIErrorOn200HTTPResponseWithValidAPIErrorJSON() {
        let (sut, client) = makeSUT()
        let apiError = makeAPIError(code: "200",
                                    id: "apiError test id",
                                    message: "apiError test id")
        
        expect(sut, toCompleteWith: .success(apiError.model), when: {
            let apiError = makeTutorialData(with: apiError.json)
            client.complete(withStatusCode: 200, data: apiError)
        })
    }
    
    func test_fetchTutorial_deliversTutorialOn200HTTPResponseWithJSONTutorial() {
        let (sut, client) = makeSUT()
        
        let tutorial = makeTutorial(title: "Tutorial Test")

        expect(sut, toCompleteWith: .success(tutorial.model), when: {
            let data = makeTutorialData(with: tutorial.json)
            client.complete(withStatusCode: 200, data: data)
        })
    }
    
    func test_fetchTutorial_doesNotDeliverResultAfterSUTInstanceHasBeenDeallocated() {
        let client = HTTPClientSpy()
        var sut: TutorialService? = TutorialService(client: client)
        
        var capturedResult = [ServiceResult]()
        sut?.fetchTutorial { capturedResult.append($0) }
        
        sut = nil
        client.complete(withStatusCode: 200, data: makeTutorialData(with: [:]))
        
        XCTAssertTrue(capturedResult.isEmpty)
    }

    // MARK: - Helpers

    private func makeSUT(file: StaticString = #filePath,
                         line: UInt = #line) -> (sut: TutorialService, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = TutorialService(client: client)

        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(client, file: file, line: line)

        return (sut, client)
    }
    
    private func makeAPIError(code: String,
                              id: String,
                              message: String) -> (model: APIError, json: [String: Any]) {
        let apiErrorModel = APIError.APIErrorModel(errorCode: code, message: message)
        let apiError = APIError(code: code, id: id, message: message, errors: [apiErrorModel])
        let apiErrorModelJson = [["errorCode": code,
                                 "message": message]] as [[String : Any]]
        let apiErrorJson = ["code": code,
                            "id": id,
                            "message": message,
                            "errors": apiErrorModelJson] as [String : Any]
        return (apiError, apiErrorJson)
    }
    
    private func makeTutorial(title: String) -> (model: TutorialModel, json: [String: Any]) {
        let model = TutorialModel(title: title)
        let json = ["title": title]
        return (model, json as [String : Any])
    }
    
    private func makeTutorialData(with json: [String: Any]) -> Data {
        return try! JSONSerialization.data(withJSONObject: json)
    }

    private func expect(_ sut: TutorialService,
                        toCompleteWith expectedResult: TutorialService.Result,
                        when action: () -> Void,
                        file: StaticString = #filePath,
                        line: UInt = #line) {

        let expectation = expectation(description: "Wait for load completion")

        sut.fetchTutorial { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedTutorial as TutorialModel), .success(expectedTutorial as TutorialModel)):
                XCTAssertEqual(receivedTutorial, expectedTutorial, file: file, line: line)

            case let (.success(receivedAPIError as APIError), .success(expectedAPIError as APIError)):
                XCTAssertEqual(receivedAPIError, expectedAPIError, file: file, line: line)
                
            case let (.failure(receivedAPIError), .failure(expectedAPIError)):
                XCTAssertEqual(receivedAPIError, expectedAPIError, file: file, line: line)

            default:
                XCTFail("Expected result \(expectedResult) got \(receivedResult) instead", file: file, line: line)
            }

            expectation.fulfill()
        }

        action()

        wait(for: [expectation], timeout: 1.0)
    }

    // MARK: - Spy

    private class HTTPClientSpy: HTTPClient {
        private var messages = [(url: URL, completion: (HTTPClientResult) -> Void)]()
        var requestedURLs: [URL] {
            return messages.map { $0.url }
        }

        func get(from url: URL,
                 completion: @escaping (HTTPClientResult) -> Void) {
            messages.append((url, completion))
        }

        func complete(with error: Error,
                      at index: Int = 0) {
            messages[index].completion(.failure(error))
        }

        func complete(withStatusCode code: Int,
                      data: Data,
                      at index: Int = 0) {
            let response = HTTPURLResponse(url: requestedURLs[index],
                                           statusCode: code,
                                           httpVersion: nil,
                                           headerFields: nil)!
            messages[index].completion(.success(data, response))
        }
    }
}
