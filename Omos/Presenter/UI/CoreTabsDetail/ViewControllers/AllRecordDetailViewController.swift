//
//  AllRecordDetailViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/26.
//

import UIKit

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
        self.view.addSubview(loadingView)
        loadingView.frame = view.bounds
    }
    
    func bind() {
        viewModel.selectDetail
            .subscribe(onNext: { [weak self] data in
                guard let record = self?.viewModel.currentSelectDetail else { return }
                if data.category == "A_LINE" {
                    self?.configShortView()
                    self?.setShortData(myRecord: record)
                } else {
                    self?.configLongView()
                    self?.setLongData(myRecord: record)
                }
            }).disposed(by: disposeBag)
        
        
        viewModel.loading
            .subscribe(onNext: { [weak self] loading in
                self?.loadingView.isHidden = !loading
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
        selfLongView.myView.loveCountLabel.text = String(myRecord.likeCnt)
        selfLongView.myView.starCountLabel.text = String(myRecord.scrapCnt)
        selfLongView.myView.cateLabel.text = " | \(myRecord.category )"
        
      
        if myRecord.isLiked {
            selfLongView.myView.loveImageView.image = UIImage(named: "fillLove")
            selfLongView.myView.loveCountLabel.textColor = .mainOrange
        }
        
        if myRecord.isScraped {
            selfLongView.myView.starImageView.image = UIImage(named: "fillStar")
            selfLongView.myView.starCountLabel.textColor = .mainOrange
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
        selfShortView.loveCountLabel.text = String(myRecord.likeCnt)
        selfShortView.starCountLabel.text = String(myRecord.scrapCnt)
        selfShortView.cateLabel.text =  " | \(myRecord.category )"
        
       
        if myRecord.isLiked {
            selfShortView.loveImageView.image = UIImage(named: "fillLove")
            selfShortView.loveCountLabel.textColor = .mainOrange
        }
        
        if myRecord.isScraped {
            selfShortView.starImageView.image = UIImage(named: "fillStar")
            selfShortView.starCountLabel.textColor = .mainOrange
        }
        selfShortView.mainLabelView.text = myRecord.recordContents
    }
}
