//
//  HomeView.swift
//  Numerology
//
//  Created by Serj_M1Pro on 23.06.2025.
//

import SwiftUI

struct NamespaceExample: View {
    @Namespace var namespace
    @State var isDisplay = true

    var body: some View {
        VStack {
            if isDisplay {
                Image(systemName: "paperplane.circle.fill")
                    .font(.system(size: 100, weight: .bold))
                .background(.green)
                .clipShape(.capsule)
                .matchedGeometryEffect(
                    id: "img",
                    in: namespace,
                    properties: .position,
                    anchor: .center,
                    isSource: true
                )
//                .transition(.scale.combined(with: .opacity))
//                .transition(.scale(scale: 2, anchor: .bottom))
//                .transition(.identity)
                Spacer()
            } else {
                Spacer()
                Image(systemName: "paperplane.circle.fill")
                    .font(.system(size: 300, weight: .bold))
                .background(.green)
                .clipShape(.capsule)
                .matchedGeometryEffect(
                    id: "img",
                    in: namespace,
                    properties: .position,
                    anchor: .center,
                    isSource: true
                )
//                .transition(.scale.combined(with: .opacity))
                .transition(.scale(scale: 0))
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color.red)
        .onTapGesture {
            self.isDisplay.toggle()
        }
//        ZStack {
//            if isDisplay {
//                View1(namespace: namespace, isDisplay: $isDisplay)
//                    .transition(.scale)
//            } else {
//                View2(namespace: namespace, isDisplay: $isDisplay)
//                    .transition(.scale)
//            }
//        }
        .animation(.smooth(duration: 1), value: isDisplay)
    }
}

struct View1: View {
    let namespace: Namespace.ID
    @Binding var isDisplay: Bool
    var body: some View {
        VStack {
            Image(systemName: "paperplane.circle.fill")
                .resizable()
                .frame(width: 150, height: 150, alignment: .center)
                .matchedGeometryEffect(id: "img", in: namespace)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue)
        .onTapGesture {
            self.isDisplay.toggle()
        }
    }
}

struct View2: View {
    let namespace: Namespace.ID
    @Binding var isDisplay: Bool
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "paperplane.circle.fill")
                .resizable()
                .frame(width: 300, height: 300)
                .matchedGeometryEffect(id: "img", in: namespace)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red)
        .onTapGesture {
            self.isDisplay.toggle()
        }
    }
}

#Preview {
    NamespaceExample()
}
