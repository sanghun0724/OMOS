//
//  AllRecoredTableCell.swift
//  Omos
//
//  Created by sangheon on 2022/02/07.
//

import Foundation
import UIKit

protocol AllCollectCellprotocol:AnyObject {
    func collectionView(collectionViewCell:AllRecordCollectionCell?,index:Int,didTappedInTableViewCell:AllRecordTableCell)
}

class AllRecordTableCell:UITableViewCell {
    static let identifier = "AllRecordTableCell"
    
    var selectedRecords:[ALine]? {
        didSet {
            collectionView.reloadData()
        }
    }
    weak var cellDelegate: AllCollectCellprotocol?
    private var collectionView:UICollectionView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setCollectionView()
    }
    
    private func setCollectionView() {
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
        contentView.addSubview(collectionView)
        collectionView.showsHorizontalScrollIndicator = false
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

extension AllRecordTableCell: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.selectedRecords?.count ?? 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllRecordCollectionCell.identifier, for: indexPath) as! AllRecordCollectionCell
        guard let data = self.selectedRecords?[indexPath.row] else {
            print("data 없어요")
            return AllRecordCollectionCell()
        }
        
        cell.configureModel(record: data)
        cell.backgroundColor = .mainBlack
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        let cell = collectionView.cellForItem(at: indexPath) as? AllRecordCollectionCell
        self.cellDelegate?.collectionView(collectionViewCell: cell, index: indexPath.item, didTappedInTableViewCell: self)
    }

}
