//
//  FollowListViewController.swift
//  Omos
//
//  Created by sangheon on 2022/05/27.
//
import Pageboy
import Tabman
import UIKit

final class FollowListViewController: TabmanViewController {
    let viewModel: FollowListViewModel
    var viewControllers: [UIViewController] = []
    let page: PageboyViewController.Page?
    
    init(viewModel: FollowListViewModel, page: PageboyViewController.Page?) {
        self.page = page
        self.viewModel = viewModel
        viewControllers = [BaseListDecorator(decoratorAction: FollowerListViewController(viewModel: self.viewModel)), BaseListDecorator(decoratorAction: FollowingListViewController(viewModel: self.viewModel))]
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        // Create bar
        let bar = TMBar.ButtonBar()
        settingTabBar(ctBar: bar)
        addBar(bar, dataSource: self, at: .top)
    }
    
    private func settingTabBar (ctBar: TMBar.ButtonBar) {
        ctBar.layout.transitionStyle = .snap
        ctBar.layout.contentMode = .fit
        
        // 왼쪽 여백주기
        ctBar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 13.0, bottom: 0.0, right: 20.0)
        
        // 간격
        ctBar.layout.interButtonSpacing = 35
        ctBar.backgroundView.style = .custom(view: TabBarBackgroundView())
        
        // 선택 / 안선택 색 + font size
        ctBar.buttons.customize { button in
            button.tintColor = .mainGrey5
            button.selectedTintColor = .mainOrange
            button.font = UIFont.systemFont(ofSize: 16)
            button.selectedFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        }
        
        // 인디케이터 (영상에서 주황색 아래 바 부분)
        ctBar.indicator.weight = .custom(value: 4)
        ctBar.indicator.tintColor = .mainOrange
    }
}

extension FollowListViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "팔로워")
        case 1:
            return TMBarItem(title: "팔로잉")
        default:
            let title = "Page \(index)"
            return TMBarItem(title: title)
        }
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        page
    }
}
