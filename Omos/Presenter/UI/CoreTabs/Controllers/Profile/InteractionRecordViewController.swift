//
//  InteractionRecordViewController.swift
//  Omos
//
//  Created by sangheon on 2022/03/18.
//

import UIKit

class InteractionRecordViewController:BaseViewController {
    
    let selfView = MyRecordView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selfView.tableView.dataSource = self
        selfView.tableView.delegate = self
    }
    
    override func configureUI() {
        super.configureUI()
        self.view.addSubview(selfView)
        
        selfView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
}


extension InteractionRecordViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyRecordTableCell.identifier, for: indexPath) as! MyRecordTableCell
//        let data = myRecord[indexPath.row]
//        cell.configureModel(record:data)
        cell.lockImageView.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
//        let data = myRecord[indexPath.row]
//        let rp = RecordsRepositoryImpl(recordAPI: RecordAPI())
//        let uc = RecordsUseCase(recordsRepository: rp)
//        let vm = MyRecordDetailViewModel(usecase: uc)
//        let vc = MyRecordDetailViewController(posetId: data.recordID,viewModel: vm)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    
}
