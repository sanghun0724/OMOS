//
//  HomeTableCell.swift
//  Omos
//
//  Created by sangheon on 2022/03/11.
//

import Foundation
import UIKit

protocol HomeTableMiddleCellprotocol:AnyObject {
    func collectionView(collectionViewCell:MydjCollectionCell?,index:Int,didTappedInTableViewCell:HomeTableMiddleCell)
}

class HomeTableMiddleCell:UITableViewCell {
    static let identifier = "HomeTableMiddleCell"
    let cellSize = UIScreen.main.bounds.width * 0.21
    
    var selectedRecords:[ALine]? {
        didSet {
            collectionView.reloadData()
        }
    }
    weak var cellDelegate: HomeTableMiddleCellprotocol?
    private var collectionView:UICollectionView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCollection()
    }
    
     private func setUpCollection() {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: cellSize , height: cellSize) //비율정해서 설정하기
            layout.minimumLineSpacing = 6
            layout.minimumInteritemSpacing = 6
            collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.register(MydjCollectionCell.self, forCellWithReuseIdentifier: MydjCollectionCell.identifier)
            collectionView.register(EmptyCell.self, forCellWithReuseIdentifier: EmptyCell.identifier)
            collectionView.delegate = self
            collectionView.dataSource = self
            self.addSubview(collectionView)
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.backgroundColor = .mainBackGround
        }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureModel(records:[ALine]) {
        self.selectedRecords = records
    }
    
}

extension HomeTableMiddleCell: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.selectedRecords?.count ?? 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MydjCollectionCell.identifier, for: indexPath) as! MydjCollectionCell
        guard let data = self.selectedRecords?[indexPath.row] else {
            print("data 없어요")
            return cell
        }
        
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        let cell = collectionView.cellForItem(at: indexPath) as? MydjCollectionCell
        self.cellDelegate?.collectionView(collectionViewCell: cell, index: indexPath.item, didTappedInTableViewCell: self)
    }

}
