//
//  OmdbApiUIKitTests.swift
//  OmdbApiUIKitTests
//
//  Created by Mohd Kashif on 19/07/24.
//

import XCTest
import Combine
final class OmdbApiUIKitTests: XCTestCase {
    var cancellale:Set<AnyCancellable>=[]
    func testExample() throws {
        let client=NetworkClient()
        let expectation=XCTestExpectation(description: "Recievd data")
        client.fetchMovies(name: "Batman").sink { completion in
            switch completion{
            case .finished:
                break
            case .failure(let error):
                XCTFail("Failed with \(error)")
            }
        } receiveValue: { movies in
            XCTAssertTrue(movies.count>0)
            expectation.fulfill()
        }.store(in: &cancellale)
        wait(for: [expectation], timeout: 5.0)
    }

}
