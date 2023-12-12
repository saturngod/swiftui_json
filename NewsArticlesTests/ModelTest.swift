//
//  ModelTest.swift
//  NewsArticlesTests
//
//  Created by Htain Lin Shwe on 12/12/2023.
//

import XCTest

final class ModelTest: XCTestCase {

    func testSource() {
        let source = Source(id: "1", name: "world")
        XCTAssertEqual(source.id, "1")
        XCTAssertEqual(source.name, "world")
    }
    
    func testArcile() {
        let article = Article(
            source: Source(id: "crypto-coins-news", name: "Crypto Coins News"),
            author: "Greg Thomson",
            title: "Bitcoin Cash (BCH) Price Surges 14% as ‘Halvening’ Nears",
            description: "Bitcoin Cash continued its monthly surge with another 14% growth spurt. Is BCH's April \"halvening\" event the catalyst behind recent gains? The post Bitcoin Cash (BCH) Price Surges 14% as ‘Halvening’ Nears appeared first on CCN.com",
            url: "ttps://www.ccn.com/bitcoin-cash-bch-price-surges-14-as-halvening-nears/",
            urlToImage: "https://www.ccn.com/wp-content/uploads/2020/02/shutterstock_785518696.jpg",
            publishedAt: Date(),
            content: "<ul><li>Bitcoin Cash led the cryptocurrency top ten on Wednesday with a 14% growth surge.</li><li>BCH shrugged off fears of a community split over an arbitrarily imposed tax on miners.</li><li>The coins halvening, or block reward halving, is scheduled for Apr… [+2578 chars]"
        )
        
        XCTAssertEqual(article.source.id, "crypto-coins-news")
        XCTAssertEqual(article.source.name, "Crypto Coins News")
        XCTAssertEqual(article.author, "Greg Thomson")
        XCTAssertEqual(article.title, "Bitcoin Cash (BCH) Price Surges 14% as ‘Halvening’ Nears")
        XCTAssertEqual(article.content, "<ul><li>Bitcoin Cash led the cryptocurrency top ten on Wednesday with a 14% growth surge.</li><li>BCH shrugged off fears of a community split over an arbitrarily imposed tax on miners.</li><li>The coins halvening, or block reward halving, is scheduled for Apr… [+2578 chars]")
    }
    
    func testArticleDemoTest() {
        let article = Article.loadPreviewData()
        XCTAssertEqual(article.source.id, "crypto-coins-news")
        XCTAssertEqual(article.source.name, "Crypto Coins News")
        XCTAssertEqual(article.author, "Greg Thomson")
        XCTAssertEqual(article.title, "Bitcoin Cash (BCH) Price Surges 14% as ‘Halvening’ Nears")
        XCTAssertEqual(article.content, "<ul><li>Bitcoin Cash led the cryptocurrency top ten on Wednesday with a 14% growth surge.</li><li>BCH shrugged off fears of a community split over an arbitrarily imposed tax on miners.</li><li>The coins halvening, or block reward halving, is scheduled for Apr… [+2578 chars]")
    }
}
