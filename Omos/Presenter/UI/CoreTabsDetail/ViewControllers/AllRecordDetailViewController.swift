//
//  AllRecordDetailViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/26.
//

import RxCocoa
import RxSwift
import SnapKit
import UIKit

class AllRecordDetailViewController: BaseViewController {
    let scrollView = UIScrollView()
    let selfShortView = MyRecordDetailView()
    let selfLongView = RecordLongView()
    let selfLyricsView = LyricsRecordView()
    let postId: Int
    let viewModel: AllRecordDetailViewModel
    let loadingView = LoadingView()
    var lyricsArr: [String] = []

    init(viewModel: AllRecordDetailViewModel, postId: Int) {
        self.viewModel = viewModel
        self.postId = postId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        selfLyricsView.tableView.delegate = self
        selfLyricsView.tableView.dataSource = self
        viewModel.selectDetailFetch(postId: self.postId, userId: Account.currentUser)
        bind()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
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
                print(data.category)
                if data.category == "A_LINE" {
                    self?.configShortView()
                    self?.setShortData(myRecord: record)
                    self?.selfShortView.layoutIfNeeded()
                    self?.shortBind(myRecord: record)
                } else if data.category == "LYRICS" {
                    self?.selfLyricsView.subTableHeightConstraint?.deactivate()
                    self?.setLyricData(myRecord: record)
                    self?.configLyricsView()
                    self?.selfLyricsView.tableView.reloadData()
                    self?.selfLyricsView.tableView.layoutIfNeeded()
                    self?.selfLyricsView.tableView.isScrollEnabled = false
                    self?.selfLyricsView.tableHeightConstraint!.update(offset: ceil(self?.selfLyricsView.tableView.intrinsicContentSize2.height ?? 100 ) )
                    self?.lyricsBind(myRecord: record)
                } else {
                    self?.setLongData(myRecord: record)
                    self?.configLongView()
                    self?.selfLongView.layoutIfNeeded()
                    self?.longBind(myRecord: record)
                }
            }).disposed(by: disposeBag)

        viewModel.loading
            .subscribe(onNext: { [weak self] loading in
                self?.loadingView.isHidden = !loading
            }).disposed(by: disposeBag)

        viewModel.reportState
            .subscribe(onNext: { [weak self] _ in
                NotificationCenter.default.post(name: NSNotification.Name.reload, object: nil, userInfo: nil)
                self?.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
    }

    func shortBind(myRecord: DetailRecordResponse) {
        selfShortView.reportButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                let action = UIAlertAction(title: "신고하기", style: .default) { _ in
                    self?.viewModel.reportRecord(postId: myRecord.recordID)
                    Account.currentReportRecordsId.append(myRecord.recordID)
                    self?.navigationController?.popViewController(animated: true)
                }
                action.setValue(UIColor.mainOrange, forKey: "titleTextColor")
                self?.presentAlert(title: "", with: action, message: "이 레코드를 신고하시겠어요?", isCancelActionIncluded: true, preferredStyle: .alert)
            }).disposed(by: disposeBag)

        selfShortView.likeButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let count = Int(self?.selfShortView.likeCountLabel.text ?? "0")
                else { return }
                let userId = UserDefaults.standard.integer(forKey: "user")
                let recordId = myRecord.recordID

                if self?.selfShortView.likeCountLabel.textColor == .mainOrange {
                    // 좋아요 취소
                    self?.selfShortView.likeButton.setImage(UIImage(named: "emptyLove"), for: .normal)
                    self?.selfShortView.likeCountLabel.textColor = .mainGrey3
                    self?.selfShortView.likeCountLabel.text = String(count - 1)
                    self?.viewModel.deleteLike(postId: recordId, userId: userId)
                } else {
                    // 좋아요 클릭
                    self?.selfShortView.likeButton.setImage(UIImage(named: "fillLove"), for: .normal)
                    self?.selfShortView.likeCountLabel.textColor = .mainOrange
                    self?.selfShortView.likeCountLabel.text = String(count + 1)
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
                    // 스크랩 취소
                    self?.selfShortView.scrapButton.setImage(UIImage(named: "emptyStar"), for: .normal)
                    self?.selfShortView.scrapCountLabel.textColor = .mainGrey3
                    self?.selfShortView.scrapCountLabel.text = String(scrapCount - 1)
                    self?.viewModel.deleteScrap(postId: recordId, userId: userId)
                } else {
                    // 스크랩 클릭
                    self?.selfShortView.scrapButton.setImage(UIImage(named: "fillStar"), for: .normal)
                    self?.selfShortView.scrapCountLabel.text = String(scrapCount + 1)
                    self?.selfShortView.scrapCountLabel.textColor = .mainOrange
                    self?.viewModel.saveScrap(postId: recordId, userId: userId)
                }
            }).disposed(by: disposeBag)

        selfShortView.nicknameLabel.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                let rp = RecordsRepositoryImpl(recordAPI: RecordAPI())
                let uc = RecordsUseCase(recordsRepository: rp)
                let vm = MyDjProfileViewModel(usecase: uc)
                let vc = MydjProfileViewController(viewModel: vm, toId: myRecord.userID)
                self?.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: disposeBag)
    }

    func longBind(myRecord: DetailRecordResponse) {
        selfLongView.reportButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                let action = UIAlertAction(title: "신고하기", style: .default) { _ in
                    self?.viewModel.reportRecord(postId: myRecord.recordID)
                    Account.currentReportRecordsId.append(myRecord.recordID)
                    self?.navigationController?.popViewController(animated: true)
                }
                action.setValue(UIColor.mainOrange, forKey: "titleTextColor")
                self?.presentAlert(title: "", with: action, message: "이 레코드를 신고하시겠어요?", isCancelActionIncluded: true, preferredStyle: .alert)
            }).disposed(by: disposeBag)

        selfLongView.likeButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let count = Int(self?.selfLongView.likeCountLabel.text ?? "0")
                else { return }
                let userId = UserDefaults.standard.integer(forKey: "user")
                let recordId = myRecord.recordID

                if self?.selfLongView.likeCountLabel.textColor == .mainOrange {
                    // 좋아요 취소
                    self?.selfLongView.likeButton.setImage(UIImage(named: "emptyLove"), for: .normal)
                    self?.selfLongView.likeCountLabel.textColor = .mainGrey3
                    self?.selfLongView.likeCountLabel.text = String(count - 1)
                    self?.viewModel.deleteLike(postId: recordId, userId: userId)
                } else {
                    // 좋아요 클릭
                    self?.selfLongView.likeButton.setImage(UIImage(named: "fillLove"), for: .normal)
                    self?.selfLongView.likeCountLabel.textColor = .mainOrange
                    self?.selfLongView.likeCountLabel.text = String(count + 1)
                    self?.viewModel.saveLike(postId: recordId, userId: userId)
                }
            }).disposed(by: disposeBag)

        selfLongView.scrapButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let scrapCount = Int(self?.selfLongView.scrapCountLabel.text ?? "0")
                else { return }
                let userId = UserDefaults.standard.integer(forKey: "user")
                let recordId = myRecord.recordID
                print("User\(userId)")
                if self?.selfLongView.scrapCountLabel.textColor == .mainOrange {
                    // 좋아요 취소
                    self?.selfLongView.scrapButton.setImage(UIImage(named: "emptyStar"), for: .normal)
                    self?.selfLongView.scrapCountLabel.textColor = .mainGrey3
                    self?.selfLongView.scrapCountLabel.text = String(scrapCount - 1)
                    self?.viewModel.deleteScrap(postId: recordId, userId: userId)
                } else {
                    // 좋아요 클릭
                    self?.selfLongView.scrapButton.setImage(UIImage(named: "fillStar"), for: .normal)
                    self?.selfLongView.scrapCountLabel.textColor = .mainOrange
                    self?.selfLongView.scrapCountLabel.text = String(scrapCount + 1)
                    self?.viewModel.saveScrap(postId: recordId, userId: userId)
                }
            }).disposed(by: disposeBag)

        selfLongView.nicknameLabel.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                let rp = RecordsRepositoryImpl(recordAPI: RecordAPI())
                let uc = RecordsUseCase(recordsRepository: rp)
                let vm = MyDjProfileViewModel(usecase: uc)
                let vc = MydjProfileViewController(viewModel: vm, toId: myRecord.userID)
                self?.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: disposeBag)
    }

    func configLongView() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(selfLongView)
        selfLongView.lockButton.isHidden = true
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

    func setLongData(myRecord: DetailRecordResponse) {
        selfLongView.musicTitleLabel.text = myRecord.music.musicTitle
        selfLongView.subMusicInfoLabel.text = myRecord.music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)" } + "- \(myRecord.music.albumTitle)"
        if selfLongView.subMusicInfoLabel.text?.first == " " {
            selfLongView.subMusicInfoLabel.text?.removeFirst()
        }
        selfLongView.circleImageView.setImage(with: myRecord.music.albumImageURL)
        selfLongView.backImageView.setImage(with: myRecord.recordImageURL ?? "")
        selfLongView.titleLabel.text = myRecord.recordTitle
        selfLongView.createdLabel.text = myRecord.createdDate.toDate()
        selfLongView.likeCountLabel.text = String(myRecord.likeCnt)
        selfLongView.scrapCountLabel.text = String(myRecord.scrapCnt)
        selfLongView.cateLabel.text = " | \(myRecord.category.getReverseCate() )"
        selfLongView.nicknameLabel.text = myRecord.nickname
        selfLongView.lockButton.isHidden = true

        if myRecord.isLiked {
            selfLongView.likeButton.setImage(UIImage(named: "fillLove"), for: .normal)
            selfLongView.likeCountLabel.textColor = .mainOrange
        }

        if myRecord.isScraped {
            selfLongView.scrapButton.setImage(UIImage(named: "fillStar"), for: .normal)
            selfLongView.scrapCountLabel.textColor = .mainOrange
        }
        selfLongView.mainLabelView.text = myRecord.recordContents
        selfLongView.dummyView3.isHidden = true
        selfLongView.readMoreButton.isHidden = true
    }

    func configShortView() {
        self.view.addSubview(selfShortView)
        selfShortView.lockButton.isHidden = true
        selfShortView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
    }

    func setShortData(myRecord: DetailRecordResponse) {
        selfShortView.musicTitleLabel.text = myRecord.music.musicTitle
        selfShortView.subMusicInfoLabel.text = myRecord.music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)" } + "- \(myRecord.music.albumTitle)"
        if  selfShortView.subMusicInfoLabel.text?.first == " " {
            selfShortView.subMusicInfoLabel.text?.removeFirst()
        }
        selfShortView.circleImageView.setImage(with: myRecord.music.albumImageURL)
        selfShortView.backImageView.setImage(with: myRecord.recordImageURL ?? "")
        selfShortView.titleLabel.text = myRecord.recordTitle
        selfShortView.createdLabel.text = myRecord.createdDate.toDate()
        selfShortView.likeCountLabel.text = String(myRecord.likeCnt)
        selfShortView.scrapCountLabel.text = String(myRecord.scrapCnt)
        selfShortView.cateLabel.text = " | \(myRecord.category.getReverseCate() )"
        selfShortView.nicknameLabel.text = myRecord.nickname

        print("is lIked? \(myRecord.isLiked)")
        if myRecord.isLiked {
            selfShortView.likeButton.setImage(UIImage(named: "fillLove"), for: .normal)
            selfShortView.likeCountLabel.textColor = .mainOrange
        }

        if myRecord.isScraped {
            selfShortView.scrapButton.setImage(UIImage(named: "fillStar"), for: .normal)
            selfShortView.scrapCountLabel.textColor = .mainOrange
        }
        selfShortView.mainLabelView.text = myRecord.recordContents
        selfShortView.dummyView3.isHidden = true
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

    func setLyricData(myRecord: DetailRecordResponse) {
        myRecord.recordContents.enumerateSubstrings(in: myRecord.recordContents.startIndex..., options: .byParagraphs) { [weak self] substring, _, _, _ in
            if  let substring = substring,
                !substring.isEmpty {
                self?.lyricsArr.append(substring)
            }
        }
        selfLyricsView.musicTitleLabel.text = myRecord.music.musicTitle
        selfLyricsView.subMusicInfoLabel.text = myRecord.music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)" } + "- \(myRecord.music.albumTitle)"
        if selfLyricsView.subMusicInfoLabel.text?.first == " " {
            selfLyricsView.subMusicInfoLabel.text?.removeFirst()
        }
        selfLyricsView.circleImageView.setImage(with: myRecord.music.albumImageURL)
        selfLyricsView.imageView.setImage(with: myRecord.recordImageURL ?? "")
        selfLyricsView.titleTextView.text = myRecord.recordTitle
        selfLyricsView.createdField.text = myRecord.createdDate.toDate()
        selfLyricsView.likeCountLabel.text = String(myRecord.likeCnt)
        selfLyricsView.scrapCountLabel.text = String(myRecord.scrapCnt)
        selfLyricsView.cateLabel.text = " | \(myRecord.category.getReverseCate() )"
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

    func lyricsBind(myRecord: DetailRecordResponse) {
        selfLyricsView.reportButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                let action = UIAlertAction(title: "신고하기", style: .default) { _ in
                    self?.viewModel.reportRecord(postId: myRecord.recordID)
                    Account.currentReportRecordsId.append(myRecord.recordID)
                    self?.navigationController?.popViewController(animated: true)
                }
                action.setValue(UIColor.mainOrange, forKey: "titleTextColor")
                self?.presentAlert(title: "", with: action, message: "이 레코드를 신고하시겠어요?", isCancelActionIncluded: true, preferredStyle: .alert)
            }).disposed(by: disposeBag)

        selfLyricsView.likeButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let count = Int(self?.selfLyricsView.likeCountLabel.text ?? "0")
                else { return }
                let userId = UserDefaults.standard.integer(forKey: "user")
                let recordId = myRecord.recordID

                if self?.selfLyricsView.likeCountLabel.textColor == .mainOrange {
                    // 좋아요 취소
                    self?.selfLyricsView.likeButton.setImage(UIImage(named: "emptyLove"), for: .normal)
                    self?.selfLyricsView.likeCountLabel.textColor = .mainGrey3
                    self?.selfLyricsView.likeCountLabel.text = String(count - 1)
                    self?.viewModel.deleteLike(postId: recordId, userId: userId)
                } else {
                    // 좋아요 클릭
                    self?.selfLyricsView.likeButton.setImage(UIImage(named: "fillLove"), for: .normal)
                    self?.selfLyricsView.likeCountLabel.textColor = .mainOrange
                    self?.selfLyricsView.likeCountLabel.text = String(count + 1)
                    self?.viewModel.saveLike(postId: recordId, userId: userId)
                }
            }).disposed(by: disposeBag)

        selfLyricsView.scrapButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let scrapCount = Int(self?.selfLyricsView.scrapCountLabel.text ?? "0")
                else { return }
                let userId = UserDefaults.standard.integer(forKey: "user")
                let recordId = myRecord.recordID
                print("User\(userId)")
                if self?.selfLyricsView.scrapCountLabel.textColor == .mainOrange {
                    // 좋아요 취소
                    self?.selfLyricsView.scrapButton.setImage(UIImage(named: "emptyStar"), for: .normal)
                    self?.selfLyricsView.scrapCountLabel.textColor = .mainGrey3
                    self?.selfLyricsView.scrapCountLabel.text = String(scrapCount - 1)
                    self?.viewModel.deleteScrap(postId: recordId, userId: userId)
                } else {
                    // 좋아요 클릭
                    self?.selfLyricsView.scrapButton.setImage(UIImage(named: "fillStar"), for: .normal)
                    self?.selfLyricsView.scrapCountLabel.textColor = .mainOrange
                    self?.selfLyricsView.scrapCountLabel.text = String(scrapCount + 1)
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
