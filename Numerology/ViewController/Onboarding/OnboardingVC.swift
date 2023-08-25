//
//  OnboardingVC.swift
//  Numerology
//
//  Created by Serj on 20.07.2023.
//

import UIKit

class OnboardingVC: UIViewController {
    
    // MARK: Next Button
    let nextButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.layer.cornerRadius = 8
        b.backgroundColor = #colorLiteral(red: 0.3058823529, green: 0.3568627451, blue: 0.6431372549, alpha: 1)
        
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.isUserInteractionEnabled = false
        l.textColor = .white
        l.text = "NEXT"
        l.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        b.addSubview(l)
        l.centerXAnchor.constraint(equalTo: b.centerXAnchor).isActive = true
        l.centerYAnchor.constraint(equalTo: b.centerYAnchor).isActive = true
        
        b.addTarget(Any?.self, action: #selector(nextBtnAction), for: .touchUpInside)

        return b
    }()
    
    // MARK: Next Btn Action
    @objc func nextBtnAction() {
        print("nextBtnAction")
        
        // Не очень 👎 но работает
        let currentPage = pageControl.currentPage
        print("currentPage \(currentPage)")
        if currentPage == 2  {
            self.navigationController?.pushViewController(UserEnterDataVC(), animated: true)
        }
        
        // Next button slide + push
        if pageControl.currentPage < 2 {
            pageControl.currentPage += 1
            print("page Control \(pageControl.currentPage)")
            contentScrollView.setContentOffset(CGPoint(x: CGFloat( pageControl.currentPage) * view.frame.size.width, y: 0), animated: true)
            // Тут косяк с (y: -46) Если есть BG ???
        }
        
        // Animation
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: {
                self.nextButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }, completion: { _ in
                UIView.animate(withDuration: 0.2) {
                    self.nextButton.transform = CGAffineTransform.identity
                }
            })
        }
    }
    
    
    
    // MARK: Terms Button
    let termsButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Terms Of Use", for: .normal)
        b.titleLabel?.font =  UIFont.systemFont(ofSize: 13)
        b.setTitleColor(UIColor.systemGray, for: .normal)
        
        b.addTarget(Any?.self, action: #selector(termsOfUseAct), for: .touchUpInside)
        return b
    }()
    
    @objc func termsOfUseAct() {
        print("termsOfUseAct")
        
        FirebaseManager().getInformationDocuments(byName: "TermsOfUse") { model in
            let vc = DescriptionVC()
            vc.configure(
                title: "Terms Of Use",
                info: model.info,
                about: nil
            )
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .overFullScreen
            self.present(navVC, animated: true)
        }
    }
    
    // MARK: Privacy Button
    let privacyButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Privacy Policy", for: .normal)
        b.titleLabel?.font =  UIFont.systemFont(ofSize: 13)
        b.setTitleColor(UIColor.systemGray, for: .normal)
        
        b.addTarget(Any?.self, action: #selector(privacyPolicyAct), for: .touchUpInside)
        return b
    }()
    @objc func privacyPolicyAct() {
        FirebaseManager().getInformationDocuments(byName: "PrivacyPolicy") { model in
            let vc = DescriptionVC()
            vc.configure(
                title: "Privacy Policy",
                info: model.info,
                about: nil
            )
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .overFullScreen
            self.present(navVC, animated: true)
        }
    }
    
    // MARK: Page Control
    let pageControl: UIPageControl = {
       let pc = UIPageControl()
        pc.numberOfPages = 3
//        pc.backgroundColor = .blue
        pc.addTarget(Any.self, action: #selector(pageControlDidchange(_:)), for: .valueChanged)
        return pc
    }()
    
    @objc private func pageControlDidchange(_ sender: UIPageControl) {
        let current = sender.currentPage
        contentScrollView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.size.width, y: 0), animated: true)
        // Тут тоже косяк с (y: -46)
    }
    
    // MARK: Content ScrollView
    private let contentScrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
//        sv.backgroundColor = .red
        sv.showsHorizontalScrollIndicator = false
        sv.showsVerticalScrollIndicator = false

        return sv
    }()
    

    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()

        setBackground()
        configureNavView()
        view.backgroundColor = .white
        contentScrollView.delegate = self
        
        setUpStack()
        
    }
    
    // MARK: setBackground
    func setBackground() {
        let background = UIImage(named: "OnboardingBG.png")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: self.view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
//    }
    
    
    
    private func configureNavView() {
//        self.navigationController?.navigationBar.isHidden = true
//        self.navigationItem.setHidesBackButton(true, animated: true)

        
    }
    
    
    
    // MARK: Set up Stack
    private func setUpStack() {

        // Scroll View Setup
        contentScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: contentScrollView.frame.size.height)
        contentScrollView.contentSize = CGSize(width: view.frame.size.width*3, height: contentScrollView.frame.size.height)
        contentScrollView.isPagingEnabled = true

        
        // MARK: slide
        for slide in 0..<3 {
//            let page = UIView(frame: CGRect( x: CGFloat(slide) * view.frame.size.width, y: 0, width: view.frame.size.width, height: view.frame.size.height))
            
            
            let page = OnboardingSlideView(frame: CGRect( x: CGFloat(slide) * view.frame.size.width, y: 0, width: view.frame.size.width, height: view.frame.size.height))

            
            
            
            if slide == 0 {
//                page.backgroundColor = .systemPurple
                page.configure(title: "Welcome!", subtitle: "Numerology can help you move to a bright streak of good luck and good fortune...")
                
            }
            if slide == 1 {
//                page.backgroundColor = .systemPink
                page.configure(title: "What is this?", subtitle: "You have entered the world of an amazing, mysterious and sometimes mystical science - NUMEROLOGY, which allows you to find out what is hidden in the date of birth of a person.")
            }
            if slide == 2 {
//                page.backgroundColor = .systemBlue
                page.configure(title: "What do you get?", subtitle: "You have entered the world of an amazing, mysterious and sometimes mystical science - NUMEROLOGY, which allows you to find out what is hidden in the date of birth of a person.")
            }
            contentScrollView.addSubview(page)
        }

        
        // DocsStack
        let docsStack = UIStackView(arrangedSubviews: [termsButton, privacyButton])
        docsStack.axis = .horizontal
        docsStack.spacing = 80
        
        // Content Stack
        let contentStack = UIStackView(arrangedSubviews: [contentScrollView,pageControl,nextButton,docsStack])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.alignment = .center
        contentStack.spacing = 40
        
    
        
        
        self.view.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            

            contentScrollView.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor, constant: 0),
            contentScrollView.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor, constant: 0),
            
            nextButton.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor, constant: 18),
            nextButton.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor, constant: -18),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            
            contentStack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            contentStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            contentStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -0),
            contentStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -44)
        ])
    }

}

extension OnboardingVC: UIScrollViewDelegate {
    
    // для pagecontrol перключения через свайп
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floorf(Float(contentScrollView.contentOffset.x) / Float(contentScrollView.frame.size.width)))
    }

}
