//
//  Mydj + Table.swift
//  Omos
//
//  Created by sangheon on 2022/02/24.
//

import RxCocoa
import RxGesture
import RxSwift
import UIKit

extension MyDJViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.currentMyDjList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MydjCollectionCell.identifier, for: indexPath) as! MydjCollectionCell
        cell.backgroundColor = .mainBackGround
        let cellData = viewModel.currentMyDjList[indexPath.row]
        cell.configureModel(record: cellData)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        let cellData = viewModel.currentMyDjList[indexPath.row]
        guard let cell = collectionView.cellForItem(at: indexPath) as? MydjCollectionCell else { return }
        if cell.djImageView.layer.borderWidth == 1 {
            cell.djImageView.layer.borderWidth = 0
            isDjcliked = false
            self.viewModel.currentMyDjRecord = []
            viewModel.fetchMyDjRecord(userId: Account.currentUser, request: .init(postId: viewModel.currentMyDjRecord.last?.recordID, size: 6))
            self.selfView.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            return
        }
        collectionView.visibleCells.forEach { cell in
            if let cell = cell as? MydjCollectionCell {
                cell.djImageView.layer.borderWidth = 0
            }
        }
            cell.djImageView.layer.borderWidth = 1
            isDjcliked = true
            viewModel.fetchUserRecords(fromId: Account.currentUser, toId: cellData.userID)
    }
}

