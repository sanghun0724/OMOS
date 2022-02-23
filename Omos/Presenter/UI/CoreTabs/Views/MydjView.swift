//
//  MydjView.swift
//  Omos
//
//  Created by sangheon on 2022/02/24.
//

import Foundation
import UIKit

class MydjView:BaseView {
    
    
    var collectionView:UICollectionView!
    
    let tableView:UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(MyRecordTableCell.self, forCellReuseIdentifier: MyRecordTableCell.identifier)
        table.backgroundColor = .mainBlack
        table.showsVerticalScrollIndicator = false
        table.automaticallyAdjustsScrollIndicatorInsets = false
        return table
    }()
    
    
    override func configureUI() {
        super.configureUI()
        setUpCollection()
    }
    
    

}


extension MydjView:UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    
    
    
    
    
    
    
    
    
    
    
    func setUpCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal//UIScreen.main.bounds.height / 4.72)
        //if ~~~~ emptycell here
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 1.22 , height: UIScreen.main.bounds.height / 4.74) //비율정해서 설정하기
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 6
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(AllRecordCollectionCell.self, forCellWithReuseIdentifier: AllRecordCollectionCell.identifier)
        collectionView.register(EmptyCell.self, forCellWithReuseIdentifier: EmptyCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        self.addSubview(collectionView)
        collectionView.showsHorizontalScrollIndicator = false
    }
}
