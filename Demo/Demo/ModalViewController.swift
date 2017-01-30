//
//  ModalViewController.swift
//  ObservableViewController
//
//  Created by satorun on 2017/01/28.
//  Copyright © 2017年 satorun. All rights reserved.
//

import UIKit
import FineViewController

class ModalViewController: FineViewController {
    
    override func viewDidShow(timing: FineViewController.ShowTiming) {
        print("\(self) did show: \(timing)")
    }
    
    override func viewDidHide(timing: FineViewController.HideTiming) {
        print("\(self) did hide: \(timing)")
    }
    
    @IBAction func tappedReturnButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
