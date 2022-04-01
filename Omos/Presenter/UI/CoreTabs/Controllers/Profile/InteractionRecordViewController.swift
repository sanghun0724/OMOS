//
//  InteractionRecordViewController.swift
//  Omos
//
//  Created by sangheon on 2022/03/18.
//

import UIKit

enum InteractionType {
    case like
    case scrap
}

class InteractionRecordViewController:BaseViewController {
    
    let selfView = MyRecordView()
    let viewModel:ProfileViewModel
    let type:InteractionType
    
    init(viewModel:ProfileViewModel,type:InteractionType) {
        self.viewModel = viewModel
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        selfView.tableView.dataSource = self
        selfView.tableView.delegate = self
        type == .like ? (viewModel.fetchLikesRecords(userId: Account.currentUser)):(viewModel.fetchScrapRecords(userId: Account.currentUser))
    }
    
    override func configureUI() {
        super.configureUI()
        self.view.addSubview(selfView)
        
        selfView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
    func bind() {
        if type == .like {
            viewModel.likesLoading
                .subscribe(onNext: { [weak self] loading in
                    self?.selfView.loadingView.isHidden = !loading
                }).disposed(by: disposeBag)
            
            viewModel.likeRecord
                .subscribe(onNext: { [weak self] _ in
                    self?.selfView.tableView.reloadData()
                }).disposed(by: disposeBag)
        } else {
            viewModel.scrapsLoading
                .subscribe(onNext: { [weak self] loading in
                    self?.selfView.loadingView.isHidden = !loading
                }).disposed(by: disposeBag)
            
            viewModel.scrapRecord
                .subscribe(onNext: { [weak self] _ in
                    self?.selfView.tableView.reloadData()
                }).disposed(by: disposeBag)
        }
    }
    
}


extension InteractionRecordViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if type == .like {
            return viewModel.currentLikeRecord.count
        } else {
            return viewModel.currentScrapRecord.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyRecordTableCell.identifier, for: indexPath) as! MyRecordTableCell
        if type == .like {
            let data = viewModel.currentLikeRecord[indexPath.row]
                    cell.configureModel(record:data)
        } else {
            let data = viewModel.currentScrapRecord[indexPath.row]
                    cell.configureModel(record:data)
        }

        cell.lockImageView.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let data:MyRecordRespone
        if type == .like {
             data = viewModel.currentLikeRecord[indexPath.row]
                    
        } else {
             data = viewModel.currentScrapRecord[indexPath.row]
        }
        let rp = RecordsRepositoryImpl(recordAPI: RecordAPI())
        let uc = RecordsUseCase(recordsRepository: rp)
        let vm = AllRecordDetailViewModel(usecase: uc)
        let vc = AllRecordDetailViewController(viewModel: vm, postId: data.recordID)
        self.navigationController?.pushViewController(vc, animated: true)
        

       
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    
}
