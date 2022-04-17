//
//  TopTabViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/27.
//

import Pageboy
import RxSwift
import Tabman
import UIKit

class TopTabViewController: TabmanViewController {
    let disposeBag = DisposeBag()
    let viewModel: SearchViewModel
    var viewControllers: [UIViewController] = []

    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        bind()

        let bar = TMBar.ButtonBar()
        settingTabBar(ctBar: bar)
        addBar(bar, dataSource: self, at: .top)
    }

    func settingTabBar(ctBar: TMBar.ButtonBar) {
        ctBar.layout.transitionStyle = .snap
        ctBar.layout.contentMode = .fit
              // 왼쪽 여백주기
              ctBar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 13.0, bottom: 0.0, right: 20.0)

              // 간격
              ctBar.layout.interButtonSpacing = 35

              ctBar.backgroundView.style = .custom(view: tabBarBackgroundView())

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

    func bind() {
        // relaod
        viewModel.isReload
            .withUnretained(self)
            .subscribe(onNext: { _, _ in
            }).disposed(by: disposeBag)

        Observable.zip(viewModel.album, viewModel.track, viewModel.artist)
            .take(1)
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                let entireVC = EntireViewController(viewModel: owner.viewModel)
                let songVC = SongViewController(viewModel: owner.viewModel)
                let albumVC = AlbumViewController(viewModel: owner.viewModel)
                let artistVC = ArtistViewController(viewModel: owner.viewModel)
                owner.viewControllers = [entireVC, songVC, albumVC, artistVC]
                self.reloadData()
            }).disposed(by: disposeBag)
    }
}

extension TopTabViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
            // MARK: - Tab 안 글씨들
            switch index {
            case 0:
                return TMBarItem(title: "전체")
            case 1:
                return TMBarItem(title: "노래")
            case 2:
                return TMBarItem(title: "앨범")
            case 3:
                return TMBarItem(title: "아티스트")
            default:
                let title = "Page \(index)"
                return TMBarItem(title: title)
            }
        }

        func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
            // 위에서 선언한 vc array의 count를 반환합니다.
            return viewControllers.count
        }

        func viewController(for pageboyViewController: PageboyViewController,
                            at index: PageboyViewController.PageIndex) -> UIViewController? {
            viewControllers[index]
        }

        func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
            nil
        }
}
