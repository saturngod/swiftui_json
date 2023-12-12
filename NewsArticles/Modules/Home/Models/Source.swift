//
//  Hashable.swift
//  NewsArticles
//
//  Created by Htain Lin Shwe on 30/11/2023.
//

import Foundation

struct Source: Decodable, Hashable {
    let id: String?
    let name: String
    
    enum CodingKeys: CodingKey {
        case id
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    init(id: String,name: String) {
        self.id = id
        self.name = name
    }
}
