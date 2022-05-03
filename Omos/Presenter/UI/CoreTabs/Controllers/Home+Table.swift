//
//  Home + Table.swift
//  Omos
//
//  Created by sangheon on 2022/03/07.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return UITableViewCell()
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: AllRecordTableCell.identifier, for: indexPath) as! AllRecordTableCell
            cell.selectionStyle = .none
            cell.cellDelegate = self
            cell.popuralRecords = viewModel.currentPopuralRecord
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableMiddleCell.identifier, for: indexPath) as! HomeTableMiddleCell
            cell.selectionStyle = .none
            cell.cellDelegate = self
            cell.configureModel(records: viewModel.currentRecommentRecord)
            cell.collectionView.reloadData()
            return cell
        case 3:
            guard let cellData = viewModel.currentLovedRecord else {
                let cell = tableView.dequeueReusableCell(withIdentifier: LovedEmptyCell.identifier, for: indexPath) as! LovedEmptyCell
                cell.selectionStyle = .none
                return cell
            }

            let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableLastCell.identifier, for: indexPath) as! HomeTableLastCell
            cell.configureModel(record: cellData)
            cell.selectionStyle = .none
            return cell
        default:
            print("de other")
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: AllRecordHeaderView.identifier) as! AllRecordHeaderView
        header.button.isHidden = true
        switch section {
        case 0:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeHeaderView.identifier) as! HomeHeaderView
            header.createdButton.rx.tap
                .throttle(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
                .subscribe(onNext: { [weak self] _ in
                    let rp = SearchRepositoryImpl(searchAPI: SearchAPI())
                    let uc = SearchUseCase(searchRepository: rp)
                    let vm = SearchViewModel(usecase: uc)
                    let vc = SearchViewController(viewModel: vm, searchType: .me)
                    self?.navigationController?.pushViewController(vc, animated: true)
                }).disposed(by: header.disposeBag)

            guard let headerData = viewModel.currentTodayRecord else { return header }

            header.songTitleLabel.text = headerData.musicTitle
            header.artistTitleLabel.text = headerData.artists.map { $0.artistName }.reduce("") { $0 + " \($1)" }
            header.albumImageView.setImage(with: headerData.albumImageURL)
            header.albumTitleLabel.text = headerData.albumTitle
            return header
        case 1:
            header.label.text = "지금 인기있는 레코드"
            return header
        case 2:
            header.label.text = "OMOS 추천 DJ"
            return header
        case 3:
            header.label.text = "내가 사랑했던 노래"
            return header
        default:
            print("de other")
        }

        return header
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 0
        case 1:
            return Constant.mainHeight / 4.72
        case 2:
            return Constant.mainHeight * 0.147_8
        case 3:
            return Constant.mainHeight * 0.201
        default:
            print("default")
        }

        return 100
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.mainBackGround
        (view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor.white
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return Constant.mainHeight * 0.34
        } else {
            return Constant.mainHeight / 17
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       if indexPath.section == 3 {
           guard let data = viewModel.currentLovedRecord else {
               let rp = SearchRepositoryImpl(searchAPI: SearchAPI())
               let uc = SearchUseCase(searchRepository: rp)
               let vm = SearchViewModel(usecase: uc)
               let vc = SearchViewController(viewModel: vm, searchType: .main)
               self.navigationController?.pushViewController(vc, animated: true)
               return
           }

           let rp = RecordsRepositoryImpl(recordAPI: RecordAPI())
           let uc = RecordsUseCase(recordsRepository: rp)
           let vm = MyRecordDetailViewModel(usecase: uc)
           let vc = MyRecordDetailViewController(posetId: data.recordID, viewModel: vm)
           self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
