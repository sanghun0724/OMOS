//
//  SearchArtistTopTabView.swift
//  Omos
//
//  Created by sangheon on 2022/02/28.
//
import Pageboy
import RxSwift
import Tabman
import UIKit

class SearchArtistTopTabViewController: TabmanViewController {
    var viewControllers: [UIViewController] = []
    let viewModel: SearchArtistDetailViewModel
    let artistId: String

    init(viewModel: SearchArtistDetailViewModel, artistId: String) {
        self.viewModel = viewModel
        self.artistId = artistId
        self.viewControllers.append(ArtistSongViewController(viewModel: viewModel, artistId: artistId))
        self.viewControllers.append(ArtistAlbumViewController(viewModel: viewModel, artistId: artistId, searchType: viewModel.searchType))
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.reloadData()
        self.dataSource = self

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

extension SearchArtistTopTabViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        // MARK: - Tab 안 글씨들
        switch index {
        case 0:
            return TMBarItem(title: "노래")
        case 1:
            return TMBarItem(title: "앨범")
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
