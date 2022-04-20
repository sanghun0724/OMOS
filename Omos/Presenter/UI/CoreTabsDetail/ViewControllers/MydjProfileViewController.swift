//
//  MydjProfileViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/27.
//

import KakaoSDKUser
import UIKit

class MydjProfileViewController: BaseViewController {
    private let selfView = MydjProfieView()
    let viewModel: MyDjProfileViewModel
    let fromId = UserDefaults.standard.integer(forKey: "user")
    let toId: Int

    init(viewModel: MyDjProfileViewModel, toId: Int) {
        self.viewModel = viewModel
        self.toId = toId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
        selfView.tableView.delegate = self
        selfView.tableView.dataSource = self
        self.navigationItem.rightBarButtonItems?.removeAll()
        viewModel.fetchMyDjProfile(fromId: fromId, toId: toId)
        viewModel.fetchUserRecords(toUserId: toId)
        self.navigationController?.navigationBar.backgroundColor = .mainBlack
        setNavigationItems()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.backgroundColor = .mainBackGround
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backgroundColor = .mainBlack
    }

    private func setNavigationItems() {
        self.navigationItem.rightBarButtonItems?.removeAll()
        let reportButton = UIBarButtonItem(image: UIImage(named: "report"), style: .plain, target: self, action: #selector(didTapReportButton))
        reportButton.tintColor = .white
        self.navigationItem.rightBarButtonItems = [reportButton]
    }

    @objc
    func didTapReportButton() {
        let action = UIAlertAction(title: "신고하기", style: .default) {[weak self] _ in
            guard let id = self?.toId else { return }
            print("userId입니다:\(id)")
            self?.viewModel.userReport(userId: id)
        }
        let action2 = UIAlertAction(title: "차단하기", style: .default) {[weak self] _ in
            guard let id = self?.toId else { return }
            print("userId입니다:\(id)")
            self?.viewModel.blockObjcet(type: "User", request: .init(fromUserId: self?.fromId ?? 0, toUserId: id))
            self?.viewModel.deleteFollow(fromId: self?.fromId ?? 0, toId: id)
            NotificationCenter.default.post(name: NSNotification.Name.followCancel, object: nil, userInfo: nil)
            self?.backToView()
        }
        action.setValue(UIColor.mainOrange, forKey: "titleTextColor")
        action2.setValue(UIColor.mainOrange, forKey: "titleTextColor")
        self.presentAlert(title: "", message: "이 DJ를 차단하거나 신고하시겠어요?", isCancelActionIncluded: true, preferredStyle: .alert, with: action, action2)
    }

    override func configureUI() {
        super.configureUI()
        self.view.addSubview(selfView)
        self.view.backgroundColor = .mainBlack

        selfView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
    }

    func bind() {
        viewModel.recordsLoading
            .subscribe(onNext: { [weak self] loading in
                self?.selfView.loadingView.isHidden = !loading
            }).disposed(by: disposeBag)

        viewModel.mydjProfile
            .subscribe(onNext: { [weak self] _ in
                self?.selfView.tableView.reloadSections(IndexSet(0..<1), with: .automatic)
            }).disposed(by: disposeBag)

        viewModel.userRecords
            .subscribe(onNext: { [weak self] _ in
                self?.selfView.tableView.reloadData()
            }).disposed(by: disposeBag)

        viewModel.userReportState
            .subscribe(onNext: { [weak self] _ in
                NotificationCenter.default.post(name: NSNotification.Name.reload, object: nil, userInfo: nil)
                self?.backToView()
            }).disposed(by: disposeBag)
    }

    func backToView() {
        for controller in (self.navigationController?.viewControllers ?? [UIViewController()] )  as Array {
            if controller.isKind(of: HomeViewController.self) {
                self.navigationController?.popToViewController(controller, animated: true)
                break
            }
            if controller.isKind(of: AllRecordCateDetailViewController.self) {
                self.navigationController?.popToViewController(controller, animated: true)

                break
            }
            if controller.isKind(of: AllRecordSearchDetailViewController.self) {
                self.navigationController?.popToViewController(controller, animated: true)
                break
            }
        }
        for controller in (self.navigationController?.viewControllers ?? [UIViewController()] )  as Array {
            if controller.isKind(of: AllRecordViewController.self) {
                self.navigationController?.popToViewController(controller, animated: true)
                break
            }
        }
        for controller in (self.navigationController?.viewControllers ?? [UIViewController()] )  as Array {
            if controller.isKind(of: MyDJViewController.self) {
                self.navigationController?.popToViewController(controller, animated: true)
                break
            }
        }
    }
}
