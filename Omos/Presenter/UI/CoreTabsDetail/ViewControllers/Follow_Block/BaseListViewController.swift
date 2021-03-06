//
//  BaseFollowViewController.swift
//  Omos
//
//  Created by sangheon on 2022/05/29.
//

import UIKit

class BaseListDecorator: BaseViewController {
    var decoratorAction: FollowBlockBaseProtocol
    let listTableView: UITableView = {
        let table = UITableView()
        table.register(FollowBlockListCell.self, forCellReuseIdentifier: FollowBlockListCell.identifier)
        table.backgroundColor = .mainBackGround
        return table
    }()
    
    init(decoratorAction: FollowBlockBaseProtocol) {
        self.decoratorAction = decoratorAction
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.delegate = self
        listTableView.dataSource = self
        configureUI()
        fetchData()
        binding(listTableView: listTableView)
        self.navigationItem.title = "차단된 계정"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        callAction()
    }
    
    override func configureUI() {
        super.configureUI()
        view.addSubview(listTableView)
        listTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func binding(listTableView: UITableView) {
        decoratorAction.binding(listTableView: listTableView)
    }
    
    func bindingCell(cell: FollowBlockListCell, data: ListResponse, index: IndexPath) {
        decoratorAction.bindingCell(cell: cell, data: data, index: index)
    }
    
    func fetchData() {
        decoratorAction.fetchData()
    }
    
    func dataCount() -> Int {
        decoratorAction.dataCount()
    }
    
    func cellData() -> [ListResponse] {
        decoratorAction.cellData()
    }
    
    func callAction() {
        decoratorAction.callAction()
    }
    
}

extension BaseListDecorator: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FollowBlockListCell.identifier) as? FollowBlockListCell else {
            return UITableViewCell()
        }
        guard let data = cellData()[safe:indexPath.row] else { return UITableViewCell() }
        cell.configure(data: data)
        cell.selectionStyle = .none
        bindingCell(cell: cell ,data: data, index: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constant.mainHeight * 0.094
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let data = cellData()[safe:indexPath.row] else { return }
        let rp = RecordsRepositoryImpl(recordAPI: RecordAPI())
        let uc = RecordsUseCase(recordsRepository: rp)
        let vm = MyDjProfileViewModel(usecase: uc)
        let vc = MydjProfileViewController(viewModel: vm, toId: data.userID)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
