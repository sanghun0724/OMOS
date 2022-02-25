//
//  MydjView.swift
//  Omos
//
//  Created by sangheon on 2022/02/24.
//

import Foundation
import UIKit

class MydjView:BaseView {
    
    let cellSize = UIScreen.main.bounds.width * 0.21
    
    var collectionView:UICollectionView!
    
    let tableView:UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(MydjTableCell.self, forCellReuseIdentifier: MydjTableCell.identifier)
        table.backgroundColor = .mainBackGround
        table.showsVerticalScrollIndicator = false
        table.automaticallyAdjustsScrollIndicatorInsets = false
        return table
    }()
    
    
    override func configureUI() {
        super.configureUI()
        setUpCollection()
        addSubview(tableView)
        
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(cellSize+6)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
    

}


extension MydjView:UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //if model.count == 0 {} else {}
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //if model.count == 0 {empty cell } else { }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MydjCollectionCell.identifier, for: indexPath) as! MydjCollectionCell
        cell.backgroundColor = .mainBackGround
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
    }

    func setUpCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal//UIScreen.main.bounds.height / 4.72)
        //if ~~~~ emptycell here
        layout.itemSize = CGSize(width: cellSize , height: cellSize) //비율정해서 설정하기
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 6
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MydjCollectionCell.self, forCellWithReuseIdentifier: MydjCollectionCell.identifier)
        collectionView.register(EmptyCell.self, forCellWithReuseIdentifier: EmptyCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        self.addSubview(collectionView)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .mainBackGround
    }
}
