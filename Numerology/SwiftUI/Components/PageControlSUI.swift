//
//  PageControl.swift
//  Numerology
//
//  Created by Serj_M1Pro on 19.06.2025.
//

import SwiftUI

// TODO: - Не работает переключение по нажатию на Page Control
struct PageControlSUI: UIViewRepresentable {
    
    @Binding var currentPage: Int
    var numberOfPages: Int
    var selectedColor: UIColor = .systemBlue
    var unselectedColor: UIColor = .white
    var isUserInteractionEnabled = true
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(currentPage: $currentPage)
    }
    
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        //        control.numberOfPages = 1 - тут не обязательно
        // control.setIndicatorImage(UIImage(systemName: "location.fill"), forPage: 0) // Specific IMG
        control.isUserInteractionEnabled = self.isUserInteractionEnabled
        control.pageIndicatorTintColor = self.unselectedColor
        control.currentPageIndicatorTintColor = self.selectedColor
        control.translatesAutoresizingMaskIntoConstraints = false
        control.setContentHuggingPriority(.required, for: .horizontal)
        control.addTarget(
            context.coordinator,
            action: #selector(Coordinator.pageControlDidFire(_:)),
            for: .valueChanged)
        return control
    }
    
    func updateUIView(_ control: UIPageControl, context: Context) {
        context.coordinator.currentPage = $currentPage
        control.numberOfPages = numberOfPages
        control.currentPage = currentPage
    }
    
    class Coordinator {
        var currentPage: Binding<Int>
        
        init(currentPage: Binding<Int>) {
            self.currentPage = currentPage
        }
        
        @objc func pageControlDidFire(_ control: UIPageControl) {
            currentPage.wrappedValue = control.currentPage            
        }
    }
    
    /// Кстати тут координатор не реализован
    /// scrollView.delegate = context.coordinator
    /// func makeCoordinator() -> Coordinator { Coordinator(self) }
}


struct PageControlSUI_TESTPREVIEW: View {
    @State var page = 0
    var locations = ["Current Location", "San Francisco", "Chicago", "New York", "London"]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            tabView
            
            VStack {
                Spacer()
                controlBar.padding()
                Spacer().frame(height: 60)
            }
        }
    }
    
    @ViewBuilder
    private var tabView: some View {
        TabView(selection: $page) {
            ForEach(Array(locations.enumerated()), id: \.offset) { i in
                VStack {
                    Text(i.element)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background(i.offset % 2 == 0 ? .red : .green)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
    
    @ViewBuilder
    private var controlBar: some View {
        HStack {
            Image(systemName: "map")
            Spacer()
            PageControlSUI(
                currentPage: $page,
                numberOfPages: locations.count
            )
            Spacer()
            Image(systemName: "list.bullet")
        }
    }
}

#Preview {
    PageControlSUI_TESTPREVIEW()
}
