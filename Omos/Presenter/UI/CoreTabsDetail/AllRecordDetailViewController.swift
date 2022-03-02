//
//  AllRecordDetailViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/26.
//

import UIKit

class AllRecordDetailViewController:BaseViewController {
    
    let scrollView = UIScrollView()
    private let selfView = AllRecordDetailView()
    let category:String
    
    init(category:String) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItems()
        bind()
    }
    
    private func setNavigationItems() {
        self.navigationItem.rightBarButtonItems?.removeAll()
        let moreButton = UIBarButtonItem(image: UIImage(named: "more"), style: .plain, target: self, action: #selector(didTapMoreButton))
        moreButton.tintColor = .white
        self.navigationItem.rightBarButtonItems = [moreButton]
    }
    
    @objc func didTapMoreButton() {
        
    }
    
    override func configureUI() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(selfView)
        selfView.myView.cateLabel.text = " | \(category)"
        scrollView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        
        selfView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func bind() {
       
    }
    
}
