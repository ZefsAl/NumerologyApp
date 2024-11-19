//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 11.10.2024.
//

import SwiftUI
import SafariServices

import WebKit

struct SafariView: UIViewControllerRepresentable {
    var url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
    }
}

