//
//  AllRecordDetailViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/26.
//

import UIKit
import RxSwift
import RxCocoa

class AllRecordDetailViewController:BaseViewController {
    
    let scrollView = UIScrollView()
    let selfShortView = MyRecordDetailView()
    let selfLongView = AllRecordDetailView()
    let postId:Int
    let userId:Int
    let viewModel:AllRecordDetailViewModel
    let loadingView = LoadingView()
    
    init(viewModel:AllRecordDetailViewModel,postId:Int,userId:Int) {
        self.viewModel = viewModel
        self.postId = postId
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.selectDetailFetch(postId: self.postId, userId: self.userId)
       // setNavigationItems()
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
        self.view.addSubview(loadingView)
        loadingView.frame = view.bounds
    }
    
    func bind() {
        viewModel.selectDetail
            .take(1)
            .subscribe(onNext: { [weak self] data in
                guard let record = self?.viewModel.currentSelectDetail else { return }
                if data.category == "A_LINE" {
                    self?.configShortView()
                    self?.setShortData(myRecord: record)
                    self?.selfShortView.layoutIfNeeded()
                    self?.shortBind(myRecord: record)
                } else {
                    self?.configLongView()
                    self?.setLongData(myRecord: record)
                    self?.selfLongView.layoutIfNeeded()
                    self?.longBind(myRecord: record)
                }
            }).disposed(by: disposeBag)
        
        
        viewModel.loading
            .subscribe(onNext: { [weak self] loading in
                self?.loadingView.isHidden = !loading
            }).disposed(by: disposeBag)
    }
    
