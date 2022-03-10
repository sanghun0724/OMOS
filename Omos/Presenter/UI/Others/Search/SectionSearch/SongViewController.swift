//
//  SongViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/27.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class SongViewController:BaseViewController,UIScrollViewDelegate {
    
    let selfView = SongView()
    let viewModel:SearchViewModel
    let disposebag = DisposeBag()
    var isPaging:Bool = false
    var hasNextPage:Bool = true
    var pagingCount = 0
    
    init(viewModel:SearchViewModel) {
        self.viewModel = viewModel
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
        selfView.emptyView.isHidden = !(viewModel.currentTrack.isEmpty)
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
        
        viewModel.track
            .subscribe({ [weak self] data in
                self?.hasNextPage = self?.viewModel.currentTrack.count ?? 0 > 300 ? false : true
                self?.isPaging = false
                self?.selfView.tableView.reloadData()
            }).disposed(by: disposebag)
        
        viewModel.isTrackEmpty
            .withUnretained(self)
            .subscribe(onNext: { owner,empty in
                owner.selfView.emptyView.isHidden = !empty
            }).disposed(by: disposeBag)
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        
        // 스크롤이 테이블 뷰 Offset의 끝에 가게 되면 다음 페이지를 호출
        if offsetY > (contentHeight - height) {
            if isPaging == false && hasNextPage {
                beginPaging()
            }
        }
    }
    func beginPaging() {
        isPaging = true
        
        selfView.tableView.reloadSections(IndexSet(integer: 1), with: .none)
        
        viewModel.trackFetch(request: .init(keyword: self.viewModel.currentKeyword, limit: 20, offset: pagingCount + 20))
        
    }
    
}

extension SongViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.currentTrack.count
        } else if section == 1 && isPaging && hasNextPage {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SongTableCell.identifier, for: indexPath) as! SongTableCell
            viewModel.searchType == .me ? (cell.createdButton.isHidden = false) : (cell.createdButton.isHidden = true)
            let cellData = viewModel.currentTrack[indexPath.row]
            cell.configureModel(track: cellData)
            cell.selectionStyle = . none
            cell.createdButton.rx.tap
                .asDriver()
                .drive(onNext: { [weak self] _ in
                    print("click")
                    let vc = CategoryViewController(defaultModel: .init(musicId:cellData.musicID, imageURL: cellData.albumImageURL, musicTitle: cellData.musicTitle, subTitle: cellData.artists.map { $0.artistName }.reduce("") { $0 + " \($1)"}))
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
        let cellData = viewModel.currentTrack[indexPath.row]
        if viewModel.searchType == .main {
            let rp = RecordsRepositoryImpl(recordAPI: RecordAPI())
            let uc = RecordsUseCase(recordsRepository: rp)
            let vm = AllRecordSearchDetailViewModel(usecase: uc)
            let vc = AllRecordSearchDetailViewController(viewModel: vm, musicId: cellData.musicID)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.mainHeight * 0.094
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}
