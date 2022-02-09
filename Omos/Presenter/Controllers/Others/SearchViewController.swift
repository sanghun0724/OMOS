//
//  searchViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/06.
//

import UIKit
import RxSwift

class SearchViewController:BaseViewController {
    
    let viewModel:SearchViewModel
    let selfView = SearchListView()
    
    init(viewModel:SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.enableScrollWhenKeyboardAppeared(scrollView: selfView.tableView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeListeners()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("search")
        bind()
    }
    
    override func configureUI() {
        view.addSubview(selfView)
        
        selfView.tableView.delegate = self
        selfView.tableView.dataSource = self
        
        selfView.searchViewController.delegate = self
        selfView.searchViewController.searchResultsUpdater = self
        
        navigationItem.searchController = selfView.searchViewController
        selfView.frame = view.bounds
    }
    
    func bind() {
        
        selfView.searchViewController.searchBar.rx.text
            .debounce(.milliseconds(300),scheduler:MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { owner,text in
                guard let text = text else {
                    return
                }
                print(text)
                owner.viewModel.searchQeuryChanged(query: text)
            }).disposed(by: disposeBag)
        
    }
    
}



extension SearchViewController:UISearchControllerDelegate {
    
}
extension SearchViewController:UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
