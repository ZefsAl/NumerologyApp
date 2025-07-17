//
//  File3.swift
//  Numerology
//
//  Created by Serj_M1Pro on 06.09.2024.
//

import SwiftUI

extension View {
    
    func roundedCornerAndBorder(lineWidth: CGFloat, borderColor: Color, radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
            .overlay(RoundedCorner(radius: radius, corners: corners)
                .stroke(borderColor, lineWidth: lineWidth))
    }
    
    func withoutTransaction(_ handler: @escaping () -> Void ) {
        var transaction = Transaction()
        transaction.disablesAnimations = true
        withTransaction(transaction) {
            handler()
        }
    }
    
    func customAlert(
        isPresented: Binding<Bool>,
        title: String,
        message: String? = nil,
        primaryAction: @escaping () -> ()
    ) -> some View {
        fullScreenCover(isPresented: isPresented) {
            CustomRateAlert(
                isPresented: isPresented,
                title: title,
                message: message,
                primaryAction: primaryAction
            )
            .background(BackgroundClearView_v2())
        }
    }
    
    
    func contentAlert<Content: View>(
        isPresented: Binding<Bool>,
        onBgTapDismiss: (() -> ())? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        fullScreenCover(isPresented: isPresented) {
            ContentAlertView(isPresented: isPresented, onBgTapDismiss: onBgTapDismiss, content: content)
                .background(BackgroundClearView_v2())
        }
    }
}
