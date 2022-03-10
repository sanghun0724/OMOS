//
//  AllRecordViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/06.
//

import UIKit
import SnapKit

class AllRecordViewController: BaseViewController {
    
    var selectedRecords:SelectResponse?
    let viewModel:AllRecordViewModel
    
    init(viewModel:AllRecordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let selfView = AllRecordView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selfView.tableView.delegate = self
        selfView.tableView.dataSource = self
        bind()
        viewModel.selectRecordsShow()
        setRightItems()
    }
    
    func setRightItems() {
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(didTapSearchButton))
        searchButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = searchButton
    }
    
    @objc func didTapSearchButton() {
        let rp = SearchRepositoryImpl(searchAPI: SearchAPI())
        let uc = SearchUseCase(searchRepository: rp)
        let vm = SearchViewModel(usecase: uc)
        let vc = SearchViewController(viewModel: vm, searchType: .main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func configureUI() {
        view.addSubview(selfView)
        
        selfView.snp.makeConstraints { make in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func bind() {
        viewModel.selectRecords
            .withUnretained(self)
            .subscribe(onNext: { owner,info in
                owner.selectedRecords = info
                owner.selfView.tableView.reloadData()
            }).disposed(by: disposeBag)
        
        viewModel.loading
            .withUnretained(self)
            .subscribe(onNext: { owner,loading in
                owner.selfView.loadngView.isHidden = !loading
            }).disposed(by: disposeBag)
    }
}

extension AllRecordViewController:AllCollectCellprotocol {
    func collectionView(collectionViewCell: AllRecordCollectionCell?, index: Int, didTappedInTableViewCell: AllRecordTableCell) {
        let cate = collectionViewCell?.titleLabel.text
        let vc = AllRecordDetailViewController(category: cate ?? "empty")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
