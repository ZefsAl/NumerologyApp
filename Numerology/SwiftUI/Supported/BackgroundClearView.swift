//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 11.10.2024.
//

import SwiftUI

struct BackgroundClearView_v1: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async { // Мерцает
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct BackgroundClearView_v2: UIViewRepresentable {
    
    private class BackgroundRemovalView: UIView {
        
        override func didMoveToWindow() {
            super.didMoveToWindow()
            superview?.superview?.backgroundColor = .clear
        }
        
    }

    func makeUIView(context: Context) -> UIView {
        return BackgroundRemovalView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
