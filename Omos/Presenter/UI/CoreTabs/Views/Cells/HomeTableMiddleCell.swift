//
//  HomeTableCell.swift
//  Omos
//
//  Created by sangheon on 2022/03/11.
//


import Kingfisher
import UIKit
import Foundation

protocol HomeTableMiddleCellprotocol: AnyObject {
    func collectionView(collectionViewCell: MydjCollectionCell?, index: Int, didTappedInTableViewCell: HomeTableMiddleCell)
}

class HomeTableMiddleCell: UITableViewCell {
    static let identifier = "HomeTableMiddleCell"
    
    var selectedRecords: [RecommendDjResponse]? {
        didSet {
            collectionView.reloadData()
        }
    }
    weak var cellDelegate: HomeTableMiddleCellprotocol?
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCollection()
        collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal// Constant.mainWidth * 0.5
        layout.itemSize = CGSize(width: Constant.mainHeight * 0.145, height: Constant.mainHeight * 0.145) // 비율정해서 설정하기
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 6
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MydjCollectionCell.self, forCellWithReuseIdentifier: MydjCollectionCell.identifier)
        collectionView.register(EmptyCell.self, forCellWithReuseIdentifier: EmptyCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .mainBackGround
        self.contentView.addSubview(collectionView)
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    func configureModel(records: [RecommendDjResponse]) {
        self.selectedRecords = records
        print(records)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetCollectionView()
    }
    
    private func resetCollectionView() {
        guard !(selectedRecords?.isEmpty ?? true) else { return }
        selectedRecords = []
        collectionView.reloadData()
    }
}

extension HomeTableMiddleCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.selectedRecords?.count ?? 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MydjCollectionCell.identifier, for: indexPath) as! MydjCollectionCell
        guard let data = self.selectedRecords?[safe:indexPath.item] else {
            print("data 없어요")
            return cell
        }
        cell.configureHome(record: data)
        cell.reloadInputViews()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        let cell = collectionView.cellForItem(at: indexPath) as? MydjCollectionCell
        self.cellDelegate?.collectionView(collectionViewCell: cell, index: indexPath.item, didTappedInTableViewCell: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
}
