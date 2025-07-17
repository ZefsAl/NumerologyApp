//
//  OnboardingVC_v2.swift
//  Numerology
//
//  Created by Serj on 26.10.2023.
//

import UIKit
import SafariServices

class OnboardingVC_v2: UIViewController {
    
    // MARK: Next Button
    let nextButton: RegularBigButton = {
        let b = RegularBigButton(frame: .zero, lable: "Continue")
        b.isHidden = true
        b.addTarget(Any?.self, action: #selector(nextBtnAction), for: .touchUpInside)
        return b
    }()
    
    // MARK: Next Btn Action
    @objc private func nextBtnAction() {
        myPrint("nextBtnAction")
        
        // Не очень 👎 но работает
        let currentPage = pageControl.currentPage
        myPrint("currentPage \(currentPage)")
        if currentPage == 2 {
            self.navigationController?.pushViewController(RegionOfbirthVC(), animated: true)
        }
        // Next button slide + push
        if pageControl.currentPage < 2 {
            pageControl.currentPage += 1
            myPrint("page Control \(pageControl.currentPage)")
            contentScrollView.setContentOffset(CGPoint(x: CGFloat( pageControl.currentPage) * view.frame.size.width, y: 0), animated: true)
            // Тут косяк с (y: -47) Если есть BG ???
        }
    }
    
    // MARK: Page Control
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.numberOfPages = 3
        pc.addTarget(Any.self, action: #selector(pageControlDidchange(_:)), for: .valueChanged)
        return pc
    }()
    
    @objc private func pageControlDidchange(_ sender: UIPageControl) {
        let current = sender.currentPage
        contentScrollView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.size.width, y: 0), animated: true)
        // Тут тоже косяк с (y: -47)
    }
    
    // MARK: Content ScrollView
    private let contentScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsHorizontalScrollIndicator = false
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        contentScrollView.delegate = self
        setupUI()
    }
    
    // MARK: - view Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        fakeLoad()
    }
    
    private var timer = Timer()
    // MARK: - fake Load
    func fakeLoad() {
        self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(moveSlide), userInfo: nil, repeats: false)
    }
    
    @objc private func moveSlide() {
        if pageControl.currentPage == 0 {
            pageControl.currentPage += 1
            myPrint("page Control \(pageControl.currentPage)")
            contentScrollView.setContentOffset(CGPoint(x: CGFloat(pageControl.currentPage) * view.frame.size.width, y: 0), animated: true)
        }
    }
}

// MARK: UIScrollViewDelegate
extension OnboardingVC_v2: UIScrollViewDelegate {
    // для pagecontrol перключения через свайп
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        pageControl.currentPage = Int(floorf(Float(contentScrollView.contentOffset.x) / Float(contentScrollView.frame.size.width)))
        let currentPage = Int(floorf(Float(contentScrollView.contentOffset.x) / Float(contentScrollView.frame.size.width)))
        
        myPrint(currentPage)
        if currentPage >= 1 {
            nextButton.isHidden = false
        } else {
            nextButton.isHidden = true
        }
        
    }
}
 

extension OnboardingVC_v2 {
    // MARK: setup UI
    private func setupUI() {
        
        contentScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: contentScrollView.frame.size.height)
        contentScrollView.contentSize = CGSize(width: view.frame.size.width*3, height: contentScrollView.frame.size.height)
        contentScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        contentScrollView.isPagingEnabled = true
        
        contentScrollView.contentInsetAdjustmentBehavior = .never // Must have Fix!
        
        // MARK: Screens slide
        for slide in 0..<3 {
            
            if slide == 0 {
                let page1 = OnboardingSlideView(
                    frame: CGRect( x: CGFloat(slide) * view.frame.size.width, y: 0, width: view.frame.size.width, height: view.frame.size.height),
                    namedBG: "Slice1"
                )
                
                page1.configure(
                    title: "Discover Astrology!",
                    promoSubtitle: "Discover your strengths and attract good fortune through the power of astrology."
                )
                contentScrollView.addSubview(page1)
            }
            if slide == 1 {
                let page2 = OnboardingSlideView(
                    frame: CGRect( x: CGFloat(slide) * view.frame.size.width, y: 0, width: view.frame.size.width, height: view.frame.size.height),
                    namedBG: "Slice2"
                )
                page2.configure(
                    title: "What's Inside?",
                    promoSubtitle: "Dive into the mystical science of numerology and uncover the secrets hidden in your date of birth."
                )
                contentScrollView.addSubview(page2)
            }
            if slide == 2 {
                let page3 = OnboardingSlideView(
                    frame: CGRect( x: CGFloat(slide) * view.frame.size.width, y: 0, width: view.frame.size.width, height: view.frame.size.height),
                    namedBG: "Slice3"
                )
                page3.configure(
                    title: "Unlock Your Potential",
                    promoSubtitle: "Gain insight into your past, future, and hidden talents through personalized esoterica."
                )
                contentScrollView.addSubview(page3)
            }
            
        }
        
        self.view.addSubview(contentScrollView)
        AnimatableBG().setBackground(vc: self)
        self.view.addSubview(nextButton)
        
        let margin = self.view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            
            contentScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -0),
            contentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -0),
            
            nextButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            nextButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
            nextButton.bottomAnchor.constraint(equalTo: margin.bottomAnchor, constant: -52)
        ])
    }
}
