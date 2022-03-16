//
//  AllRecordCateDetail + Table.swift
//  Omos
//
//  Created by sangheon on 2022/03/12.
//

import UIKit
import RxSwift
import RxCocoa

extension AllRecordCateDetailViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return cateRecords.count ?? 0
        } else if section == 1 && isPaging && hasNextPage {
            return 1
        }
        return 0
    }

    
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let record = cateRecords[safe:indexPath.row] else { return UITableViewCell() }
            switch self.myCateType {
            case .LYRICS:
                let cell = tableView.dequeueReusableCell(withIdentifier: AllrecordLyricsTableCell.identifier, for: indexPath) as! AllrecordLyricsTableCell
                cell.configureModel(record: record)
                cell.selectionStyle = . none
              
                return cell
            case .A_LINE:
                let cell = tableView.dequeueReusableCell(withIdentifier: AllRecordCateShortDetailCell.identifier, for: indexPath) as! AllRecordCateShortDetailCell
                cell.configureModel(record: record)
                shortCellBind(cell: cell, data: record)
                cell.selectionStyle = . none
                cell.myView.lockButton.isHidden = true
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: AllRecordCateLongDetailCell.identifier, for: indexPath) as! AllRecordCateLongDetailCell
                
                if expandedIndexSet.contains(indexPath.row) {
                    cell.myView.myView.mainLabelView.numberOfLines = 0
                    cell.myView.myView.mainLabelView.sizeToFit()
                    cell.myView.dummyLabel.text = "접기"
                } else {
                    cell.myView.myView.mainLabelView.numberOfLines = 3
                    cell.myView.myView.mainLabelView.sizeToFit()
                    cell.myView.dummyLabel.text = " 더보기"
                }
                cell.delegate = self
                cell.configureModel(record: record)
                longCellBind(cell: cell, data: record)
                cell.myView.myView.lockButton.isHidden = true
                cell.selectionStyle = . none
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.identifier, for: indexPath) as! LoadingCell
            
            cell.start()
            return cell
        }
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let record = cateRecords[indexPath.row]
      
        if Account.currentUser == record.userID {
            let rp = RecordsRepositoryImpl(recordAPI: RecordAPI())
            let uc = RecordsUseCase(recordsRepository: rp)
            let vm = MyRecordDetailViewModel(usecase: uc)
            let vc = MyRecordDetailViewController(posetId: record.recordID, viewModel: vm, cate: record.category)
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let rp = RecordsRepositoryImpl(recordAPI: RecordAPI())
            let uc = RecordsUseCase(recordsRepository: rp)
            let vm = AllRecordDetailViewModel(usecase: uc)
            let vc = AllRecordDetailViewController(viewModel: vm, postId: record.recordID, userId: record.userID)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            switch self.myCateType {
            case .LYRICS:
                return UITableView.automaticDimension
            case .A_LINE:
                return shortCellHeights[indexPath] ?? Constant.mainHeight * 0.63
            default:
                return longCellHeights[indexPath] ?? UITableView.automaticDimension
            }
        }
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        tableView.layoutIfNeeded()
       
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.height == 44.0 { return }
        shortCellHeights[indexPath] = cell.height
        longCellHeights[indexPath] = cell.height

       
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
}

extension AllRecordCateDetailViewController:MyCellDelegate {
    func readMoreTapped(cell: AllRecordCateLongDetailCell) {
        let indexPath = selfView.tableView.indexPath(for: cell)!
        print(indexPath)
        if(expandedIndexSet.contains(indexPath.row)){
            expandedIndexSet.remove(indexPath.row)
        } else {
            expandedIndexSet.insert(indexPath.row)
        }
        selfView.tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}


extension AllRecordCateDetailViewController {
    func shortCellBind(cell:AllRecordCateShortDetailCell,data:CategoryRespone) {
        cell.myView.reportButton.rx.tap
            .asDriver()
            .drive(onNext:{ [weak self] _ in
                let action = UIAlertAction(title: "신고", style: .default) { alert in
                    print(alert)
                }
                action.setValue(UIColor.mainOrange, forKey: "titleTextColor")
                self?.presentAlert(title: "신고하기", message: "이 레코드를 신고하시겠어요?", isCancelActionIncluded: true, preferredStyle: .alert, with: action)
            }).disposed(by: cell.disposeBag)
        
        cell.myView.likeButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let count = Int(cell.myView.likeCountLabel.text ?? "0")
                else { return }
                let userId = UserDefaults.standard.integer(forKey: "user")
                let recordId = data.recordID
                
                if cell.myView.likeCountLabel.textColor == .mainOrange {
                    //좋아요 취소
                    cell.myView.likeButton.setImage(UIImage(named:"emptyLove"), for: .normal)
                    cell.myView.likeCountLabel.textColor = .mainGrey3
                    cell.myView.likeCountLabel.text = String(count-1)
                    self?.viewModel.deleteLike(postId: recordId, userId: userId)
                } else {
                    //좋아요 클릭
                    cell.myView.likeButton.setImage(UIImage(named:"fillLove"), for: .normal)
                    cell.myView.likeCountLabel.textColor = .mainOrange
                    cell.myView.likeCountLabel.text = String(count+1)
                    self?.viewModel.saveLike(postId: recordId, userId: userId)
                }
            }).disposed(by: cell.disposeBag)
        
