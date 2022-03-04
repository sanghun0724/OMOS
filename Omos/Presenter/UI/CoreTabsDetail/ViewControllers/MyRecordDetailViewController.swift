//
//  MyRecordDetailViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/19.
//

import UIKit
import RxSwift
import RxCocoa

class MyRecordDetailViewController:BaseViewController {
    
    private let selfView = MyRecordDetailView()
    let myRecord:MyRecordRespone
    
    init(myRecord:MyRecordRespone) {
        self.myRecord = myRecord
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItems()
        bind()
        setData()
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
    
    func bind() {
        selfView.reportButton.rx.tap
            .asDriver()
            .drive(onNext:{ [weak self] _ in
                let action = UIAlertAction(title: "신고", style: .default) { alert in
                    print(alert)
                }
                action.setValue(UIColor.mainOrange, forKey: "titleTextColor")
                self?.presentAlert(title: "신고하기", message: "이 레코드를 신고하시겠어요?", isCancelActionIncluded: true, preferredStyle: .alert, with: action)
            }).disposed(by: disposeBag)
        
    }
    
    func setData() {
        selfView.musicTitleLabel.text = myRecord.music.musicTitle
        selfView.subMusicInfoLabel.text = myRecord.music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)" }
        selfView.circleImageView.setImage(with: myRecord.music.albumImageURL)
//        selfView.backImageView.setImage(with: <#T##String#>)
        selfView.titleLabel.text = myRecord.recordTitle
        selfView.createdLabel.text = myRecord.createdDate
        
        selfView.mainLabelView.text = myRecord.recordContents
        
    }
    
}
