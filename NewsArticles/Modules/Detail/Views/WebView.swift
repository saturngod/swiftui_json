//
//  WebView.swift
//  NewsArticles
//
//  Created by Htain Lin Shwe on 30/11/2023.
//

import SwiftUI
import WebKit
struct WebView: UIViewRepresentable {
    var urlString: String
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
    
    typealias UIViewType = WKWebView
    
    
}
