//
//  DetailViewModel.swift
//  NewsArticles
//
//  Created by Htain Lin Shwe on 30/11/2023.
//

import SwiftUI

class DetailViewModel: ObservableObject {
    
    @Published var imageLoadingFail = false
    @Published var selectedColorIndex = 0
    
    var article: Article

    
    init(article: Article) {
        self.article = article
    }

}
