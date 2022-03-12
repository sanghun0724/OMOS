//
//  MyRecordDetailViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/19.
//

import UIKit
import RxSwift
import RxCocoa
import MaterialComponents.MaterialBottomSheet

class MyRecordDetailViewController:BaseViewController {
    
    let scrollView = UIScrollView()
    var selfView = MyRecordDetailView()
    var selflongView = AllRecordDetailView()
    let myRecord:MyRecordRespone
    let bottomVC:BottomSheetViewController
    let bottomSheet:MDCBottomSheetController
    let viewModel:MyRecordDetailViewModel
    let userId = UserDefaults.standard.integer(forKey: "user")
    let cate:String
    
    init(myRecord:MyRecordRespone,viewModel:MyRecordDetailViewModel,cate:String) {
        self.myRecord = myRecord
        self.viewModel = viewModel
        self.bottomVC = BottomSheetViewController(type: .MyRecord, myRecordVM: viewModel, AllRecordVM: nil)
        self.bottomSheet = MDCBottomSheetController(contentViewController: bottomVC)
        self.cate = cate
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
        let InstaButton = UIBarButtonItem(image: UIImage(named: "instagram"), style: .plain, target: self, action: #selector(didTapInstagram))
        InstaButton.tintColor = .white
        let moreButton = UIBarButtonItem(image: UIImage(named: "more"), style: .plain, target: self, action: #selector(didTapMoreButton))
        moreButton.tintColor = .white
        self.navigationItem.rightBarButtonItems = [moreButton,InstaButton]
    }
    
    @objc func didTapInstagram() {
        
    }
    
    @objc func didTapMoreButton() {
        bottomSheet.mdc_bottomSheetPresentationController?.preferredSheetHeight = Constant.mainHeight * 0.194
        self.present(bottomSheet,animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cate == "A_LINE" ? (setShrotData()) : (setLongData())
    }
    
    override func configureUI() {
        cate == "A_LINE" ? (configShort()) : (configLong())
        
    }
    
    
    func configShort() {
        self.view.addSubview(selfView)
        selfView.reportButton.isHidden = true
        selfView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.height.equalToSuperview().multipliedBy(0.7)
        }
    }
    
    func configLong() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(selflongView)
        selflongView.myView.reportButton.isHidden = true
        
        scrollView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        
        selflongView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    
    func bind() {
        //like button and scrap button
        selfViewBind()
        
        viewModel.modify
            .subscribe(onNext: { [weak self] _ in
                let rp = RecordsRepositoryImpl(recordAPI: RecordAPI())
                let uc = RecordsUseCase(recordsRepository: rp)
                let vm = CreateViewModel(usecase: uc)
                vm.modifyDefaultModel = self?.myRecord
                let vc = CreateViewController(viewModel: vm, category: (self?.getReverseCate(cate: self?.myRecord.category ?? ""))!, type: .modify)
                self?.navigationController?.pushViewController( vc, animated: true)
                
            }).disposed(by: disposeBag)
        
        viewModel.delete
            .subscribe(onNext: { [weak self] _ in
                print("delete\(self?.myRecord.recordID ?? 0)")
                self?.viewModel.deleteRecord(postId: self?.myRecord.recordID ?? 0)
            }).disposed(by: disposeBag)
        
        viewModel.done
            .subscribe(onNext: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
        
    }
    
    func selfViewBind() {
        if cate == "A_LINE" {
            selfView.lockButton.rx.tap
                .scan(false) { (lastState, newValue) in
                    !lastState
                }
                .bind(to: selfView.lockButton.rx.isSelected)
                .disposed(by: disposeBag)
            
            selfView.likeButton.rx.tap
                .subscribe(onNext: { [weak self] _ in
                    guard let count = Int(self?.selfView.likeCountLabel.text ?? "0"),
                          let recordId = self?.myRecord.recordID else { return }
                    
                    if self?.selfView.likeCountLabel.textColor == .mainOrange {
                        //좋아요 취소
                        self?.selfView.likeButton.setImage(UIImage(named:"emptyLove"), for: .normal)
                        self?.selfView.likeCountLabel.textColor = .mainGrey3
                        self?.selfView.likeCountLabel.text = String(count-1)
                        self?.viewModel.deleteLike(postId: recordId, userId: self?.userId ?? 0)
                    } else {
                        //좋아요 클릭
                        self?.selfView.likeButton.setImage(UIImage(named:"fillLove"), for: .normal)
                        self?.selfView.likeCountLabel.textColor = .mainOrange
                        self?.selfView.likeCountLabel.text = String(count+1)
                        self?.viewModel.saveLike(postId: recordId, userId: self?.userId ?? 0)
                    }
                }).disposed(by: disposeBag)
            
            selfView.scrapButton.rx.tap
                .subscribe(onNext: { [weak self] _ in
                    guard let scrapCount = Int(self?.selfView.scrapCountLabel.text ?? "10"),
                          let recordId = self?.myRecord.recordID else { return }
                    
                    if self?.selfView.scrapCountLabel.textColor == .mainOrange {
                        //스크랩 취소
                        self?.selfView.scrapButton.setImage(UIImage(named:"emptyStar"), for: .normal)
                        self?.selfView.scrapCountLabel.textColor = .mainGrey3
                        self?.selfView.scrapCountLabel.text = String(scrapCount-1)
                        self?.viewModel.deleteScrap(postId: recordId, userId: self?.userId ?? 0)
                        
                    } else {
                        //스크랩 클릭
                        self?.selfView.scrapButton.setImage(UIImage(named:"fillStar"), for: .normal)
                        self?.selfView.scrapCountLabel.text =  String(scrapCount+1)
                        self?.selfView.scrapCountLabel.textColor = .mainOrange
                        self?.viewModel.saveScrap(postId: recordId, userId: self?.userId ?? 0)
                    }
                    
                }).disposed(by: disposeBag)
            
        } else {
            selflongView.myView.lockButton.rx.tap
                .scan(false) { (lastState, newValue) in
                    !lastState
                }
                .bind(to: selfView.lockButton.rx.isSelected)
                .disposed(by: disposeBag)
            
            selflongView.myView.likeButton.rx.tap
                .subscribe(onNext: { [weak self] _ in
                    guard let count = Int(self?.selflongView.myView.likeCountLabel.text ?? "0"),
                          let recordId = self?.myRecord.recordID else { return }
                    
                    if self?.selflongView.myView.likeCountLabel.textColor == .mainOrange {
                        //좋아요 취소
                        self?.selflongView.myView.likeButton.setImage(UIImage(named:"emptyLove"), for: .normal)
                        self?.selflongView.myView.likeCountLabel.textColor = .mainGrey3
                        self?.selflongView.myView.likeCountLabel.text = String(count-1)
                        self?.viewModel.deleteLike(postId: recordId, userId: self?.userId ?? 0)
                    } else {
                        //좋아요 클릭
                        self?.selflongView.myView.likeButton.setImage(UIImage(named:"fillLove"), for: .normal)
                        self?.selflongView.myView.likeCountLabel.textColor = .mainOrange
                        self?.selflongView.myView.likeCountLabel.text = String(count+1)
                        self?.viewModel.saveLike(postId: recordId, userId: self?.userId ?? 0)
                    }
                }).disposed(by: disposeBag)
            
            selflongView.myView.scrapButton.rx.tap
                .subscribe(onNext: { [weak self] _ in
                    guard let scrapCount = Int(self?.selflongView.myView.scrapCountLabel.text ?? "0"),
                          let recordId = self?.myRecord.recordID else { return }
           
                    if self?.selflongView.myView.scrapCountLabel.textColor == .mainOrange {
                        //좋아요 취소
                        self?.selflongView.myView.scrapButton.setImage(UIImage(named:"emptyStar"), for: .normal)
                        self?.selflongView.myView.scrapCountLabel.textColor = .mainGrey3
                        self?.selflongView.myView.scrapCountLabel.text = String(scrapCount-1)
                        self?.viewModel.deleteScrap(postId: recordId, userId: self?.userId ?? 0)
                    } else {
                        //좋아요 클릭
                        self?.selflongView.myView.scrapButton.setImage(UIImage(named:"fillStar"), for: .normal)
                        self?.selflongView.myView.scrapCountLabel.textColor = .mainOrange
                        self?.selflongView.myView.scrapCountLabel.text = String(scrapCount+1)
                        self?.viewModel.saveScrap(postId: recordId, userId: self?.userId ?? 0)
                    }
                }).disposed(by: disposeBag)
        }
    }
    
    
    
    
    
    func setShrotData() {
        selfView.musicTitleLabel.text = myRecord.music.musicTitle
        selfView.subMusicInfoLabel.text = myRecord.music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)" }
        selfView.circleImageView.setImage(with: myRecord.music.albumImageURL)
        //        selfView.backImageView.setImage(with: <#T##String#>)
        selfView.titleLabel.text = myRecord.recordTitle
        selfView.createdLabel.text = myRecord.createdDate
        selfView.likeCountLabel.text = String(myRecord.likeCnt)
        selfView.scrapCountLabel.text = String(myRecord.scrapCnt)
        selfView.cateLabel.text =  " | \(myRecord.category )"
        
        if myRecord.isPublic {
            selfView.lockButton.setImage(UIImage(named: "unlock"), for: .normal)
            selfView.lockButton.setImage(UIImage(named: "lock"), for: .selected)
        } else {
            selfView.lockButton.setImage(UIImage(named: "lock"), for: .normal)
            selfView.lockButton.setImage(UIImage(named: "unlock"), for: .selected)
        }
        if myRecord.isLiked {
            selfView.likeButton.setImage(UIImage(named: "fillLove"), for: .normal)
            selfView.likeCountLabel.textColor = .mainOrange
        }
        
        if myRecord.isScraped {
            selfView.scrapButton.setImage(UIImage(named: "fillStar"), for: .normal)
            selfView.scrapCountLabel.textColor = .mainOrange
        }
        selfView.mainLabelView.text = myRecord.recordContents
        
    }
    
    func setLongData() {
        selflongView.myView.musicTitleLabel.text = myRecord.music.musicTitle
        selflongView.myView.subMusicInfoLabel.text = myRecord.music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)" }
        selflongView.myView.circleImageView.setImage(with: myRecord.music.albumImageURL)
        //        selfView.backImageView.setImage(with: <#T##String#>)
        selflongView.myView.titleLabel.text = myRecord.recordTitle
        selflongView.myView.createdLabel.text = myRecord.createdDate
        selflongView.myView.likeCountLabel.text = String(myRecord.likeCnt)
        selflongView.myView.scrapCountLabel.text = String(myRecord.scrapCnt)
        selflongView.myView.cateLabel.text = " | \(myRecord.category )"
        
        if myRecord.isPublic {
            selflongView.myView.lockButton.setImage(UIImage(named: "unlock"), for: .normal)
            selflongView.myView.lockButton.setImage(UIImage(named: "lock"), for: .selected)
        } else {
            selflongView.myView.lockButton.setImage(UIImage(named: "lock"), for: .normal)
            selflongView.myView.lockButton.setImage(UIImage(named: "unlock"), for: .selected)
        }
        if myRecord.isLiked {
            selflongView.myView.likeButton.setImage(UIImage(named: "fillLove"), for: .normal)
            selflongView.myView.likeCountLabel.textColor = .mainOrange
        }
        
        if myRecord.isScraped {
            selflongView.myView.scrapButton.setImage(UIImage(named: "fillStar"), for: .normal)
            selflongView.myView.scrapCountLabel.textColor = .mainOrange
        }
        selflongView.myView.mainLabelView.text = myRecord.recordContents
    }
    
    private func getReverseCate(cate:String) -> String {
        switch cate {
        case "A_LINE":
            return "한 줄 감상"
        case "STORY":
            return "노래 속 나의 이야기"
        case "OST":
            return "내 인생의 OST"
        case "LYRICS":
            return "나만의 가사해석"
        case "FREE":
            return "자유 공간"
        default:
            return "자유 공간"
        }
    }
    
}