extension MyDJViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if isDjcliked {
                return viewModel.currentUserRecrods.count
            } else {
                return viewModel.currentMyDjRecord.count
            }
        } else if section == 1 && isPaging && hasNextPage {
            return 1
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let record: RecordResponse
            if isDjcliked {
                guard let userRecord = viewModel.currentUserRecrods[safe: indexPath.row] else { return LoadingCell() }
                 record = userRecord
            } else {
                guard let myDjRecord = viewModel.currentMyDjRecord[safe: indexPath.row] else { return LoadingCell() }
                record = myDjRecord
            }
            switch record.category {
            case "LYRICS":
                let cell = tableView.dequeueReusableCell(withIdentifier: AllrecordLyricsTableCell.identifier, for: indexPath) as! AllrecordLyricsTableCell
                cell.selfView.tableHeightConstraint?.deactivate()
                cell.configure(record: record)
                cell.selfView.lockButton.isHidden = true
                cell.selfView.tableView.reloadData()
                lyricsCellBind(cell: cell, data: record, indexPath: indexPath)
                cell.selectionStyle = . none
                return cell
            case "A_LINE":
                let cell = tableView.dequeueReusableCell(withIdentifier: AllRecordCateShortDetailCell.identifier, for: indexPath) as! AllRecordCateShortDetailCell
                cell.configure(record: record)
                shortCellBind(cell: cell, data: record)
                cell.myView.lockButton.isHidden = true
                cell.selectionStyle = . none
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: AllRecordCateLongDetailCell.identifier, for: indexPath) as! AllRecordCateLongDetailCell
                cell.configure(record: record)
                cell.layoutIfNeeded()

                if expandedIndexSet.contains(indexPath.row) {
                    // cell.layoutIfNeeded()
                    cell.myView.mainLabelView.numberOfLines = 0
                    cell.myView.mainLabelView.sizeToFit()
                    cell.myView.mainLabelView.setNeedsLayout()
                    cell.myView.mainLabelView.layoutIfNeeded()
                    cell.myView.readMoreButton.isHidden = true
                } else {
                    if  cell.myView.mainLabelView.maxNumberOfLines < 4 {
                        cell.myView.readMoreButton.isHidden = true
                    } else {
                        cell.myView.mainLabelView.numberOfLines = 3
                        cell.myView.mainLabelView.sizeToFit()
                        cell.myView.readMoreButton.isHidden = false
                    }
                }

                cell.selectionStyle = . none
                longCellBind(cell: cell, data: record)
                cell.myView.lockButton.isHidden = true
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
        let record: RecordResponse

        if isDjcliked {
            guard let userRecord = viewModel.currentUserRecrods[safe: indexPath.row] else { return }
             record = userRecord
        } else {
            guard let myDjRecord = viewModel.currentMyDjRecord[safe: indexPath.row] else { return }
            record = myDjRecord
        }

        if Account.currentUser == record.userID {
            let rp = RecordsRepositoryImpl(recordAPI: RecordAPI())
            let uc = RecordsUseCase(recordsRepository: rp)
            let vm = MyRecordDetailViewModel(usecase: uc)
            let vc = MyRecordDetailViewController(posetId: record.recordID, viewModel: vm)
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let rp = RecordsRepositoryImpl(recordAPI: RecordAPI())
            let uc = RecordsUseCase(recordsRepository: rp)
            let vm = AllRecordDetailViewModel(usecase: uc)
            let vc = AllRecordDetailViewController(viewModel: vm, postId: record.recordID)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 {
//            if record.category != "A_LINE" && record.category != "LYRICS" {
//                return 500
//            }
//        }

        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 {
//            if record.category == "A_LINE" || record.category == "LYRICS" {
//                return shortCellHeights[indexPath] ?? Constant.mainHeight * 0.63
//            }
//        }
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.height == 44.0 { return }
        shortCellHeights[indexPath] = cell.height
        longCellHeights[indexPath] = cell.height
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UIView()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }
}

extension MyDJViewController {
    func lyricsCellBind(cell: AllrecordLyricsTableCell, data: RecordResponse, indexPath: IndexPath) {
        cell.selfView.reportButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                let action = UIAlertAction(title: "신고하기", style: .default) { _ in
                    self?.viewModel.reportRecord(postId: data.recordID)
                    Account.currentReportRecordsId.append(data.recordID)
                }
                action.setValue(UIColor.mainOrange, forKey: "titleTextColor")
                self?.presentAlert(title: "", with: action, message: "이 레코드를 신고하시겠어요?", isCancelActionIncluded: true, preferredStyle: .alert)
            }).disposed(by: cell.disposeBag)

        cell.selfView.likeButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let count = Int(cell.selfView.likeCountLabel.text ?? "0")
                else { return }
                let userId = UserDefaults.standard.integer(forKey: "user")
                let recordId = data.recordID

                if cell.selfView.likeCountLabel.textColor == .mainOrange {
                    // 좋아요 취소
                    cell.selfView.likeButton.setImage(UIImage(named: "emptyLove"), for: .normal)
                    cell.selfView.likeCountLabel.textColor = .mainGrey3
                    cell.selfView.likeCountLabel.text = String(count - 1)
                    self?.viewModel.deleteLike(postId: recordId, userId: userId)
                } else {
                    // 좋아요 클릭
                    cell.selfView.likeButton.setImage(UIImage(named: "fillLove"), for: .normal)
                    cell.selfView.likeCountLabel.textColor = .mainOrange
                    cell.selfView.likeCountLabel.text = String(count + 1)
                    self?.viewModel.saveLike(postId: recordId, userId: userId)
                }
            }).disposed(by: cell.disposeBag)

        cell.selfView.scrapButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let scrapCount = Int(cell.selfView.scrapCountLabel.text ?? "0")
                else { return }
                let userId = UserDefaults.standard.integer(forKey: "user")
                let recordId = data.recordID

                if cell.selfView.scrapCountLabel.textColor == .mainOrange {
                    // 좋아요 취소
                    cell.selfView.scrapButton.setImage(UIImage(named: "emptyStar"), for: .normal)
                    cell.selfView.scrapCountLabel.textColor = .mainGrey3
                    cell.selfView.scrapCountLabel.text = String(scrapCount - 1)
                    self?.viewModel.deleteScrap(postId: recordId, userId: userId)
                } else {
                    // 좋아요 클릭
                    cell.selfView.scrapButton.setImage(UIImage(named: "fillStar"), for: .normal)
                    cell.selfView.scrapCountLabel.textColor = .mainOrange
                    cell.selfView.scrapCountLabel.text = String(scrapCount + 1)
                    self?.viewModel.saveScrap(postId: recordId, userId: userId)
                }
            }).disposed(by: cell.disposeBag)

        cell.selfView.nicknameLabel.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                let rp = RecordsRepositoryImpl(recordAPI: RecordAPI())
                let uc = RecordsUseCase(recordsRepository: rp)
                let vm = MyDjProfileViewModel(usecase: uc)
                let vc = MydjProfileViewController(viewModel: vm, toId: data.userID)
                self?.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: cell.disposeBag)
    }

    func shortCellBind(cell: AllRecordCateShortDetailCell, data: RecordResponse) {
        cell.myView.reportButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                let action = UIAlertAction(title: "신고하기", style: .default) { _ in
                    self?.viewModel.reportRecord(postId: data.recordID)
                    Account.currentReportRecordsId.append(data.recordID)
                }
                action.setValue(UIColor.mainOrange, forKey: "titleTextColor")
                self?.presentAlert(title: "", with: action, message: "이 레코드를 신고하시겠어요?", isCancelActionIncluded: true, preferredStyle: .alert)
            }).disposed(by: cell.disposeBag)

        cell.myView.likeButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let count = Int(cell.myView.likeCountLabel.text ?? "0")
                else { return }
                let userId = UserDefaults.standard.integer(forKey: "user")
                let recordId = data.recordID

                if cell.myView.likeCountLabel.textColor == .mainOrange {
                    // 좋아요 취소
                    cell.myView.likeButton.setImage(UIImage(named: "emptyLove"), for: .normal)
                    cell.myView.likeCountLabel.textColor = .mainGrey3
                    cell.myView.likeCountLabel.text = String(count - 1)
                    self?.viewModel.deleteLike(postId: recordId, userId: userId)
                } else {
                    // 좋아요 클릭
                    cell.myView.likeButton.setImage(UIImage(named: "fillLove"), for: .normal)
                    cell.myView.likeCountLabel.textColor = .mainOrange
                    cell.myView.likeCountLabel.text = String(count + 1)
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
                    // 좋아요 취소
                    cell.myView.scrapButton.setImage(UIImage(named: "emptyStar"), for: .normal)
                    cell.myView.scrapCountLabel.textColor = .mainGrey3
                    cell.myView.scrapCountLabel.text = String(scrapCount - 1)
                    self?.viewModel.deleteScrap(postId: recordId, userId: userId)
                } else {
                    // 좋아요 클릭
                    cell.myView.scrapButton.setImage(UIImage(named: "fillStar"), for: .normal)
                    cell.myView.scrapCountLabel.textColor = .mainOrange
                    cell.myView.scrapCountLabel.text = String(scrapCount + 1)
                    self?.viewModel.saveScrap(postId: recordId, userId: userId)
                }
            }).disposed(by: cell.disposeBag)

        cell.myView.nicknameLabel.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                let rp = RecordsRepositoryImpl(recordAPI: RecordAPI())
                let uc = RecordsUseCase(recordsRepository: rp)
                let vm = MyDjProfileViewModel(usecase: uc)
                let vc = MydjProfileViewController(viewModel: vm, toId: data.userID)
                self?.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: cell.disposeBag)
    }

    func longCellBind(cell: AllRecordCateLongDetailCell, data: RecordResponse) {
        cell.myView.reportButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                let action = UIAlertAction(title: "신고하기", style: .default) { _ in
                    self?.viewModel.reportRecord(postId: data.recordID)
                    Account.currentReportRecordsId.append(data.recordID)
                }
                action.setValue(UIColor.mainOrange, forKey: "titleTextColor")
                self?.presentAlert(title: "", with: action, message: "이 레코드를 신고하시겠어요?", isCancelActionIncluded: true, preferredStyle: .alert)
            }).disposed(by: cell.disposeBag)

        cell.myView.likeButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let count = Int(cell.myView.likeCountLabel.text ?? "0")
                else { return }
                let userId = UserDefaults.standard.integer(forKey: "user")
                let recordId = data.recordID

                if cell.myView.likeCountLabel.textColor == .mainOrange {
                    // 좋아요 취소
                    cell.myView.likeButton.setImage(UIImage(named: "emptyLove"), for: .normal)
                    cell.myView.likeCountLabel.textColor = .mainGrey3
                    cell.myView.likeCountLabel.text = String(count - 1)
                    self?.viewModel.deleteLike(postId: recordId, userId: userId)
                } else {
                    // 좋아요 클릭
                    cell.myView.likeButton.setImage(UIImage(named: "fillLove"), for: .normal)
                    cell.myView.likeCountLabel.textColor = .mainOrange
                    cell.myView.likeCountLabel.text = String(count + 1)
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
                    // 좋아요 취소
                    cell.myView.scrapButton.setImage(UIImage(named: "emptyStar"), for: .normal)
                    cell.myView.scrapCountLabel.textColor = .mainGrey3
                    cell.myView.scrapCountLabel.text = String(scrapCount - 1)
                    self?.viewModel.deleteScrap(postId: recordId, userId: userId)
                } else {
                    // 좋아요 클릭
                    cell.myView.scrapButton.setImage(UIImage(named: "fillStar"), for: .normal)
                    cell.myView.scrapCountLabel.textColor = .mainOrange
                    cell.myView.scrapCountLabel.text = String(scrapCount + 1)
                    self?.viewModel.saveScrap(postId: recordId, userId: userId)
                }
            }).disposed(by: cell.disposeBag)

        cell.myView.readMoreButton.rx
            .tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                let indexPath = self.selfView.tableView.indexPath(for: cell)!
                print(indexPath)
                if self.expandedIndexSet.contains(indexPath.row) {
                    self.expandedIndexSet.remove(indexPath.row)
                } else {
                    self.expandedIndexSet.insert(indexPath.row)
                }
                self.selfView.tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            })
            .disposed(by: cell.disposeBag)

        cell.myView.nicknameLabel.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                let rp = RecordsRepositoryImpl(recordAPI: RecordAPI())
                let uc = RecordsUseCase(recordsRepository: rp)
                let vm = MyDjProfileViewModel(usecase: uc)
                let vc = MydjProfileViewController(viewModel: vm, toId: data.userID)
                self?.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: cell.disposeBag)
    }
}
