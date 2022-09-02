//
//  TabBarVC.swift
//  rss.ios.stage3-final task
//
//  Created by Albert Zhloba on 1.11.21.
//

import UIKit

class TabBarVC: UITabBarController {
    var presenter: TabBarPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}

extension TabBarVC: TabBarViewProtocol {
    
}
