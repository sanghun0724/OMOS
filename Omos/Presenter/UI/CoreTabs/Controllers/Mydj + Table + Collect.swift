//
//  Mydj + Table.swift
//  Omos
//
//  Created by sangheon on 2022/02/24.
//

import Foundation
import UIKit


extension MyDJViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MydjTableCell.identifier, for: indexPath) as! MydjTableCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.621
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}


extension MyDJViewController:UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //if model.count == 0 {} else {}
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //if model.count == 0 {empty cell } else { }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MydjCollectionCell.identifier, for: indexPath) as! MydjCollectionCell
        cell.backgroundColor = .mainBackGround
//        cell.rx.tapGesture()
//            .when(.recognized)
//            .asDriver{_ in .never()}
//            .drive(onNext: { [weak self] _ in
//               let vc = MydjProfileViewController()
//                self?.navigationController?.pushViewController(vc, animated: true)
//            })
//            .disposed(by: cell.disposeBag)
            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        
        let vc = MydjProfileViewController()
         self.navigationController?.pushViewController(vc, animated: true)
        
    }

   
}
