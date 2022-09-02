//
//  TabBarPresenter.swift
//  rss.ios.stage3-final task
//
//  Created by Albert Zhloba on 1.11.21.
//
//
import UIKit
import CoreData
import Gradients

protocol TabBarViewProtocol:AnyObject {
}

protocol TabBarPresenterProtocol: AnyObject {
    init(view: TabBarViewProtocol, router: RouterTabBarProtocol)
    func configureTabBar(view: UITabBarController)
}

class TabBarPresenter: TabBarPresenterProtocol {
    public weak var view: TabBarViewProtocol?
    var router: RouterTabBarProtocol?
    required init(view: TabBarViewProtocol, router: RouterTabBarProtocol) {
        self.view = view
        self.router = router
    }
    
    func configureTabBar(view: UITabBarController) {
        let vc1 = HomeVC(api: APICaller.shared)
        vc1.navigationItem.largeTitleDisplayMode = .always
        let vc2 = SearchVC()
        vc2.navigationItem.largeTitleDisplayMode = .always
        let vc3 = ProfileVC()
        vc3.navigationItem.largeTitleDisplayMode = .always
        
        let nav1 = NavigationFirst(rootViewController: vc1)
        let nav2 = NavigationSecond(rootViewController: vc2)
        let nav3 = NavigationThird(rootViewController: vc3)
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        
        view.viewControllers = [nav1, nav2, nav3]
        
        nav1.tabBarItem.title = "Sounds"
        nav1.tabBarItem.image = UIImage(systemName: "headphones")
        
        nav2.tabBarItem.title = "Search"
        nav2.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        nav3.tabBarItem.title = "Profile"
        nav3.tabBarItem.image = UIImage(systemName: "gear")
    
    }
}
