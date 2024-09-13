//
//  BottomSheetContainerVC.swift
//  Numerology
//
//  Created by Serj_M1Pro on 11.09.2024.
//

import UIKit


//ViewControllerPannable


// MARK: - BottomSheetContainer - 1
class BottomSheetContainer: UIViewController, UIViewControllerTransitioningDelegate {
    
    lazy var dismissTap = UITapGestureRecognizer(target: self, action: #selector(self.fadeDismissAnimation(_:)))
    
    var contentViewController: ViewControllerPannable?

    init(contentVC: ViewControllerPannable) {
        CustomPresentationController.canBeDismissed = false
        self.contentViewController = contentVC
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view.addGestureRecognizer(dismissTap)
        view.isUserInteractionEnabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.35, animations: {
            self.view.backgroundColor = .black.withAlphaComponent(0.6)
        })
        showDidAppear()
    }
    
    
    @objc func fadeDismissAnimation(_ sender: UITapGestureRecognizer? = nil) {
        UIView.animate(withDuration: 0.2, animations: {
            self.view.backgroundColor = .clear
        }, completion: { (isCompleted) in
            if isCompleted {
                self.dismiss(animated: false, completion: nil)
            }
        })
    }
    func showDidAppear() {
        guard let pvc = contentViewController else { return }
        pvc.modalPresentationStyle = .custom
        pvc.transitioningDelegate = self
        pvc.closeHandler = { [weak self] in
            print("Pannable Handler ✅⬇️")
            guard CustomPresentationController.canBeDismissed else { return }
            self?.fadeDismissAnimation()
        }
        present(pvc, animated: true)
    }
    
    var pvc: CustomPresentationController?
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        self.pvc = CustomPresentationController(presentedViewController: presented, presenting: presenting)
        pvc?.closeHandler = {
            print("tap Handler 🟠")
            guard CustomPresentationController.canBeDismissed else { return }
            self.fadeDismissAnimation()
        }
        
        return pvc
    }
}

// MARK: - View Controller Pannable
class ViewControllerPannable: UIViewController {
    
    var closeHandler: (() -> Void)?
    
    lazy var panGestureRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
    var currentPositionTouched: CGPoint?
    lazy var originalPosition: CGPoint = view.frame.origin
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func panGestureAction(_ panGesture: UIPanGestureRecognizer) {
        let speedForClose: Double = 90 // || 0
        let translation = panGesture.translation(in: view)
        let velocity = panGesture.velocity(in: view)
        //
        
        switch panGesture.state {
        case .possible: break
        case .began: break
        case .changed:
            guard translation.y > 0 else { return }
            self.view.frame.origin = CGPoint(x: 0, y: originalPosition.y + translation.y)
        case .ended:
            if velocity.y >= speedForClose &&
               CustomPresentationController.canBeDismissed {
                
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.frame.origin = CGPoint(
                        x: self.originalPosition.x,
                        y: self.originalPosition.y + self.view.frame.height
                    )
                }, completion: { (isCompleted) in
                    if isCompleted {
                        
                        self.dismiss(animated: false, completion: nil)
                        self.closeHandler?()
                    }
                })
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.frame.origin = CGPoint(x: 0, y: self.originalPosition.y) // back to origin Position
                })
            }
        case .cancelled: break
        case .failed: break
        @unknown default: break
        }
    }
}

// MARK: -  Custom Presentation Controller
final class CustomPresentationController: UIPresentationController {
        
    static var canBeDismissed: Bool = false
    
    var closeHandler: (() -> Void)?

    private lazy var dimmingView: UIView = {
        let dimmingView = UIView()
        dimmingView.backgroundColor = .clear
        let recognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissTap)
        )
        dimmingView.addGestureRecognizer(recognizer)
        return dimmingView
    }()

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let bounds = containerView?.bounds else { return .zero }
        let position = CGRect(
            x: 0,
            y: bounds.height-preferredContentSize.height,
            width: preferredContentSize.width,
            height: preferredContentSize.height
        )
        return position
    }
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else {
            return
        }
        dimmingView.frame = containerView.bounds
        containerView.insertSubview(dimmingView, at: 0)
    }
    
    @objc func dismissTap() {
        guard CustomPresentationController.canBeDismissed else { return }
        presentingViewController.dismiss(animated: true)
        closeHandler?()
    }
}
