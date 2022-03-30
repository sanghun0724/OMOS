//
//  MydjProfileViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/27.
//

import UIKit
import KakaoSDKUser

class MydjProfileViewController:BaseViewController {
    
    private let selfView = MydjProfieView()
    let viewModel:MyDjProfileViewModel
    let fromId = UserDefaults.standard.integer(forKey: "user")
    let toId:Int
    
    init(viewModel:MyDjProfileViewModel,toId:Int) {
        self.viewModel = viewModel
        self.toId = toId
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
        self.navigationItem.rightBarButtonItems?.removeAll()
        viewModel.fetchMyDjProfile(fromId: fromId, toId: toId)
        viewModel.fetchUserRecords(fromId: fromId, toId: toId)
        
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
        viewModel.profileLoading
            .subscribe(onNext: { [weak self] loading in
                self?.selfView.profileLoadingView.isHidden = !loading
            }).disposed(by: disposeBag)
        
        viewModel.recordsLoading
            .subscribe(onNext: { [weak self] loading in
                self?.selfView.recordsLoadingView.isHidden = !loading
            }).disposed(by: disposeBag)
        
        viewModel.mydjProfile
            .subscribe(onNext: { [weak self] _ in
                self?.selfView.tableView.reloadSections(IndexSet(0..<1), with: .automatic)
            }).disposed(by: disposeBag)
        
        viewModel.userRecords
            .subscribe(onNext: { [weak self] _ in
                self?.selfView.tableView.reloadData()
            }).disposed(by: disposeBag)
        
        
    }
    
}
