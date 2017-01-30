//
//  ObservableViewController.swift
//  ObservableViewController
//
//  Created by satorun on 2017/01/28.
//  Copyright © 2017年 satorun. All rights reserved.
//

import UIKit

open class FineViewController: UIViewController {
    
    public enum ShowTiming {
        case firstTime
        case normal // pushViewController, presenteViewController etc.
        case fromBackground
        case fromModalDismissing
    }
    
    public enum HideTiming {
        case coverredWithModal
        case normal // dismissViewController, popViewController etc.
        case enterBackground
    }
    
    // Override this method
    open func viewDidShow(timing: ShowTiming) {
    }
    
    // Override this method
    open func viewDidHide(timing: HideTiming) {
    }
    
    private var applicationWillEnterForeground = false
    private var hasPresentedViewController = false
    private var hasBeenDisplayedOnce = false
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        hasBeenDisplayedOnce = false
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if presentedViewController != nil {
            hasPresentedViewController = true
        }
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if hasPresentedViewController {
            hasPresentedViewController = false
            viewDidShow(timing: .fromModalDismissing)
        } else if !hasBeenDisplayedOnce {
            viewDidShow(timing: .firstTime)
        } else {
            viewDidShow(timing: .normal)
        }
        hasBeenDisplayedOnce = true

        addObservers()
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if presentedViewController != nil {
            viewDidHide(timing: .coverredWithModal)
        } else {
            viewDidHide(timing: .normal)
        }
        removeObservers()
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applicationDidBecomeActive(_:)),
            name: NSNotification.Name.UIApplicationDidBecomeActive,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applicationWillEnterForeground(_:)),
            name: NSNotification.Name.UIApplicationWillEnterForeground,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applicationDidEnterBackground(_:)),
            name: NSNotification.Name.UIApplicationDidEnterBackground,
            object: nil)
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    // Override this method if needed.
    // Require to call super.
    open func applicationDidBecomeActive(_ notification: Notification) {
        if applicationWillEnterForeground {
            applicationWillEnterForeground = false
            viewDidShow(timing: .fromBackground)
        }
    }
    
    // Override this method if needed.
    // Require to call super.
    open func applicationWillEnterForeground(_ notification: Notification) {
        applicationWillEnterForeground = true
    }
    
    // Override this method if needed.
    // Require to call super.
    open func applicationDidEnterBackground(_ notification: Notification) {
        viewDidHide(timing: .enterBackground)
    }
}
