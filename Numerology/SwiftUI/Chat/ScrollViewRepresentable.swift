//
//  ScrollViewRepresentable.swift
//  Numerology
//
//  Created by Serj_M1Pro on 14.05.2025.
//

import SwiftUI

struct ScrollViewRepresentable<Content: View>: UIViewRepresentable {
    
    @Binding var currentPage: Int
    var scrollAxis: Axis.Set
    var isPagingEnabled = false
    var alwaysBounceVertical = true
    var alwaysBounceHorizontal = true
    var bounces = true
    var showsVerticalScrollIndicator = true
    var showsHorizontalScrollIndicator = true
    var content: Content
    var onScroll: ((CGPoint) -> Void)? = nil
    
    @State private var canSetPage: Bool = true
    private let scrollView = UIScrollView()
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        scrollView.isPagingEnabled = self.isPagingEnabled
        scrollView.alwaysBounceVertical = self.alwaysBounceVertical
        scrollView.alwaysBounceHorizontal = self.alwaysBounceHorizontal
        scrollView.bounces = self.bounces
        scrollView.showsVerticalScrollIndicator = self.showsVerticalScrollIndicator
        scrollView.showsHorizontalScrollIndicator = self.showsHorizontalScrollIndicator
        
        let hostingController = UIHostingController(rootView: content)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        
        scrollView.addSubview(hostingController.view)
        scrollView.delegate = context.coordinator
        // Сохраняем ссылку в координаторе:
        context.coordinator.scrollView = self.scrollView
        
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
        
        if self.scrollAxis == .vertical {
            hostingController.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        } else {
            hostingController.view.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        }
        return scrollView
    }
    
    // v1 - работает
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        uiView.subviews.first?.setNeedsLayout()
        guard self.canSetPage else { return }
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            context.coordinator.setPage(self.currentPage)
        }
    }
    
    // V2  работает - отказался
    //    func updateUIView(_ uiView: UIScrollView, context: Context) {
    //        uiView.subviews.first?.setNeedsLayout()
    //        // set initial page
    //        DispatchQueue.main.asyncAfter(deadline: .now()) {
    //            let expectedOffset = uiView.frame.size.width * CGFloat(self.currentPage)
    //            if abs(uiView.contentOffset.x - expectedOffset) > 1 {
    //                context.coordinator.setPage(self.currentPage)
    //            }
    //        }
    //    }
    
    // MARK: - Coordinator
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: ScrollViewRepresentable
        
        var scrollView: UIScrollView? = nil
        
        init(_ parent: ScrollViewRepresentable) {
            self.parent = parent
            //            print("🔹init with contentOffset.x",scrollView?.contentOffset.x)
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            self.parent.canSetPage = false
            parent.onScroll?(scrollView.contentOffset)
            // Вычисляем страницу -> установим в currentPage
            let page = Int((scrollView.contentOffset.x / scrollView.frame.size.width) + 0.0)
            if page != parent.currentPage {
                parent.currentPage = page
            }
            print("🌕", scrollView.contentOffset.x / scrollView.frame.size.width)
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            self.parent.canSetPage = true
            print("🟢 scrollViewDidEndDecelerating",self.parent.canSetPage)
        }
        
        func setPage(_ page: Int, animated: Bool = true) {
            //            print("🟣setPage_v2")
            
//            guard let scrollView = self.scrollView else { print("❌ not get scrollView"); return }
//            
//            let offsetX = scrollView.frame.size.width * CGFloat(page)
//            if animated {
//                UIView.animate(withDuration: 0.3) {
//                    scrollView.contentOffset.x = offsetX
//                }
//            } else {
//                scrollView.contentOffset.x = offsetX
//            }
//            self.parent.canSetPage = true
            //            print("🔴🔴🔴set offsetX", offsetX)
        }
    }
}



// TODO: - Out of bounds - content - Не решена
// TODO: - Иногда когда свайп и таймер совпадают котент уходит в - или +
// TODO: - на последнем эллементе переходит в никуда
// TODO: - scrollView.contentOffset.x не может быть больше item.count или меньше
// TODO: - проблема и в таймере и в обработке setPage
// TODO: - .background(BackgroundClearView_v2()) // - ⚠️ Must have ! (Решило проблему отображения DesignedScrollView на деайсе)
// TODO: -- Simulator iphone 16 - setPage перебивает свайп (freeze)
// TODO: - желательно инкапсулировать geometryReader как background может создать DesignedScrollView <Content:View>


// MARK: - DesignedScrollView Test Example
struct DesignedScrollView_TestExample: View {
    
    @State private var scrollOffset: CGPoint = .zero
    
    let dataSource = [1,2,3,4,5,6,7,8]
    @State var currentPage: Int = 0
    @State var direction: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            ScrollViewRepresentable(
                currentPage: self.$currentPage,
                scrollAxis: .horizontal,
                isPagingEnabled: true,
                alwaysBounceVertical: false,
                alwaysBounceHorizontal: false,
                bounces: true,
                showsVerticalScrollIndicator: false,
                showsHorizontalScrollIndicator: false,
                content: self.h_Content(proxy: proxy),
                onScroll: { self.scrollOffset = $0 } // Не обязательно использовать
            )
            .ignoresSafeArea()
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
                if self.direction {
                    self.currentPage -= 1
                } else {
                    self.currentPage += 1
                }
            }
        }
        
        .onChange(of: self.currentPage) { newValue in
            // Костыль! но ок
            if newValue < 0 {
                self.currentPage = 0
            } else if self.currentPage > self.dataSource.count-1 {
                self.currentPage = self.dataSource.count-1
            }
            
            print("✅ currentPage: \(newValue)")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if self.dataSource.count-1 == self.currentPage {
                    self.direction = true
                } else if self.currentPage == 0 {
                    self.direction = false
                }
            }
        }
    }
    
    @ViewBuilder func h_Content(proxy: GeometryProxy) -> some View {
        HStack(spacing: 0) {
            ForEach(self.dataSource, id: \.self) { item in
                VStack {
                    HStack { Text("\(item)") }
                }
                .font(.system(size: 100, weight: .bold))
                .frame(width: proxy.size.width, height: proxy.size.height)
                .background(item % 2 == 0 ? Color.red : Color.green)
            }
        }
    }
    
    @ViewBuilder func v_Content(proxy: GeometryProxy) -> some View {
        VStack(spacing: 0) {
            ForEach(0..<10) { _ in
                VStack {
                    HStack { Text("1"); Spacer(); Text("2") }
                    Spacer()
                    HStack { Text("3"); Spacer(); Text("4") }
                }
                .font(.system(size: 100, weight: .bold))
                .frame(width: proxy.size.width, height: 300)
                .background(Color.red)
            }
        }
    }
}

#Preview {
    DesignedScrollView_TestExample()
}
