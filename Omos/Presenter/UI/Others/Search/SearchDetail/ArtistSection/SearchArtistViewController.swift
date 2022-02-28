//
//  SearchArtistViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/28.
//

import UIKit

class SearchArtistViewController:BaseViewController {
    
    let topView = SearchArtistHeaderView()
    let bottomViewController = SearchArtistTopTabViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func configureUI() {
        super.configureUI()
        self.view.addSubview(topView)
        self.addChild(bottomViewController)
        
        topView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.166)
        }
        
        addContentsView()
        
    }
    
    
    private func addContentsView() {
        
        addChild(bottomViewController)
        self.view.addSubview(bottomViewController.view)
        
        bottomViewController.view.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        bottomViewController.didMove(toParent: self)
    }
}


