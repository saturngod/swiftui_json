//
//  NewsFeed.swift
//  NewsArticles
//
//  Created by Htain Lin Shwe on 30/11/2023.
//

import Foundation

struct NewsFeed: Decodable, Hashable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}