        cell.myView.scrapButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let scrapCount = Int(cell.myView.scrapCountLabel.text ?? "0")
                else { return }
                let userId = UserDefaults.standard.integer(forKey: "user")
                let recordId = data.recordID
                
                if cell.myView.scrapCountLabel.textColor == .mainOrange {
                    //좋아요 취소
                    cell.myView.scrapButton.setImage(UIImage(named:"emptyStar"), for: .normal)
                    cell.myView.scrapCountLabel.textColor = .mainGrey3
                    cell.myView.scrapCountLabel.text = String(scrapCount-1)
                    self?.viewModel.deleteScrap(postId: recordId, userId: userId)
                } else {
                    //좋아요 클릭
                    cell.myView.scrapButton.setImage(UIImage(named:"fillStar"), for: .normal)
                    cell.myView.scrapCountLabel.textColor = .mainOrange
                    cell.myView.scrapCountLabel.text = String(scrapCount+1)
                    self?.viewModel.saveScrap(postId: recordId, userId: userId)
                }
            }).disposed(by: cell.disposeBag)
    }
    
    func longCellBind(cell:AllRecordCateLongDetailCell,data:CategoryRespone) {
        cell.myView.myView.reportButton.rx.tap
            .asDriver()
            .drive(onNext:{ [weak self] _ in
                let action = UIAlertAction(title: "신고", style: .default) { alert in
                    print(alert)
                }
                action.setValue(UIColor.mainOrange, forKey: "titleTextColor")
                self?.presentAlert(title: "신고하기", message: "이 레코드를 신고하시겠어요?", isCancelActionIncluded: true, preferredStyle: .alert, with: action)
            }).disposed(by: cell.disposeBag)
        
        cell.myView.myView.likeButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let count = Int(cell.myView.myView.likeCountLabel.text ?? "0")
                else { return }
                let userId = UserDefaults.standard.integer(forKey: "user")
                let recordId = data.recordID
                
                if cell.myView.myView.likeCountLabel.textColor == .mainOrange {
                    //좋아요 취소
                    cell.myView.myView.likeButton.setImage(UIImage(named:"emptyLove"), for: .normal)
                    cell.myView.myView.likeCountLabel.textColor = .mainGrey3
                    cell.myView.myView.likeCountLabel.text = String(count-1)
                    self?.viewModel.deleteLike(postId: recordId, userId: userId)
                } else {
                    //좋아요 클릭
                    cell.myView.myView.likeButton.setImage(UIImage(named:"fillLove"), for: .normal)
                    cell.myView.myView.likeCountLabel.textColor = .mainOrange
                    cell.myView.myView.likeCountLabel.text = String(count+1)
                    self?.viewModel.saveLike(postId: recordId, userId: userId)
                }
            }).disposed(by: cell.disposeBag)
        
        cell.myView.myView.scrapButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let scrapCount = Int(cell.myView.myView.scrapCountLabel.text ?? "0")
                else { return }
                let userId = UserDefaults.standard.integer(forKey: "user")
                let recordId = data.recordID
                
                if cell.myView.myView.scrapCountLabel.textColor == .mainOrange {
                    //좋아요 취소
                    cell.myView.myView.scrapButton.setImage(UIImage(named:"emptyStar"), for: .normal)
                    cell.myView.myView.scrapCountLabel.textColor = .mainGrey3
                    cell.myView.myView.scrapCountLabel.text = String(scrapCount-1)
                    self?.viewModel.deleteScrap(postId: recordId, userId: userId)
                } else {
                    //좋아요 클릭
                    cell.myView.myView.scrapButton.setImage(UIImage(named:"fillStar"), for: .normal)
                    cell.myView.myView.scrapCountLabel.textColor = .mainOrange
                    cell.myView.myView.scrapCountLabel.text = String(scrapCount+1)
                    self?.viewModel.saveScrap(postId: recordId, userId: userId)
                }
            }).disposed(by: cell.disposeBag)
        
    }
}
