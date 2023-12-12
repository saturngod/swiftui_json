//
//  DetailView.swift
//  NewsArticles
//
//  Created by Htain Lin Shwe on 30/11/2023.
//

import SwiftUI
import Kingfisher
import AttributedText


struct DetailView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: DetailViewModel
    
    //MARK: Main Body
    var body: some View {
        NavigationStack {
            Group {
                if(viewModel.selectedColorIndex == 0) {
                    newsView()
                }
                else {
                    sourceWebView()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    closeView()
                }
                
                ToolbarItem(placement: .principal) {
                    webPickerView()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    shareView()
                }
                
            }
            
            
        }
    }
    
    @ViewBuilder
    func newsView() -> some View {
        ScrollView {
            VStack(alignment: .leading) {
                headerImageView()
                
                titleView()
                
                authorAndDateView()
                
                contentView()
                
                sourceView()
                
            }
            .padding()
        }
    }
    
    //MARK: NewsView Data
    @ViewBuilder
    func sourceView() -> some View {
        Text("Source: \(viewModel.article.source.name)")
            .font(.caption)
            .padding(.top,10)
    }
    
    @ViewBuilder
    func contentView() -> some View {
        AttributedText(viewModel.article.content ?? "No Content Available")
            .padding(.top,4)
    }
    
    @ViewBuilder
    func authorAndDateView() -> some View {
        HStack(alignment: .top, content: {
            Text(viewModel.article.author ?? "Unknown Author")
            Spacer()
            Text(viewModel.article.publishedAt.localFormat())
        })
        .font(.caption)
    }
    
    @ViewBuilder
    func titleView() -> some View {
        Text(viewModel.article.title)
            .font(.title)
    }
    
    @ViewBuilder
    func headerImageView() -> some View {
        if !viewModel.imageLoadingFail , let url = URL(string: viewModel.article.urlToImage ?? "") {
            KFImage(url)
                .placeholder { ProgressView() }
                .forceRefresh()
                .resizable()
                .onFailure { _ in viewModel.imageLoadingFail = true }
                .loadDiskFileSynchronously()
                .scaledToFill()
                .clipped()
            
        }
    }
    
    //MARK: WebView Data
    @ViewBuilder
    func sourceWebView() -> some View {
        WebView(urlString: viewModel.article.url)
    }
    
    @ViewBuilder
    func webPickerView() -> some View {
        Picker("View", selection: $viewModel.selectedColorIndex) {
            Text("News").tag(0)
            Text("Web").tag(1)
        }
        .pickerStyle(SegmentedPickerStyle())
        .accessibilityIdentifier("PICKER_VIEW")
    }
    
    @ViewBuilder
    func closeView() -> some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
        }
    }
    
    //MARK: ShareView
    @ViewBuilder
    func shareView() -> some View {
        if let url = URL(string: viewModel.article.url) {
            ShareLink(item: url)
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(viewModel: DetailViewModel(article: Article.loadPreviewData()))
    }
}
