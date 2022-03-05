//
//  MyRecordViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/06.
//

import UIKit

class MyRecordViewController: BaseViewController {
    
    private let selfView = MyRecordView()
    let viewModel:MyRecordViewModel
    var myRecord:[MyRecordRespone] = []
    
    init(viewModel:MyRecordViewModel) {
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
        configureUI()
        viewModel.myRecordFetch(userid: 1)
    }
    
    override func configureUI() {
        view.addSubview(selfView)
        
        selfView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        
    }
    
    func bind() {
        viewModel.myRecords.subscribe(onNext: { [weak self] info in
            self?.myRecord = info
            self?.selfView.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel.isEmpty
            .subscribe(onNext: { [weak self] empty in
                self?.selfView.emptyView.isHidden = !empty
            }).disposed(by: disposeBag)
        
        viewModel.loading
            .withUnretained(self)
            .subscribe(onNext: { owner,loading in
                print("loading\(loading)")
                owner.selfView.loadingView.isHidden = !loading
            }).disposed(by: disposeBag)
    }
    

}
