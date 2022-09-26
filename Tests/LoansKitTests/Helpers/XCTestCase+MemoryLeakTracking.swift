//
//  XCTestCase+MemoryLeakTracking.swift
//  LoansKit
//
//  Created by Douglas Pfeifer on 25/09/22.
//

import Foundation
import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instace: AnyObject,
                                     file: StaticString = #filePath,
                                     line: UInt = #line) {
        addTeardownBlock { [weak instace] in
            XCTAssertNil(instace, "Instance should have been deallocated. Potencial memory leak.",
                         file: file,
                         line: line)
        }
    }
}
