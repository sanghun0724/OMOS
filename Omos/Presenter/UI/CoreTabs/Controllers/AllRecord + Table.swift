//
//  AllRecord + Table.swift
//  Omos
//
//  Created by sangheon on 2022/02/06.
//

import Foundation
import UIKit
import RxSwift


extension AllRecordViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberofSections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllRecordTableCell.identifier,for:indexPath) as! AllRecordTableCell
        guard let model = self.selectedRecords else { return  AllRecordTableCell() }
        cell.backgroundColor = .mainBackGround
        switch indexPath.section {
        case 0:
            cell.configureModel(records: model.aLine)
            cell.cate = "A_LINE"
        case 1:
            cell.configureModel(records: model.ost)
            cell.cate = "OST"
        case 2:
            cell.configureModel(records: model.story)
            cell.cate = "STORY"
        case 3:
            cell.configureModel(records: model.lyrics)
            cell.cate = "LYRICS"
        case 4:
            cell.configureModel(records: model.free)
            cell.cate = "FREE"
        default:
            print("default")
        }
        cell.cellDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: AllRecordHeaderView.identifier) as! AllRecordHeaderView
        let uc = RecordsUseCase(recordsRepository: RecordsRepositoryImpl(recordAPI: RecordAPI()))
        let vm = AllRecordCateDetailViewModel(usecase: uc)
        switch section {
        case 0:
            headerView.label.text = "한 줄 감상"
            headerView.button.rx.tap.asDriver()
                .drive(onNext: { [weak self] in
                    let vc = AllRecordCateDetailViewController(viewModel: vm, cateType: .A_LINE)
                    self?.navigationController?.pushViewController(vc, animated: true)
                }).disposed(by: headerView.disposeBag)
        case 1:
            headerView.label.text = "내인생의 OST"
            headerView.button.rx.tap.asDriver()
                .drive(onNext: { [weak self] in
                    let vc = AllRecordCateDetailViewController(viewModel: vm, cateType: .OST)
                    self?.navigationController?.pushViewController(vc, animated: true)
                }).disposed(by: headerView.disposeBag)
        case 2:
            headerView.label.text = "노래속 나의 이야기"
            headerView.button.rx.tap.asDriver()
                .drive(onNext: { [weak self] in
                    let vc = AllRecordCateDetailViewController(viewModel: vm, cateType: .STORY)
                    self?.navigationController?.pushViewController(vc, animated: true)
                }).disposed(by: headerView.disposeBag)
        case 3:
            headerView.label.text = "나만의 가사 해석"
            headerView.button.rx.tap.asDriver()
                .drive(onNext: { [weak self] in
                    let vc = AllRecordCateDetailViewController(viewModel: vm, cateType: .LYRICS)
                    self?.navigationController?.pushViewController(vc, animated: true)
                }).disposed(by: headerView.disposeBag)
        case 4:
            headerView.label.text = "자유 공간"
            headerView.button.rx.tap.asDriver()
                .drive(onNext: { [weak self] in
                    let vc = AllRecordCateDetailViewController(viewModel: vm, cateType: .FREE)
                    self?.navigationController?.pushViewController(vc, animated: true)
                }).disposed(by: headerView.disposeBag)
        default:
            print("you need to add section case")
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.mainBackGround
        (view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor.white
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 4.72
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIScreen.main.bounds.height / 17
    }
    
}
