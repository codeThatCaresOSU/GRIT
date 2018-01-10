//
//  AdvancedFirstPage.swift
//  GRIT
//
//  Created by Jake Alvord on 1/9/18.
//  Copyright © 2018 CodeThatCares. All rights reserved.
//

import UIKit

protocol AdvancedFirstPageDelegate {
    func dismiss_advanced_first()
}

class AdvancedFirstPage : UIPageViewController, UIPageViewControllerDataSource, AdvancedFourthPageDelegate, AdvancedBackToFirst {
    
    var a_delegate: AdvancedFirstPageDelegate! = nil
    
    let a_sec = AdvancedSecondPage()
    let a_thi = AdvancedThirdPage()
    let a_fou = AdvancedFourthPage()

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
        
        views = [a_sec, a_thi, a_fou]
        
        if let first_view = views?.first {
            setViewControllers([first_view], direction: .forward, animated: true, completion: nil)
        }
        
        self.a_fou.delegate = self
        self.a_fou.redelegate = self
        
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
    
    @objc func first_dismiss() {
        self.a_delegate.dismiss_advanced_first()
    }
    
    func dismiss_advanced_last() {
        first_dismiss()
    }
    
    func back_to_beginning() {
        if let first_view = views?.first {
            setViewControllers([first_view], direction: .forward, animated: true, completion: nil)
        }
    }
}