    func shortBind(myRecord:SelectDetailRespone) {
        selfShortView.reportButton.rx.tap
            .asDriver()
            .drive(onNext:{ [weak self] _ in
                let action = UIAlertAction(title: "신고", style: .default) { alert in
                    print(alert)
                }
                action.setValue(UIColor.mainOrange, forKey: "titleTextColor")
                self?.presentAlert(title: "신고하기", message: "이 레코드를 신고하시겠어요?", isCancelActionIncluded: true, preferredStyle: .alert, with: action)
            }).disposed(by: disposeBag)
        
        
        selfShortView.likeButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let count = Int(self?.selfShortView.likeCountLabel.text ?? "0")
                else { return }
                let userId = UserDefaults.standard.integer(forKey: "user")
                let recordId = myRecord.recordID
                
                if self?.selfShortView.likeCountLabel.textColor == .mainOrange {
                    //좋아요 취소
                    self?.selfShortView.likeButton.setImage(UIImage(named:"emptyLove"), for: .normal)
                    self?.selfShortView.likeCountLabel.textColor = .mainGrey3
                    self?.selfShortView.likeCountLabel.text = String(count-1)
                    self?.viewModel.deleteLike(postId: recordId, userId: userId)
                } else {
                    //좋아요 클릭
                    self?.selfShortView.likeButton.setImage(UIImage(named:"fillLove"), for: .normal)
                    self?.selfShortView.likeCountLabel.textColor = .mainOrange
                    self?.selfShortView.likeCountLabel.text = String(count+1)
                    self?.viewModel.saveLike(postId: recordId, userId: userId)
                }
            }).disposed(by: disposeBag)
        
        selfShortView.scrapButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let scrapCount = Int(self?.selfShortView.scrapCountLabel.text ?? "10")
                else { return }
                let userId = UserDefaults.standard.integer(forKey: "user")
                let recordId = myRecord.recordID
                
                if self?.selfShortView.scrapCountLabel.textColor == .mainOrange {
                    //스크랩 취소
                    self?.selfShortView.scrapButton.setImage(UIImage(named:"emptyStar"), for: .normal)
                    self?.selfShortView.scrapCountLabel.textColor = .mainGrey3
                    self?.selfShortView.scrapCountLabel.text = String(scrapCount-1)
                    self?.viewModel.deleteScrap(postId: recordId, userId: userId)
                    
                } else {
                    //스크랩 클릭
                    self?.selfShortView.scrapButton.setImage(UIImage(named:"fillStar"), for: .normal)
                    self?.selfShortView.scrapCountLabel.text =  String(scrapCount+1)
                    self?.selfShortView.scrapCountLabel.textColor = .mainOrange
                    self?.viewModel.saveScrap(postId: recordId, userId: userId)
                }
                
            }).disposed(by: disposeBag)
        
        
    }
    
    
    func longBind(myRecord:SelectDetailRespone) {
        
        selfLongView.myView.reportButton.rx.tap
            .asDriver()
            .drive(onNext:{ [weak self] _ in
                let action = UIAlertAction(title: "신고", style: .default) { alert in
                    print(alert)
                }
                action.setValue(UIColor.mainOrange, forKey: "titleTextColor")
                self?.presentAlert(title: "신고하기", message: "이 레코드를 신고하시겠어요?", isCancelActionIncluded: true, preferredStyle: .alert, with: action)
            }).disposed(by: disposeBag)
        
        selfLongView.myView.likeButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let count = Int(self?.selfLongView.myView.likeCountLabel.text ?? "0")
                else { return }
                let userId = UserDefaults.standard.integer(forKey: "user")
                let recordId = myRecord.recordID
                
                if self?.selfLongView.myView.likeCountLabel.textColor == .mainOrange {
                    //좋아요 취소
                    self?.selfLongView.myView.likeButton.setImage(UIImage(named:"emptyLove"), for: .normal)
                    self?.selfLongView.myView.likeCountLabel.textColor = .mainGrey3
                    self?.selfLongView.myView.likeCountLabel.text = String(count-1)
                    self?.viewModel.deleteLike(postId: recordId, userId: userId)
                } else {
                    //좋아요 클릭
                    self?.selfLongView.myView.likeButton.setImage(UIImage(named:"fillLove"), for: .normal)
                    self?.selfLongView.myView.likeCountLabel.textColor = .mainOrange
                    self?.selfLongView.myView.likeCountLabel.text = String(count+1)
                    self?.viewModel.saveLike(postId: recordId, userId: userId)
                }
            }).disposed(by: disposeBag)
        
        selfLongView.myView.scrapButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let scrapCount = Int(self?.selfLongView.myView.scrapCountLabel.text ?? "0")
                else { return }
                let userId = UserDefaults.standard.integer(forKey: "user")
                let recordId = myRecord.recordID
                print("User\(userId)")
                if self?.selfLongView.myView.scrapCountLabel.textColor == .mainOrange {
                    //좋아요 취소
                    self?.selfLongView.myView.scrapButton.setImage(UIImage(named:"emptyStar"), for: .normal)
                    self?.selfLongView.myView.scrapCountLabel.textColor = .mainGrey3
                    self?.selfLongView.myView.scrapCountLabel.text = String(scrapCount-1)
                    self?.viewModel.deleteScrap(postId: recordId, userId: userId)
                } else {
                    //좋아요 클릭
                    self?.selfLongView.myView.scrapButton.setImage(UIImage(named:"fillStar"), for: .normal)
                    self?.selfLongView.myView.scrapCountLabel.textColor = .mainOrange
                    self?.selfLongView.myView.scrapCountLabel.text = String(scrapCount+1)
                    self?.viewModel.saveScrap(postId: recordId, userId: userId)
                }
            }).disposed(by: disposeBag)
    }
    
    
    func configLongView() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(selfLongView)
        selfLongView.myView.lockButton.isHidden = true
        scrollView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        
        selfLongView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setLongData(myRecord:SelectDetailRespone) {
        selfLongView.myView.musicTitleLabel.text = myRecord.music.musicTitle
        selfLongView.myView.subMusicInfoLabel.text = myRecord.music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)" }
        selfLongView.myView.circleImageView.setImage(with: myRecord.music.albumImageURL)
        //        selfView.backImageView.setImage(with: <#T##String#>)
        selfLongView.myView.titleLabel.text = myRecord.recordTitle
        selfLongView.myView.createdLabel.text = myRecord.createdDate
        selfLongView.myView.likeCountLabel.text = String(myRecord.likeCnt)
        selfLongView.myView.scrapCountLabel.text = String(myRecord.scrapCnt)
        selfLongView.myView.cateLabel.text = " | \(myRecord.category )"
        
        
        print(myRecord.recordID)
        
        if myRecord.isLiked {
            selfLongView.myView.likeButton.setImage(UIImage(named: "fillLove"), for: .normal)
            selfLongView.myView.likeCountLabel.textColor = .mainOrange
        }
        
        if myRecord.isScraped {
            selfLongView.myView.scrapButton.setImage(UIImage(named: "fillStar"), for: .normal)
            selfLongView.myView.scrapCountLabel.textColor = .mainOrange
        }
        selfLongView.myView.mainLabelView.text = myRecord.recordContents
    }
    
    func configShortView() {
        self.view.addSubview(selfShortView)
        selfShortView.lockButton.isHidden = true
        selfShortView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.height.equalToSuperview().multipliedBy(0.7)
        }
    }
    
    func setShortData(myRecord:SelectDetailRespone) {
        selfShortView.musicTitleLabel.text = myRecord.music.musicTitle
        selfShortView.subMusicInfoLabel.text = myRecord.music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)" }
        selfShortView.circleImageView.setImage(with: myRecord.music.albumImageURL)
        //        selfView.backImageView.setImage(with: <#T##String#>)
        selfShortView.titleLabel.text = myRecord.recordTitle
        selfShortView.createdLabel.text = myRecord.createdDate
        selfShortView.likeCountLabel.text = String(myRecord.likeCnt)
        selfShortView.scrapCountLabel.text = String(myRecord.scrapCnt)
        selfShortView.cateLabel.text =  " | \(myRecord.category )"
        
        
        if myRecord.isLiked {
            selfShortView.likeButton.setImage(UIImage(named: "fillLove"), for: .normal)
            selfShortView.likeCountLabel.textColor = .mainOrange
        }
        
        if myRecord.isScraped {
            selfShortView.scrapButton.setImage(UIImage(named: "fillStar"), for: .normal)
            selfShortView.scrapCountLabel.textColor = .mainOrange
        }
        selfShortView.mainLabelView.text = myRecord.recordContents
    }
    
    
    
    
    
}
