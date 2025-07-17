//
//  Extension_UIViewController.swift
//  Numerology
//
//  Created by Serj on 27.07.2023.
//

import Foundation
import UIKit
import AVFoundation

extension UIViewController {
    
    // MARK: setBackground
    func setBackground(named: String) {
        let background = UIImage(named: named)
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: self.view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    // MARK: set Dismiss Nav Item
    public func setDismissNavButtonItem(selectorStr: Selector) {
        
        let dismissButtonView: UIView = {
            let configImage = UIImage(
                systemName: "xmark",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .regular)
            )?.withTintColor(UIColor.white.withAlphaComponent(0.7), renderingMode: .alwaysOriginal)
            let iv = UIImageView(image: configImage)
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.tintColor = .white
//            iv.contentMode = .scaleAspectFit
            iv.isUserInteractionEnabled = false

            let view = UIView()
//            view.translatesAutoresizingMaskIntoConstraints = false
//            view.layer.cornerRadius = 15
//            view.addSystemBlur(to: view, style: .systemUltraThinMaterialDark)
//            view.clipsToBounds = true
            
            view.addSubview(iv)
            NSLayoutConstraint.activate([
                iv.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                iv.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                view.heightAnchor.constraint(equalToConstant: 30),
                view.widthAnchor.constraint(equalToConstant: 30),
            ])
            return view
        }()
        
        // Add Nav Item
        let dismissButtonItem = UIBarButtonItem(customView: dismissButtonView)
        let gesture = UITapGestureRecognizer(target: self, action: selectorStr)
        dismissButtonView.addGestureRecognizer(gesture)
        self.navigationItem.rightBarButtonItem = dismissButtonItem
    }
    
    // MARK: Action dissmiss
    @objc func dismissButtonAction() {
        self.dismiss(animated: true)
        myPrint("dismissButtonAction")
    }
    
    // MARK: Action popToRoot
    @objc func popToRootButtonAction() {
        self.navigationController?.popToRootViewController(animated: true)
        myPrint("popToRootButtonAction")
    }
    
    
    // MARK: checkAccessContent
    func checkAndShowPaywall() -> Bool {
        let accessVal = UserDefaults.standard.object(forKey: UserDefaultsKeys.userAccessObserverKey) as? Bool
        guard
            let accessVal = accessVal,
            accessVal == false
        else { return true }
        let vc2 = PaywallVC_V2(onboardingIsCompleted: true)
        let navVC = UINavigationController(rootViewController: vc2)
        navVC.modalPresentationStyle = .overFullScreen
        self.present(navVC, animated: true)
        
        return false
    }
    
    // MARK: - Share
    func shareButtonClicked() {
        let textToShare = String(describing: "Asteria App")
        guard
            let appURLToShare = URL(string: "https://apps.apple.com/app/id1622398869")
        else { return }
        let items = [textToShare, appURLToShare] as [Any]
        let avc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        //Apps to exclude sharing to
        avc.excludedActivityTypes = [
            UIActivity.ActivityType.airDrop,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
        ]
        //Present the shareView on iPhone
        DispatchQueue.main.async(qos: .default) {
            self.present(avc, animated: true) // Презент с ошибкой !
        }
    }
    
    // MARK: - setPaywallVideo
    func setLoopedVideoLayer(
        player: AVPlayer,
        named: String,
        to view: UIView,
        margins: UIEdgeInsets? = nil
    ) {
        // 1
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        guard let path = Bundle.main.path(forResource: named, ofType: "mov") else { return }
        let url = URL(fileURLWithPath: path)
        player.replaceCurrentItem(with: AVPlayerItem(url: url))
        // player
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        // 2
        view.addSubview(iv)
        NSLayoutConstraint.activate([
            iv.topAnchor.constraint(equalTo: view.topAnchor, constant: margins?.top ?? 0),
            iv.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margins?.left ?? 0),
            iv.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(margins?.right ?? 0)),
            iv.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(margins?.bottom ?? 0)),
        ])
        // 3
        iv.layoutIfNeeded()
        playerLayer.frame = iv.bounds
        iv.layer.addSublayer(playerLayer)
        player.play()
        // 4
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main) 
        { _ in
            player.seek(to: CMTime.zero)
            player.play()
        }
    }
    
}
