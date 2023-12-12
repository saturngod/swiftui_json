//
//  HomeViewModelTest.swift
//  NewsArticlesTests
//
//  Created by Htain Lin Shwe on 30/11/2023.
//

import XCTest

final class HomeViewModelTest: XCTestCase {

    var sut : HomeViewModel!
    var mockNetworkManager: MockNetworkManager!
    
    @MainActor override func setUpWithError() throws {
        mockNetworkManager = MockNetworkManager()
        sut = HomeViewModel(networkManager: mockNetworkManager)
    }

    override func tearDownWithError() throws {
        sut = nil
        mockNetworkManager = nil
    }

    @MainActor
    func testGetNewsFeed() async throws {
        
        guard let fileURL = Bundle(for: type(of: self)).url(forResource: "articles", withExtension: "json") else {
            XCTFail("Missing File")
            return
        }
        do {
            let data = try Data(contentsOf: fileURL)
            let newsFeed = try JSONDecoder().decode(NewsFeed.self, from: data)
            let exceptedResult = newsFeed.articles
            
            mockNetworkManager.result = .success(newsFeed)
            
            await sut.getNewsFeed()
            
            XCTAssertEqual(sut.articles, exceptedResult)
        }
        catch {
            XCTFail("untable to convert the JSON")
        }
        
    }
    
    @MainActor
    func testGetNewsFeedFail() async throws {
        
        guard let fileURL = Bundle(for: type(of: self)).url(forResource: "articles", withExtension: "json") else {
            XCTFail("Missing File")
            return
        }
        do {
            let data = try Data(contentsOf: fileURL)
            let newsFeed = try JSONDecoder().decode(NewsFeed.self, from: data)
            
            mockNetworkManager.result = .failure(NetworkError.invalidURL)
            
            await sut.getNewsFeed()
            
            XCTAssertEqual(sut.articles.count, 0)
            
        }
        catch {
            XCTFail("untable to convert the JSON")
        }
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

class MockNetworkManager: NetworkManagerProtocol {
    
    var result: Result<NewsFeed, Error>!
    
    func getData<T: Decodable>(endpoint: EndPoint, type: T.Type) async throws -> T {
        switch result {
        case .success(let data):
            return data as! T
        case .failure(let error):
            throw error
        case .none:
            fatalError("Result was not set")
        }
    }
}
