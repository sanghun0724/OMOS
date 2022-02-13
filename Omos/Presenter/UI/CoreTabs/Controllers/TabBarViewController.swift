//
//  TabbarController.swift
//  Omos
//
//  Created by sangheon on 2022/02/06.
//


import UIKit
import RxSwift
import RxRelay

class TabBarViewController: UITabBarController {
    
    static var titles:[(String,String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }
    
    private func setupControllers() {
        //        guard let currentUserEmail = UserDefaults.standard.string(forKey: "email") else {
        //            print("dont have current user email")
        //            return
        //        }
        let home = HomeViewController()
        let myRecord = MyRecordViewController()
        let allRecord = AllRecordViewController(viewModel: AllRecordViewModel())
        let myDj = MyDJViewController()
        let profile = ProfileViewController()
        
        
        let nav1 = UINavigationController(rootViewController: home)
        let nav2 = UINavigationController(rootViewController: myRecord)
        let nav3 = UINavigationController(rootViewController: allRecord)
        let nav4 = UINavigationController(rootViewController: myDj)
        let nav5 = UINavigationController(rootViewController: profile)
        
        nav1.tabBarItem = UITabBarItem(title: "투데이", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "MY 레코드", image: UIImage(systemName: "house"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "전체 레코드", image: UIImage(systemName: "house"), tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "MY DJ", image: UIImage(systemName: "house"), tag: 4)
        nav5.tabBarItem = UITabBarItem(title: "MY 페이지", image: UIImage(systemName: "person.circle"), tag: 5)
        
        let navs = [nav1,nav2,nav3,nav4,nav5]
        setViewControllers(navs, animated: true)
        tabBar.isTranslucent = false
        
        
        navs.forEach { nav in
            TabBarViewController.titles.append((nav.tabBarItem.title ?? "nil",String(describing: type(of: nav.viewControllers.first.self!))))
        }
    }
    
}
