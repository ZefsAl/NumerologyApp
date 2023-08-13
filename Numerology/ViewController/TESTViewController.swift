////
////  TESTViewController.swift
////  Numerology
////
////  Created by Serj on 06.08.2023.
////
//
//import UIKit
//
//class TESTViewController: UIViewController {
//
//
//
//
//
//    private let verticalScrollView: UIScrollView = {
//       let sv = UIScrollView()
//        sv.translatesAutoresizingMaskIntoConstraints = false
//        sv.showsVerticalScrollIndicator = false
//        sv.alwaysBounceVertical = true
//        return sv
//    }()
//
//
//
////    // MARK: Page Control
////    let pageControl: UIPageControl = {
////       let pc = UIPageControl()
////        pc.numberOfPages = 3
//////        pc.backgroundColor = .blue
////        pc.addTarget(Any.self, action: #selector(pageControlDidchange(_:)), for: .valueChanged)
////        return pc
////    }()
//
////    @objc private func pageControlDidchange(_ sender: UIPageControl) {
////        let current = sender.currentPage
////        contentScrollView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.size.width, y: 0), animated: true)
////        // Тут тоже косяк с (y: -46)
////    }
//
//    // MARK: Content ScrollView
//    private let contentScrollView: UIScrollView = {
//       let sv = UIScrollView()
//        sv.translatesAutoresizingMaskIntoConstraints = false
//        sv.backgroundColor = .red
//        sv.showsHorizontalScrollIndicator = false
//        sv.showsVerticalScrollIndicator = false
//
//        return sv
//    }()
//
//
//
//    // MARK: View Did Load
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
////        setBackground()
////        configureNavView()
//        view.backgroundColor = .white
////        contentScrollView.delegate = self
//
//        setUpStack()
//
//    }
//
//
//
//    // MARK: Set up Stack
//    private func setUpStack() {
//
//        // Scroll View Setup
//        contentScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: contentScrollView.frame.size.height)
//        contentScrollView.contentSize = CGSize(width: view.frame.size.width*3, height: contentScrollView.frame.size.height)
//        contentScrollView.isPagingEnabled = true
//
//
//        // MARK: slide
//        for slide in 0..<3 {
////            let page = UIView(frame: CGRect( x: CGFloat(slide) * view.frame.size.width, y: 0, width: view.frame.size.width, height: view.frame.size.height))
//
//
//            let page = OnboardingSlideView(frame: CGRect( x: CGFloat(slide) * view.frame.size.width, y: 0, width: view.frame.size.width, height: view.frame.size.height))
//
//
//
//
//            if slide == 0 {
////                page.backgroundColor = .systemPurple
//                page.configure(title: "Welcome!", subtitle: "Numerology can help you move to a bright streak of good luck and good fortune...")
//
//            }
//            if slide == 1 {
////                page.backgroundColor = .systemPink
//                page.configure(title: "What is this?", subtitle: "You have entered the world of an amazing, mysterious and sometimes mystical science - NUMEROLOGY, which allows you to find out what is hidden in the date of birth of a person.")
//            }
//            if slide == 2 {
////                page.backgroundColor = .systemBlue
//                page.configure(title: "What do you get?", subtitle: "You have entered the world of an amazing, mysterious and sometimes mystical science - NUMEROLOGY, which allows you to find out what is hidden in the date of birth of a person.")
//            }
//            contentScrollView.addSubview(page)
//        }
//
//
////        // DocsStack
////        let docsStack = UIStackView(arrangedSubviews: [privacyButton,termsButton])
////        docsStack.axis = .horizontal
////        docsStack.spacing = 80
//
//        // Content Stack
//        let contentStack = UIStackView(arrangedSubviews: [contentScrollView])
//        contentStack.translatesAutoresizingMaskIntoConstraints = false
//        contentStack.axis = .vertical
//        contentStack.alignment = .center
//        contentStack.spacing = 40
//        contentStack.backgroundColor = .systemBlue
////        self.view.addSubview(contentStack)
//
//
//
//        self.view.addSubview(verticalScrollView)
//        verticalScrollView.addSubview(contentStack)
//
//
//        NSLayoutConstraint.activate([
//
//
//            contentScrollView.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor, constant: 0),
//            contentScrollView.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor, constant: 0),
//
//
//
//            contentScrollView.widthAnchor.constraint(equalTo: contentStack.widthAnchor, constant: 0),
//            contentScrollView.heightAnchor.constraint(equalToConstant: 500),
//            contentScrollView.topAnchor.constraint(equalTo: contentStack.topAnchor, constant: 0),
//            contentScrollView.bottomAnchor.constraint(equalTo: contentStack.bottomAnchor, constant: 0),
////            contentStack.heightAnchor.constraint(equalTo: verticalScrollView.heightAnchor, constant: -36),/
//
//            contentStack.topAnchor.constraint(equalTo: verticalScrollView.topAnchor, constant: 44),
//            contentStack.leadingAnchor.constraint(equalTo: verticalScrollView.leadingAnchor, constant: 18),
//            contentStack.trailingAnchor.constraint(equalTo: verticalScrollView.trailingAnchor, constant: -18),
//            contentStack.bottomAnchor.constraint(equalTo: verticalScrollView.bottomAnchor, constant: -18),
//            contentStack.widthAnchor.constraint(equalTo: verticalScrollView.widthAnchor, constant: -36),
////            contentStack.heightAnchor.constraint(equalTo: verticalScrollView.heightAnchor, constant: -36),
//
//
//            verticalScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
//            verticalScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            verticalScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//            verticalScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
//        ])
//    }
//
//}
//
////extension TESTViewController: UIScrollViewDelegate {
////
////    // для pagecontrol перключения через свайп
////
////    func scrollViewDidScroll(_ scrollView: UIScrollView) {
////        pageControl.currentPage = Int(floorf(Float(contentScrollView.contentOffset.x) / Float(contentScrollView.frame.size.width)))
////    }
////
////}
