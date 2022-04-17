//
//  ArtistSongViewController.swift
//  Omos
//
//  Created by sangheon on 2022/03/08.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class ArtistSongViewController: BaseViewController, UIScrollViewDelegate {
    let selfView = SongView()
    let viewModel: SearchArtistDetailViewModel
    let disposebag = DisposeBag()
    var isPaging: Bool = false
    var hasNextPage: Bool = true
    var pagingCount = 0
    let artistId: String

    init(viewModel: SearchArtistDetailViewModel, artistId: String) {
        self.viewModel = viewModel
        self.artistId = artistId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        selfView.tableView.delegate = self
        selfView.tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    override func configureUI() {
        super.configureUI()
        self.view.addSubview(selfView)

        selfView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
    }

    func bind() {
        viewModel.artistTrack
            .subscribe({ [weak self] _ in
                self?.hasNextPage = self?.viewModel.currentArtistTrack.count ?? 0 > 300 ? false : true
                self?.isPaging = false
                self?.selfView.tableView.reloadData()
            }).disposed(by: disposebag)

        viewModel.trackLoading
            .subscribe(onNext: { [weak self] loading in
                self?.selfView.loadingView.isHidden = !loading
            }).disposed(by: disposebag)
    }

//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//          let offsetY = scrollView.contentOffset.y
//          let contentHeight = scrollView.contentSize.height
//          let height = scrollView.frame.height
//
//          // 스크롤이 테이블 뷰 Offset의 끝에 가게 되면 다음 페이지를 호출
//          if offsetY > (contentHeight - height) {
//              if isPaging == false && hasNextPage {
//                  beginPaging()
//              }
//          }
//      }

    func beginPaging() {
        isPaging = true

        selfView.tableView.reloadSections(IndexSet(integer: 1), with: .none)

        viewModel.artistDetailTrackFetch(artistId: artistId)
    }
}

extension ArtistSongViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.currentArtistTrack.count
        } else if section == 1 && isPaging && hasNextPage {
            return 1
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SongTableCell.identifier, for: indexPath) as! SongTableCell
            viewModel.searchType == .me ? (cell.createdButton.isHidden = false) : (cell.createdButton.isHidden = true)
            let cellData = viewModel.currentArtistTrack[indexPath.row]
            cell.configureModelArtistTrack(track: cellData, keyword: viewModel.currentKeyword)
            cell.selectionStyle = . none
            cell.createdButton.rx.tap
                .asDriver()
                .drive(onNext: { [weak self] _ in
                    print("click")
                    let vc = CategoryViewController(defaultModel: .init(musicId: cellData.musicID, imageURL: cellData.albumImageURL, musicTitle: cellData.musicTitle, subTitle: cellData.artistName.reduce("") { $0 + " \($1)" }))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }).disposed(by: cell.disposeBag)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.identifier, for: indexPath) as! LoadingCell
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if viewModel.searchType == .main {
            let cellData = viewModel.currentArtistTrack[indexPath.row]
            let rp = RecordsRepositoryImpl(recordAPI: RecordAPI())
            let uc = RecordsUseCase(recordsRepository: rp)
            let vm = AllRecordSearchDetailViewModel(usecase: uc)
            let vc = AllRecordSearchDetailViewController(viewModel: vm, musicId: cellData.musicID)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constant.mainHeight * 0.094
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UIView()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }
}
