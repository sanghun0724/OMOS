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
        
        let home = HomeViewController(viewModel: HomeViewModel(usecase: TodayUseCase(todayRepository: TodayRepositoryImpl(todayAPI: TodayAPI()))))
        let myRecord = MyRecordViewController(viewModel: MyRecordViewModel(usecase: RecordsUseCase(recordsRepository: RecordsRepositoryImpl(recordAPI: RecordAPI()))))
        let allRecord = AllRecordViewController(viewModel: AllRecordViewModel(usecase: RecordsUseCase(recordsRepository: RecordsRepositoryImpl(recordAPI: RecordAPI()))))
        let myDj = MyDJViewController(viewModel: MyDjViewModel(usecase: RecordsUseCase(recordsRepository: RecordsRepositoryImpl(recordAPI: RecordAPI()))))
        let profile = ProfileViewController()
        
        
        let nav1 = UINavigationController(rootViewController: home)
        let nav2 = UINavigationController(rootViewController: myRecord)
        let nav3 = UINavigationController(rootViewController: allRecord)
        let nav4 = UINavigationController(rootViewController: myDj)
        let nav5 = UINavigationController(rootViewController: profile)
        
        nav1.tabBarItem = UITabBarItem(title: "투데이", image: UIImage(named: "home"), selectedImage: UIImage(named: "home2"))
        nav2.tabBarItem = UITabBarItem(title: "MY 레코드", image: UIImage(named: "myrecord"), selectedImage: UIImage(named:"myrecord2" ))
        nav3.tabBarItem = UITabBarItem(title: "전체 레코드", image: UIImage(named: "allrecord"), selectedImage: UIImage(named:"allrecord2" ))
        nav4.tabBarItem = UITabBarItem(title: "MY DJ", image:UIImage(named: "mydj"), selectedImage: UIImage(named:"mydj2" ))
        nav5.tabBarItem = UITabBarItem(title: "MY 페이지", image: UIImage(named: "mypage"), selectedImage: UIImage(named:"mypage2" ))
        self.tabBar.selectedImageTintColor = .mainOrange
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.mainGrey5], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.mainOrange], for: .selected)
       
        //UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = .mainBackGround
        
        let navs = [nav1,nav2,nav3,nav4,nav5]
        setViewControllers(navs, animated: true)
        //tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .mainBackGround
        
        navs.forEach { nav in
            TabBarViewController.titles.append((nav.tabBarItem.title ?? "nil",String(describing: type(of: nav.viewControllers.first.self!))))
        }
    }
    
}
