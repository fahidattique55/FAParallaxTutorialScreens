//
//  ViewController.swift
//  TutorialScreenSample
//
//  Created by Fahid Attique on 15/04/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //  MARK : IBOutlets
    
    @IBOutlet weak var backGroundImageView: UIImageView!
    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!


    //  MARK : Public Properties

    var initialOffset:CGFloat = 0.0
    
    
    //  MARK : Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        viewConfigurations()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    //  MARK : Statusbar Style

    override var preferredStatusBarStyle: UIStatusBarStyle{
        get{
            return .lightContent
        }
    }
    
    
    //  MARK : Private Functions
    
    private func viewConfigurations() {
        
        addObservers()
        configureChildVCs()
    }

    
    private func addObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(startAnimating), name:NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    private func configureChildVCs(){
    
        let totalVCs = 4
        pageControl.numberOfPages = totalVCs
        
        for index in 0 ..< totalVCs {
            let childVC:FAChildVC = childVCFor(index: index)
            addInScrollView(childVC:childVC)
        }
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width * CGFloat(totalVCs), height: UIScreen.main.bounds.size.height)
    }
    
    private func childVCFor(index:NSInteger) -> FAChildVC {
        
        let childVC = FAChildVC(nibName: "FAChildVC_\(index)", bundle: nil)
        
        var rect:CGRect = UIScreen.main.bounds
        rect.origin.x = CGFloat(index) * rect.size.width;
        childVC.view.frame = rect

        return childVC
    }
    
    private func addInScrollView(childVC:FAChildVC){

        childVC.willMove(toParentViewController: self)
        scrollView.addSubview(childVC.view)
        childVC.didMove(toParentViewController: self)
    }
    
    
    
    //  MARK : Public Functions
    
    func startAnimating(){
        
        if backGroundImageView.layer.animation(forKey: "center") == nil {
            backGroundImageView.layer.add(animationForXAxis(), forKey: "center")
        }
    }

    func animationForXAxis() -> CABasicAnimation {
        
        let animation:CABasicAnimation = CABasicAnimation()
        animation.keyPath = "position.x"
        animation.byValue = 30
        animation.duration = 3.0
        animation.autoreverses = true
        animation.repeatCount = MAXFLOAT
        
        return animation
    }
}


extension ViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        var center = backGroundImageView.center
        center.x = center.x - (scrollView.contentOffset.x - initialOffset)/3
        backGroundImageView.center = center

        initialOffset = scrollView.contentOffset.x
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = NSInteger(scrollView.contentOffset.x)/NSInteger(scrollView.frame.size.width)
    }
}
