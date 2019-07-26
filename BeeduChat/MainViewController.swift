//
//  MainViewController.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/27/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

class MainViewController : UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [TNNewFeedViewController(), TNChatManagerViewController()]
    }
}
