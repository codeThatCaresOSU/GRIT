//
//  BasicsFirstPage.swift
//  GRIT
//
//  Created by Jake Alvord on 12/7/17.
//  Copyright © 2017 CodeThatCares. All rights reserved.
//

import UIKit

protocol BasicsFirstPageDelegate {
    func dismiss_basics_first()
}

class BasicsFirstPage : UIPageViewController, UIPageViewControllerDataSource, BasicsThirdPageDelegate {

    var t_delegate: BasicsFirstPageDelegate! = nil
    
    let b_sec = BasicsSecondPage()
    let b_thi = BasicsThirdPage()
    
    var views : [UIViewController]? = nil
    
    var index = 0
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        dataSource = self
        
        views = [b_sec, b_thi]
        
        if let first_view = views?.first {
            setViewControllers([first_view], direction: .forward, animated: true, completion: nil)
        }
        
        self.b_thi.delegate = self
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = views?.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard (views?.count)! > previousIndex else {
            return nil
        }
        
        return views?[previousIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = views?.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = views?.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount! > nextIndex else {
            return nil
        }
        
        return views?[nextIndex]
        
    }
    
    /*func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return views.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first, let firstViewControllerIndex = views.index(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex    }*/
    
    @objc func first_dismiss() {
        self.t_delegate.dismiss_basics_first()
    }
    
    func dismiss_basics_third() {
        first_dismiss()
    }
 
}
