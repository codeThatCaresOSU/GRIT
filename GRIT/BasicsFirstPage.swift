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

class BasicsFirstPage : UIPageViewController, UIPageViewControllerDataSource, BasicsSeventhPageDelegate, BasicsLastBackToFirst {

    var t_delegate: BasicsFirstPageDelegate! = nil
    
    let b_sec = BasicsSecondPage()
    let b_thi = BasicsThirdPage()
    let b_fou = BasicsFourthPage()
    let b_fif = BasicsFifthPage()
    let b_six = BasicsSixthPage()
    let b_sev = BasicsSeventhPage()
    
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
        
        views = [b_sec, b_thi, b_fou, b_fif, b_six, b_sev]
        
        if let first_view = views?.first {
            setViewControllers([first_view], direction: .forward, animated: true, completion: nil)
        }
        
        self.b_sev.delegate = self
        self.b_sev.redelegate = self
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = views?.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        index = previousIndex
        
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
        index = nextIndex
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
        self.t_delegate.dismiss_basics_first()
    }
    
    func dismiss_basics_last() {
        first_dismiss()
    }
    
    func back_to_front() {
        if let first_view = views?.first {
            setViewControllers([first_view], direction: .forward, animated: true, completion: nil)
        }
    }
    
 
}
