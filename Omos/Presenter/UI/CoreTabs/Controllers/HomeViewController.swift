//
//  HomeViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/06.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController:BaseViewController {
    
    let selfView = HomeView()
    let viewModel:HomeViewModel
    
    init(viewModel:HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        selfView.tableView.dataSource = self
        selfView.tableView.delegate = self
        viewModel.allHomeDataFetch(userId: Account.currentUser)
        print(UserDefaults.standard.string(forKey: "access"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func configureUI() {
        super.configureUI()
        self.view.addSubview(selfView)
        
        selfView.snp.makeConstraints { make in
            make.top.trailing.leading.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
    }
    
    func bind() {
        viewModel.allLoading
            .subscribe(onNext: { [weak self] loading in
                self?.selfView.loadingView.isHidden = !loading
                self?.selfView.tableView.reloadData()
            }).disposed(by: disposeBag)
        
        selfView.floatingButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                let rp = SearchRepositoryImpl(searchAPI: SearchAPI())
                let uc = SearchUseCase(searchRepository: rp)
                let vm = SearchViewModel(usecase: uc)
                let vc = SearchViewController(viewModel: vm, searchType: .me)
                self?.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: disposeBag)
        
    }
    
    
}


extension HomeViewController:AllCollectCellprotocol {
    func collectionView(collectionViewCell: AllRecordCollectionCell?, cate: String, didTappedInTableViewCell: AllRecordTableCell) {
        
        guard let postId = collectionViewCell?.homeInfo?.recordID,
              let userId = collectionViewCell?.homeInfo?.userID else { return }

         if Account.currentUser == userId {
             let rp = RecordsRepositoryImpl(recordAPI: RecordAPI())
             let uc = RecordsUseCase(recordsRepository: rp)
             let vm = MyRecordDetailViewModel(usecase: uc)
             let vc = MyRecordDetailViewController(posetId: postId, viewModel: vm)
             self.navigationController?.pushViewController(vc, animated: true)
         } else {
             let rp = RecordsRepositoryImpl(recordAPI: RecordAPI())
             let uc = RecordsUseCase(recordsRepository: rp)
             let vm = AllRecordDetailViewModel(usecase: uc)
             let vc = AllRecordDetailViewController(viewModel: vm, postId: postId, userId: userId)
             self.navigationController?.pushViewController(vc, animated: true)
         }
    }
}

extension HomeViewController:HomeTableMiddleCellprotocol {
    func collectionView(collectionViewCell: MydjCollectionCell?, index: Int, didTappedInTableViewCell: HomeTableMiddleCell) {
        guard let userId = collectionViewCell?.homeInfo?.userID else { return }
        
        let rp = RecordsRepositoryImpl(recordAPI: RecordAPI())
        let uc = RecordsUseCase(recordsRepository: rp)
        let vm = MyDjProfileViewModel(usecase: uc)
        let vc = MydjProfileViewController(viewModel: vm, toId: userId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}



