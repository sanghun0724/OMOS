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
    var selfLyricsView = LyricsRecordView()
    let instaDecoView = InstaDecoTopView()
    let loadingView = LoadingView()
    let bottomVC:BottomSheetViewController
    let bottomSheet:MDCBottomSheetController
    let viewModel:MyRecordDetailViewModel
    let userId = UserDefaults.standard.integer(forKey: "user")
    let postId:Int
    var lyricsArr:[String] = []
    var category = ""
    
    init(posetId:Int,viewModel:MyRecordDetailViewModel) {
        self.postId = posetId
        self.viewModel = viewModel
        self.bottomVC = BottomSheetViewController(type: .MyRecord, myRecordVM: viewModel, allRecordVM: nil, searchTrackVM: nil)
        self.bottomSheet = MDCBottomSheetController(contentViewController: bottomVC)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selfLyricsView.tableView.delegate = self
        selfLyricsView.tableView.dataSource = self
        setNavigationItems()
        viewModel.myRecordDetailFetch(postId: postId, userId: userId)
        bind()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        selfView.nicknameLabel.isHidden = true
        selflongView.myView.nicknameLabel.isHidden = true
        selfLyricsView.nicknameLabel.isHidden = true
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
        if category == "" { return }
        showDecoView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25 ) {
            if let storyShareURL = URL(string: "instagram-stories://share") {
                if UIApplication.shared.canOpenURL(storyShareURL) {
                    let renderer = UIGraphicsImageRenderer(size: self.view.bounds.size)
                    let renderImage = renderer.image { _ in
                        
                        self.view.drawHierarchy(in: self.view.bounds, afterScreenUpdates: true)
                    }
                    
                    guard let imageData = renderImage.pngData() else { return }
                    
                    let pasteboardItems : [String:Any] = [
                        "com.instagram.sharedSticker.backgroundImage": imageData,
                    ]
                    let pasteboardOptions = [
                        UIPasteboard.OptionsKey.expirationDate : Date().addingTimeInterval(300)
                    ]
                    
                    UIPasteboard.general.setItems([pasteboardItems], options: pasteboardOptions)
                    
                    UIApplication.shared.open(storyShareURL, options: [:], completionHandler: { [weak self] _ in
                        self?.hideDecoView()
                    })
                } else {
                    let alert = UIAlertController(title: "알림", message: "인스타그램이 필요합니다", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    private func hideDecoView() {
        if category == "A_LINE" {
            selfView.snp.remakeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            }
            self.view.layoutIfNeeded()
        } else {
            scrollView.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.width.equalToSuperview()
                make.bottom.equalToSuperview()
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    private func showDecoView() {
        if category == "A_LINE" {
            selfView.snp.remakeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(instaDecoView.snp.bottom)
            }
            self.view.layoutIfNeeded()
        } else {
            scrollView.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.width.equalToSuperview()
                make.bottom.equalToSuperview()
                make.top.equalTo(instaDecoView.snp.bottom)
            }
            self.view.layoutIfNeeded()
        }
        
    }
    
    @objc func didTapMoreButton() {
        bottomSheet.mdc_bottomSheetPresentationController?.preferredSheetHeight = Constant.mainHeight * 0.194
        self.present(bottomSheet,animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func configureUI() {
        self.view.addSubview(loadingView)
        loadingView.frame = view.bounds
        
        self.view.addSubview(instaDecoView)
        self.view.sendSubviewToBack(instaDecoView)
        instaDecoView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Constant.mainHeight * 0.1)
        }
    }
    
    
    func configShort() {
        self.view.addSubview(selfView)
        selfView.reportButton.isHidden = true
        selfView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
    }
    
    func configLong() {
        self.view.addSubview(scrollView)
        selflongView.myView.heightConst?.deactivate()
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
        
        viewModel.loading
            .subscribe(onNext: { [weak self] loading in
                self?.loadingView.isHidden = !loading
            }).disposed(by: disposeBag)
        
        viewModel.myRocordDetail
            .subscribe(onNext: { [weak self] data in
                self?.navigationController?.navigationBar.isHidden = false
                guard let record = self?.viewModel.currentMyRecordDetail else { return }
                self?.category = record.category
                if record.category == "A_LINE"  {
                    self?.configShort()
                    self?.setShrotData(myRecord: record)
                } else if record.category == "LYRICS" {
                    self?.setLyricData(myRecord: record)
                    self?.configLyricsView()
                    self?.selfLyricsView.tableView.reloadData()
                    self?.selfLyricsView.tableView.layoutIfNeeded()
                    self?.selfLyricsView.subTableHeightConstraint?.deactivate()
                    self?.selfLyricsView.tableView.isScrollEnabled = false
                    self?.selfLyricsView.tableHeightConstraint!.update(offset: ceil(self?.selfLyricsView.tableView.intrinsicContentSize2.height ?? 100 ) )
                    self?.lyricsBind(myRecord: record)
                } else {
                    self?.configLong()
                    self?.setLongData(myRecord: record )
                }
            }).disposed(by: disposeBag)
        
        // like and scrap
        selfViewBind()
        
        viewModel.modify
            .subscribe(onNext: { [weak self] _ in
                let rp = RecordsRepositoryImpl(recordAPI: RecordAPI())
                let uc = RecordsUseCase(recordsRepository: rp)
                if self?.viewModel.currentMyRecordDetail?.category  == "LYRICS" {
                    guard let contents = self?.viewModel.currentMyRecordDetail?.recordContents else { return }
                    let vm = LyricsViewModel(usecase: uc)
                    var lyricsArr:[String] = []
                    contents.enumerateSubstrings(in: contents.startIndex..., options: .byParagraphs) { substring, range, _, stop in
                        if  let substring = substring,
                            !substring.isEmpty {
                            lyricsArr.append(substring)
                        }
                    }
                    vm.lyricsStringArray = lyricsArr
                    vm.modifyDefaultModel = self?.viewModel.currentMyRecordDetail
                    let vc = LyricsPasteCreateViewController(viewModel: vm, type: .modify)
                    self?.navigationController?.pushViewController( vc, animated: true)
                } else {
                    let vm = CreateViewModel(usecase: uc)
                    vm.modifyDefaultModel = self?.viewModel.currentMyRecordDetail
                    let vc = CreateViewController(viewModel: vm, category: (self?.viewModel.currentMyRecordDetail?.category ?? "").getReverseCate(), type: .modify)
                    self?.navigationController?.pushViewController( vc, animated: true)
                }
                
                
            }).disposed(by: disposeBag)
        
        viewModel.delete
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.deleteRecord(postId: self?.postId ?? 0)
            }).disposed(by: disposeBag)
        
        viewModel.done
            .subscribe(onNext: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
        
    }
    
    func selfViewBind() {
        if self.viewModel.currentMyRecordDetail?.category  == "A_LINE" {
            selfView.lockButton.rx.tap
                .scan(false) { (lastState, newValue) in
                    !lastState
                }
                .bind(to: selfView.lockButton.rx.isSelected)
                .disposed(by: disposeBag)
            
            selfView.likeButton.rx.tap
                .subscribe(onNext: { [weak self] _ in
                    guard let count = Int(self?.selfView.likeCountLabel.text ?? "0"),
                          let recordId = self?.postId else { return }
                    
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
                          let recordId = self?.postId else { return }
                    
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
            
            selfView.nicknameLabel.rx.tapGesture()
                .when(.recognized)
                .subscribe(onNext: { [weak self] _ in
                    let rp = RecordsRepositoryImpl(recordAPI: RecordAPI())
                    let uc = RecordsUseCase(recordsRepository: rp)
                    let vm = MyDjProfileViewModel(usecase: uc)
                    let vc = MydjProfileViewController(viewModel: vm, toId: self?.userId ?? 0)
                    self?.navigationController?.pushViewController(vc, animated: true)
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
                          let recordId = self?.postId else { return }
                    
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
                          let recordId = self?.postId else { return }
                    
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
            
            selflongView.myView.nicknameLabel.rx.tapGesture()
                .when(.recognized)
                .subscribe(onNext: { [weak self] _ in
                    let rp = RecordsRepositoryImpl(recordAPI: RecordAPI())
                    let uc = RecordsUseCase(recordsRepository: rp)
                    let vm = MyDjProfileViewModel(usecase: uc)
                    let vc = MydjProfileViewController(viewModel: vm, toId: self?.userId ?? 0)
                    self?.navigationController?.pushViewController(vc, animated: true)
                }).disposed(by: disposeBag)
        }
    }
    
    
    
    
    
    func setShrotData(myRecord:DetailRecordResponse) {
        selfView.musicTitleLabel.text = myRecord.music.musicTitle
        selfView.subMusicInfoLabel.text = myRecord.music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)" }
        selfView.circleImageView.setImage(with: myRecord.music.albumImageURL)
        //        selfView.backImageView.setImage(with: <#T##String#>)
        selfView.titleLabel.text = myRecord.recordTitle
        selfView.createdLabel.text = myRecord.createdDate.toDate()
        selfView.likeCountLabel.text = String(myRecord.likeCnt)
        selfView.scrapCountLabel.text = String(myRecord.scrapCnt)
        selfView.cateLabel.text =  " | \(myRecord.category.getReverseCate() )"
        selfView.nicknameLabel.text = myRecord.nickname
        
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
        selfView.dummyView3.isHidden = true
    }
    
    func setLongData(myRecord:DetailRecordResponse) {
        selflongView.myView.musicTitleLabel.text = myRecord.music.musicTitle
        selflongView.myView.subMusicInfoLabel.text = myRecord.music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)" }
        selflongView.myView.circleImageView.setImage(with: myRecord.music.albumImageURL)
        //        selfView.backImageView.setImage(with: <#T##String#>)
        selflongView.myView.titleLabel.text = myRecord.recordTitle
        selflongView.myView.createdLabel.text = myRecord.createdDate.toDate()
        selflongView.myView.likeCountLabel.text = String(myRecord.likeCnt)
        selflongView.myView.scrapCountLabel.text = String(myRecord.scrapCnt)
        selflongView.myView.cateLabel.text = " | \(myRecord.category.getReverseCate() )"
        selflongView.myView.nicknameLabel.text = myRecord.nickname
        
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
        selflongView.myView.dummyView3.isHidden = true
    }
    
    func configLyricsView() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(selfLyricsView)
        selfLyricsView.lockButton.isHidden = true
        scrollView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        
        selfLyricsView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setLyricData(myRecord:DetailRecordResponse) {
        myRecord.recordContents.enumerateSubstrings(in: myRecord.recordContents.startIndex..., options: .byParagraphs) { [weak self] substring, range, _, stop in
            if  let substring = substring,
                !substring.isEmpty {
                self?.lyricsArr.append(substring)
            }
        }
        
        selfLyricsView.musicTitleLabel.text = myRecord.music.musicTitle
        selfLyricsView.subMusicInfoLabel.text = myRecord.music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)" }
        selfLyricsView.circleImageView.setImage(with: myRecord.music.albumImageURL)
        //        selfView.backImageView.setImage(with: <#T##String#>)
        selfLyricsView.titleTextView.text = myRecord.recordTitle
        selfLyricsView.createdField.text = myRecord.createdDate.toDate()
        selfLyricsView.likeCountLabel.text = String(myRecord.likeCnt)
        selfLyricsView.scrapCountLabel.text = String(myRecord.scrapCnt)
        selfLyricsView.cateLabel.text =  " | \(myRecord.category.getReverseCate() )"
        selfLyricsView.nicknameLabel.text = myRecord.nickname
        selfLyricsView.dummyView3.isHidden = true
        
        if myRecord.isLiked {
            selfLyricsView.likeButton.setImage(UIImage(named: "fillLove"), for: .normal)
            selfLyricsView.likeCountLabel.textColor = .mainOrange
        }
        
        if myRecord.isScraped {
            selfLyricsView.scrapButton.setImage(UIImage(named: "fillStar"), for: .normal)
            selfLyricsView.scrapCountLabel.textColor = .mainOrange
        }
        
    }
    
    func lyricsBind(myRecord:DetailRecordResponse) {
        selfLyricsView.reportButton.rx.tap
            .asDriver()
            .drive(onNext:{ [weak self] _ in
                let action = UIAlertAction(title: "신고하기", style: .default) { alert in
                    print(alert)
                }
                action.setValue(UIColor.mainOrange, forKey: "titleTextColor")
                self?.presentAlert(title: "", message: "이 레코드를 신고하시겠어요?", isCancelActionIncluded: true, preferredStyle: .alert, with: action)
            }).disposed(by: disposeBag)
        
        selfLyricsView.likeButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let count = Int(self?.selfLyricsView.likeCountLabel.text ?? "0")
                else { return }
                let userId = UserDefaults.standard.integer(forKey: "user")
                let recordId = myRecord.recordID
                
                if self?.selfLyricsView.likeCountLabel.textColor == .mainOrange {
                    //좋아요 취소
                    self?.selfLyricsView.likeButton.setImage(UIImage(named:"emptyLove"), for: .normal)
                    self?.selfLyricsView.likeCountLabel.textColor = .mainGrey3
                    self?.selfLyricsView.likeCountLabel.text = String(count-1)
                    self?.viewModel.deleteLike(postId: recordId, userId: userId)
                } else {
                    //좋아요 클릭
                    self?.selfLyricsView.likeButton.setImage(UIImage(named:"fillLove"), for: .normal)
                    self?.selfLyricsView.likeCountLabel.textColor = .mainOrange
                    self?.selfLyricsView.likeCountLabel.text = String(count+1)
                    self?.viewModel.saveLike(postId: recordId, userId: userId)
                }
            }).disposed(by: disposeBag)
        
        selfLyricsView.scrapButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let scrapCount = Int(self?.selfLyricsView.scrapCountLabel.text ?? "0")
                else { return }
                let userId = UserDefaults.standard.integer(forKey: "user")
                let recordId = myRecord.recordID
                if self?.selfLyricsView.scrapCountLabel.textColor == .mainOrange {
                    //좋아요 취소
                    self?.selfLyricsView.scrapButton.setImage(UIImage(named:"emptyStar"), for: .normal)
                    self?.selfLyricsView.scrapCountLabel.textColor = .mainGrey3
                    self?.selfLyricsView.scrapCountLabel.text = String(scrapCount-1)
                    self?.viewModel.deleteScrap(postId: recordId, userId: userId)
                } else {
                    //좋아요 클릭
                    self?.selfLyricsView.scrapButton.setImage(UIImage(named:"fillStar"), for: .normal)
                    self?.selfLyricsView.scrapCountLabel.textColor = .mainOrange
                    self?.selfLyricsView.scrapCountLabel.text = String(scrapCount+1)
                    self?.viewModel.saveScrap(postId: recordId, userId: userId)
                }
            }).disposed(by: disposeBag)
        
        selfLyricsView.nicknameLabel.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                let rp = RecordsRepositoryImpl(recordAPI: RecordAPI())
                let uc = RecordsUseCase(recordsRepository: rp)
                let vm = MyDjProfileViewModel(usecase: uc)
                let vc = MydjProfileViewController(viewModel: vm, toId: myRecord.userID)
                self?.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: disposeBag)
    }
    
    
    
}


class InstaDecoTopView:BaseView {
    
    let logoImageView:UIImageView = {
        let view = UIImageView(image: UIImage(named: "logo"))
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .mainBackGround
        self.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.width.equalToSuperview().multipliedBy(0.230)
            make.height.equalTo(logoImageView.snp.width).multipliedBy(0.208)
        }
        
    }
}





