//
//  ArtistAlbumViewController.swift
//  Omos
//
//  Created by sangheon on 2022/03/08.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ArtistAlbumViewController:BaseViewController,UIScrollViewDelegate {
    
    let selfView = AlbumView()
    let viewModel:SearchArtistDetailViewModel
    let disposebag = DisposeBag()
    var isPaging:Bool = false
    var hasNextPage:Bool = true
    var pagingCount = 0
    let artistId:String
    
    init(viewModel:SearchArtistDetailViewModel,artistId:String,searchType:SearchType) {
        self.viewModel = viewModel
        self.artistId = artistId
        self.viewModel.searchType = searchType
        print("check Type \(searchType)")
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
        
        viewModel.artistAlbum
            .subscribe({ [weak self] data in
                self?.hasNextPage = self?.viewModel.currentArtistAlbum.count ?? 0 > 300 ? false : true
                self?.isPaging = false
                self?.selfView.tableView.reloadData()
            }).disposed(by: disposebag)
        
        viewModel.albumLoading
            .subscribe(onNext: { [weak self] loading in
                //self?.selfView.loadingView.isHidden = !loading
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
        
        viewModel.artistDetailAlbumFetch(artistId: artistId, request: .init(artistId: artistId, limit: 20, offset: 0))
        
    }
    
}

extension ArtistAlbumViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.currentArtistAlbum.count
        } else if section == 1 && isPaging && hasNextPage {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableCell.identifier, for: indexPath) as! AlbumTableCell
            let cellData = viewModel.currentArtistAlbum[indexPath.row]
            cell.configureModel(album: cellData,keyword: viewModel.currentKeyword)
            cell.selectionStyle = . none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.identifier, for: indexPath) as! LoadingCell
            return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cellData = viewModel.currentArtistAlbum[indexPath.row]
        let rp = SearchRepositoryImpl(searchAPI: SearchAPI())
        let uc = SearchUseCase(searchRepository: rp)
        let vm = SearchAlbumDetailViewModel(usecase: uc)
        let vc = SearchAlbumDetailViewController(viewModel: vm, albumInfo: cellData, searchType: viewModel.searchType)
        self.navigationController?.pushViewController(vc, animated: true)
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
