//
//  Article.swift
//  NewsArticles
//
//  Created by Htain Lin Shwe on 30/11/2023.
//

import Foundation

struct Article: Decodable, Hashable {
    let source: Source
    let author: String?
    let title, description: String
    let url: String
    let urlToImage: String?
    let publishedAt: Date
    let content: String?
    
    enum CodingKeys: CodingKey {
        case source
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.source = try container.decode(Source.self, forKey: .source)
        self.author = try container.decodeIfPresent(String.self, forKey: .author)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.url = try container.decode(String.self, forKey: .url)
        self.urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage)
        
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
        
        let dateString = try container.decode(String.self, forKey: .publishedAt)
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: dateString) {
            publishedAt = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .publishedAt, in: container, debugDescription: "Date string does not match format expected by formatter.")
        }
    }
    
    //MARK: INIT FOR PREVIEW DATA
    init(source: Source, author: String?, title: String, description: String, url: String, urlToImage: String?, publishedAt: Date, content: String?) {
            self.source = source
            self.author = author
            self.title = title
            self.description = description
            self.url = url
            self.urlToImage = urlToImage
            self.publishedAt = publishedAt
            self.content = content
        }
}


extension Article {
    static func loadPreviewData() -> Article {
        return Article(
            source: Source(id: "crypto-coins-news", name: "Crypto Coins News"),
            author: "Greg Thomson",
            title: "Bitcoin Cash (BCH) Price Surges 14% as ‘Halvening’ Nears",
            description: "Bitcoin Cash continued its monthly surge with another 14% growth spurt. Is BCH's April \"halvening\" event the catalyst behind recent gains? The post Bitcoin Cash (BCH) Price Surges 14% as ‘Halvening’ Nears appeared first on CCN.com",
            url: "ttps://www.ccn.com/bitcoin-cash-bch-price-surges-14-as-halvening-nears/",
            urlToImage: "https://www.ccn.com/wp-content/uploads/2020/02/shutterstock_785518696.jpg",
            publishedAt: Date(),
            content: "<ul><li>Bitcoin Cash led the cryptocurrency top ten on Wednesday with a 14% growth surge.</li><li>BCH shrugged off fears of a community split over an arbitrarily imposed tax on miners.</li><li>The coins halvening, or block reward halving, is scheduled for Apr… [+2578 chars]"
        )
    }
}
