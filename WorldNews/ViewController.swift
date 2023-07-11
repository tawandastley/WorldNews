//
//  ViewController.swift
//  WorldNews
//
//  Created by Tawanda Chandiwana on 2023/07/02.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    
    private var animationView: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimation()
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(loadHomePage), userInfo: nil, repeats: false)
    }
    
    @objc func loadHomePage() {
        let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setupAnimation() {
        animationView = .init(name: "worldNews")
        animationView.frame = view.frame
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.5
        view.addSubview(animationView)
        animationView.play()
    }
}
