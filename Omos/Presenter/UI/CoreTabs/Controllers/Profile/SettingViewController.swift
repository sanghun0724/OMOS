//
//  SettingViewController.swift
//  Omos
//
//  Created by sangheon on 2022/03/18.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKUser
import KakaoSDKAuth

class SettingViewController:BaseViewController {
    
    let tableView:UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "header")
        table.separatorStyle = .none
        table.backgroundColor = .mainBackGround
        table.showsVerticalScrollIndicator = false
        table.isScrollEnabled = false
        return table
    }()
    let viewModel:ProfileViewModel
    
    init(viewModel:ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        bind()
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.view.backgroundColor = .mainBackGround
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func configureUI() {
        super.configureUI()
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func bind() {
        viewModel.logoutState
            .subscribe(onNext: { [weak self] state in
                if state {
                    let uc = LoginUseCase(authRepository:AuthRepositoryImpl(loginAPI: LoginAPI()))
                    let vm = LoginViewModel(usecase: uc)
                    let vc = LoginViewController(viewModel: vm)
                    UIApplication.shared.windows.first?.rootViewController = vc
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                    self?.navigationController?.popToRootViewController(animated: false)
                }
            }).disposed(by: disposeBag)
        
    }
    
    private func logout() {
        // KAKAKO 로그아웃
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("로그아웃 성공")
            }
        }
        // APPLE 로그아웃 은 각자 해야함 화면 돌려주기만 하기
        
        // local
        viewModel.logOut(userId: Account.currentUser)
        
        //reset UserDefault
        resetDefaults()
    }
    
    private func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
}


extension SettingViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .mainBackGround
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "프로필 변경"
            case 1:
                cell.textLabel?.text = "비밀번호 변경"
            default:
                print("")
            }
        } else {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "로그아웃"
            case 1:
                cell.textLabel?.text = "계정탈퇴"
            default:
                print("")
            }
        }
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")!
        if section == 0 {
            header.textLabel?.text = "개인정보"
        } else {
            header.textLabel?.text = "계정관리"
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            view.backgroundView?.backgroundColor = .mainBackGround
            view.textLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
            view.textLabel?.textColor = .mainOrange
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                let vc = ProfileChangeViewController(viewModel: viewModel)
                self.navigationController?.pushViewController(vc, animated: true)
            case 1:
                let vc = PasswordChangeViewController(viewModel: viewModel)
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                print("")
            }
        } else {
            switch indexPath.row {
            case 0:
                //logout
                let action = UIAlertAction(title: "로그아웃", style: .default) { alert in
                    self.logout()
                }
                action.setValue(UIColor.mainOrange, forKey: "titleTextColor")
                self.presentAlert(title: "", message: "정말 로그아웃 하시겠어요?", isCancelActionIncluded: true, preferredStyle: .alert, with: action)
            case 1:
                let vc = AccountOutViewController(viewModel: viewModel)
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                print("")
            }
        }
        
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .mainBlack1
        return view
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.5
        } else {
            return 0
        }
        
    }
    
}
