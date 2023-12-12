//
//  HomeViewModel.swift
//  NewsArticles
//
//  Created by Htain Lin Shwe on 30/11/2023.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    
    @Published var articles = [Article]()
    @Published var totalArticles = 0;
    @Published var isLoading = true
    @Published var isShowDetail = false
    
    var detailViewModel: DetailViewModel?
    
    var networkManager:NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func showDetail(article: Article) {
        detailViewModel = DetailViewModel(article: article)
        isShowDetail = true
    }
    
    func getNewsFeed() async {
        do {
            isLoading = true
            let newsFeed = try await self.networkManager.getData(endpoint: .newsFeed, type: NewsFeed.self)
            isLoading = false
            if (newsFeed.status.lowercased() == "ok") {
                self.articles = newsFeed.articles
                self.totalArticles = newsFeed.totalResults
            }
        }
        catch {
            print("An error occurred: \(error)")
        }
    }
}



