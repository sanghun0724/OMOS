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
        viewModel.myRecordFetch(userid: UserDefaults.standard.integer(forKey: "user"))
        setRightItems()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    func setRightItems() {
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(didTapSearchButton))
        searchButton.tintColor = .white
        let createButton = UIBarButtonItem(image: UIImage(named: "plus-square"), style: .plain, target: self, action: #selector(didTapCreateButton))
        createButton.tintColor = .white
        self.navigationItem.rightBarButtonItems = [searchButton,createButton]
    }
    
    @objc func didTapCreateButton() {
        let vc = SearchViewController(viewModel: SearchViewModel(usecase: SearchUseCase(searchRepository: SearchRepositoryImpl(searchAPI: SearchAPI()))), searchType: .me)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapSearchButton() {
        print("search")
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
