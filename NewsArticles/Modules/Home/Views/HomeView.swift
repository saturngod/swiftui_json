//
//  ContentView.swift
//  NewsArticles
//
//  Created by Htain Lin Shwe on 30/11/2023.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel = HomeViewModel(networkManager: NetworkManager.shared)
    
    var body: some View {
        NavigationStack {
            Group {
                if (viewModel.isLoading) {
                   ProgressView()
                }
                else {
                    List(viewModel.articles,id:\.self){ article in
                        
                        ZStack {
                            
                            FeedView(title: article.title, source: article.source.name, time: article.publishedAt.ago(), imageUrl: article.urlToImage ?? "", author: article.author ?? "N/A")
                                .onTapGesture(perform: {
                                    viewModel.showDetail(article: article)
                                })
                                .accessibilityIdentifier("FEED_ITEM")
                                
                                
                        }
                        
                    }
                    .accessibilityIdentifier("FEED")
                    .listStyle(.plain)
                    
                }
            }
            
            .navigationTitle("News Feed")
            .fullScreenCover(isPresented: $viewModel.isShowDetail, content: {
                if let viewmodel = viewModel.detailViewModel {
                    DetailView(viewModel: viewmodel)
                }
                
            })
            
            
        }
        
        .onAppear {
            Task {
                await viewModel.getNewsFeed()
            }
        }
    }
    
    @ViewBuilder
    func LinktoArticle(detailViewModel: DetailViewModel) -> some View {
        NavigationLink (destination: DetailView(viewModel: detailViewModel)) {
            
        }
        .buttonStyle(PlainButtonStyle())
        .opacity(0.0)
    }
        
}

#Preview {
    HomeView()
}
