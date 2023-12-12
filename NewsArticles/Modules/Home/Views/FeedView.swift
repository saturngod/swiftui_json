//
//  FeedView.swift
//  NewsArticles
//
//  Created by Htain Lin Shwe on 30/11/2023.
//

import SwiftUI
import Kingfisher

struct FeedView: View {
    var title: String
    var source: String
    var time: String
    var imageUrl: String
    var author: String
    
    
    
    var body: some View {
        HStack {
            ArticleInfoView(title: title, author: author, source: source, time: time)
                .padding(.trailing,4)
            Spacer()
            ArticleImageView(imageUrl: imageUrl)
        }
    }
}

struct ArticleInfoView: View {
    var title: String
    var author: String
    var source: String
    var time: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .lineLimit(2)
            Text(author)
                .font(.subheadline)
                .lineLimit(1)
            HStack(alignment: .top) {
                Text(source)
                Text(time)
                    .lineLimit(1)
            }
            .font(.footnote)
            .fontWeight(.light)
        }
    }
}

struct ArticleImageView: View {
    var imageUrl: String
    @State private var imageLoadingFail: Bool = false
    
    var body: some View {
        if !imageLoadingFail, let url = URL(string: imageUrl) {
            KFImage(url)
                .placeholder { ProgressView() }
                .forceRefresh()
                .resizable()
                .onFailure { _ in imageLoadingFail = true }
                .loadDiskFileSynchronously()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipped()
        } else {
            Image("placeholder")
                .background(Color.white)
                .scaledToFit()
                .frame(width: 80, height: 80)
        }
    }
}


#Preview {

    FeedView(title: "Bitcoin Cash (BCH) Price Surges 14% as ‘Halvening’ Nears", source: "Crypto Coins News", time: "5h ago", imageUrl: "https://www.ccn.com/wp-content/uploads/2020/02/shutterstock_785518696.jpg", author: "Greg Thomson")
        .padding()
}
