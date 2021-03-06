//
//  AllRecordCateDetailViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/28.
//

import MaterialComponents.MaterialBottomSheet
import RxCocoa
import RxSwift
import UIKit

class AllRecordCateDetailViewController: BaseViewController, UIScrollViewDelegate {
    let selfView = AllRecordCateDetailView()
    var expandedIndexSet: IndexSet = []
    var expandedIndexSet2: IndexSet = []
    let bottomVC: BottomSheetViewController
    let bottomSheet: MDCBottomSheetController
    var isPaging = false
    var hasNextPage = true
    var currentPage = -1
    var shortCellHeights: [IndexPath: CGFloat] = [:]
    var longCellHeights: [IndexPath: CGFloat] = [:]
    var filterType = "date"
    var tableViewReload = true
    var lastPostId = 0
    let viewModel: AllRecordCateDetailViewModel
    let myCateType: CateType

    init(viewModel: AllRecordCateDetailViewModel, cateType: CateType) {
        self.viewModel = viewModel
        self.myCateType = cateType
        self.bottomVC = BottomSheetViewController(type: .allcateRecord, myRecordVM: nil, allRecordVM: viewModel, searchTrackVM: nil)
        self.bottomSheet = MDCBottomSheetController(contentViewController: bottomVC)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .mainBackGround
        selfView.tableView.delegate = self
        selfView.tableView.dataSource = self
        let filterButton = UIBarButtonItem(image: UIImage(named: "filter"), style: .plain, target: self, action: #selector(didTapfilterButton))
        filterButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = filterButton
        bottomSheet.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveReloadNotification), name: NSNotification.Name.reload, object: nil)
    }

    @objc
    private func didRecieveReloadNotification() {
        fetchRecord()
    }

    @objc
    private func didTapfilterButton() {
        self.navigationItem.rightBarButtonItem?.tintColor = .mainOrange
        bottomSheet.mdc_bottomSheetPresentationController?.preferredSheetHeight = Constant.mainHeight * 0.28
        self.present(bottomSheet, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        fetchRecord()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.selfView.tableView.layoutIfNeeded()
        self.view.layoutIfNeeded()
    }

    override func configureUI() {
        super.configureUI()
        selfView.emptyView.isHidden = true
        setTitle()
        self.view.addSubview(selfView)

        selfView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        self.selfView.tableView.reloadData()
        self.selfView.tableView.layoutIfNeeded()
    }

    override func bind() {
        viewModel.cateRecords
            .subscribe(onNext: { [weak self] _ in
                self?.hasNextPage = self?.lastPostId == self?.viewModel.currentCateRecords.last?.recordID ?? 0 ? false : true
                self?.lastPostId = self?.viewModel.currentCateRecords.last?.recordID ?? 0
                self?.isPaging = false // ????????? ??????
                self?.selfView.tableView.reloadData()
                self?.selfView.tableView.layoutIfNeeded()
            }).disposed(by: disposeBag)

        viewModel.loading
            .subscribe(onNext: { [weak self] loading in
                self?.selfView.loadingView.isHidden = !loading
            }).disposed(by: disposeBag)

        viewModel.recentFilter
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.currentCateRecords = []
                self?.filterType = "date"
                self?.fetchRecord()
                self?.selfView.tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                self?.selfView.tableView.reloadData()
                self?.selfView.tableView.layoutIfNeeded()
                self?.navigationItem.rightBarButtonItem?.tintColor = .white
            }).disposed(by: disposeBag)

        viewModel.likeFilter
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.currentCateRecords = []
                self?.filterType = "like"
                self?.fetchRecord()
                self?.selfView.tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                self?.navigationItem.rightBarButtonItem?.tintColor = .white
            }).disposed(by: disposeBag)

        viewModel.randomFilter
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.currentCateRecords = []
                self?.filterType = "random"
                self?.fetchRecord()
                self?.selfView.tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                self?.navigationItem.rightBarButtonItem?.tintColor = .white
            }).disposed(by: disposeBag)

        viewModel.reportState
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.currentCateRecords = []
                self?.fetchRecord()
            }).disposed(by: disposeBag)
    }

    private func setTitle() {
        let label = UILabel()
        switch self.myCateType {
        case .aLine:
            label.text = "??? ??? ??????"
        case .lyrics:
            label.text = "????????? ????????????"
        case .story:
            label.text = "?????? ??? ?????? ?????????"
        case .free:
            label.text = "?????? ??????"
        case .ost:
            label.text = "??? ????????? OST"
        default:
            print("default")
        }
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.tintColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
    }

    private func fetchRecord() {
        // 1. ????????? ????????? ????????? ??????????????????

        viewModel.selectRecordsShow(type: self.myCateType, postId: viewModel.currentCateRecords.last?.recordID, size: 10, sort: filterType, userid: Account.currentUser)
        // 2. ????????? ?????? ???????????? ????????? append (????????? ?????? ????????? ok)
    }

    private func beginPaging() {
        isPaging = true

        DispatchQueue.main.async { [weak self]  in
            self?.selfView.tableView.reloadSections(IndexSet(integer: 1), with: .none)
        }

        self.fetchRecord()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height

        // ???????????? ????????? ??? Offset??? ?????? ?????? ?????? ?????? ???????????? ??????
        if offsetY > (contentHeight - height) {
            if isPaging == false && hasNextPage {
                beginPaging()
            }
        }
    }
}

extension AllRecordCateDetailViewController: MDCBottomSheetControllerDelegate {
    func bottomSheetControllerDidDismissBottomSheet(_ controller: MDCBottomSheetController) {
        self.navigationItem.rightBarButtonItem?.tintColor = .white
    }
}
