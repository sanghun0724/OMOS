//
//  MyRecordDetailViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/19.
//

import UIKit

class MyRecordDetailViewController:BaseViewController {
    
    private let selfView = MyRecordDetailView()
    let myRecord:String
    
    init(myRecord:String) {
        self.myRecord = myRecord
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItems()
    }
    
    private func setNavigationItems() {
        self.navigationItem.rightBarButtonItems?.removeAll()
        let InstaButton = UIBarButtonItem(image: UIImage(named: "instagram"), style: .plain, target: self, action: #selector(didTapInstagram))
        InstaButton.tintColor = .white
        let moreButton = UIBarButtonItem(image: UIImage(named: "more"), style: .plain, target: self, action: #selector(didTapMoreButton))
        moreButton.tintColor = .white
        self.navigationItem.rightBarButtonItems = [moreButton,InstaButton]
    }
    
    @objc func didTapInstagram() {
        
    }
    
    @objc func didTapMoreButton() {
        
    }
    
    override func configureUI() {
        self.view.addSubview(selfView)
        
        selfView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.height.equalToSuperview().multipliedBy(0.7)
        }
    }
}
