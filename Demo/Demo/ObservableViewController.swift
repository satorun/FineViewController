//
//  ObservableViewController.swift
//  ObservableViewController
//
//  Created by satorun on 2017/01/28.
//  Copyright © 2017年 satorun. All rights reserved.
//

import UIKit

// FineViewControllerにする
class ObservableViewController: UIViewController {

    ///// 表示
    // Pushからアプリを起動して目的のviewとして表示されたとき
    // Pushからアプリを前面に復帰して目的のviewとして表示されたとき
    // 前面にいるときにPushをタップして目的のviewとして表示されたとき
    // Pushからアプリを起動して目的のviewとしてではないが表示されたとき
    // Pushからアプリを前面に復帰して目的のviewとしてではないが表示されたとき
    // 前面にいるときにPushをタップして目的のviewとしてではないが表示されたとき
    
    // アプリを前面に復帰して表示されたとき
    // navigationVCにaddされたとき
    // navigationVCが上のVCをpopして表示されたとき
    // モーダルが閉じて表示されたとき
    // モーダルで表示されたとき
    // peekで表示されたとき
    // popで表示されたとき
    // キーボード、アラートを閉じて表示されたとき
    
    
    private var applicationWillEnterForeground = false
    private var hasPresentedViewController = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        if presentedViewController != nil {
            hasPresentedViewController = true
        }
        
        print("presentationController: \(presentationController)")
        print("presentedViewController: \(presentedViewController)")
        print("presentingViewController: \(presentingViewController)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if hasPresentedViewController {
            hasPresentedViewController = false
            print("viewDidAppearFromModalDismissing")
        } else {
            print("viewDidAppear")
        }
        
        print("presentationController: \(presentationController)")
        print("presentedViewController: \(presentedViewController)")
        print("presentingViewController: \(presentingViewController)")
        addObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if presentedViewController != nil {
            print("viewDidDisappearFromModalPresenting")
        } else {
            print("viewDidDisappear")
        }
        removeObservers()
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applicationDidBecomeActive(_:)),
            name: NSNotification.Name.UIApplicationDidBecomeActive,
            object: nil)
        
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(applicationWillResignActive(_:)),
//            name: NSNotification.Name.UIApplicationWillResignActive,
//            object: nil)
        
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
        NotificationCenter.default.removeObserver(self)
    }
    
    func applicationDidBecomeActive(_ notification: Notification) {
        if applicationWillEnterForeground {
            applicationWillEnterForeground = false
            print("applicationDidBecomeActiveFromBackground")
        } else {
            print("applicationDidBecomeActive")
        }
    }
    
//    func applicationWillResignActive(_ notification: Notification) {
//        print("applicationWillResignActive")
//    }
    
    func applicationWillEnterForeground(_ notification: Notification) {
        print("applicationWillEnterForeground")
        applicationWillEnterForeground = true
    }
    
    func applicationDidEnterBackground(_ notification: Notification) {
        print("applicationDidEnterBackground")
    }
}
