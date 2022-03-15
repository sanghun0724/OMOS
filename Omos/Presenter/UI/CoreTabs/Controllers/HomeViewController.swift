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
        self.navigationController?.navigationBar.isHidden = true
        viewModel.allHomeDataFetch()
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
        
        
    }
    
    
}

