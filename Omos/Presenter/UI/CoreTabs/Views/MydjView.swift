//
//  MydjView.swift
//  Omos
//
//  Created by sangheon on 2022/02/24.
//

import Foundation
import UIKit

class MydjView: BaseView {
    let cellSize = UIScreen.main.bounds.width * 0.21

    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    let tableView: UITableView = {
        let table = UITableView()
        table.register(AllRecordCateShortDetailCell.self, forCellReuseIdentifier: AllRecordCateShortDetailCell.identifier)
        table.register(AllRecordCateLongDetailCell.self, forCellReuseIdentifier: AllRecordCateLongDetailCell.identifier)
        table.register(AllrecordLyricsTableCell.self, forCellReuseIdentifier: AllrecordLyricsTableCell.identifier)
        table.register(LoadingCell.self, forCellReuseIdentifier: LoadingCell.identifier)
        table.estimatedRowHeight = 500
        table.backgroundColor = .mainBackGround
        table.showsVerticalScrollIndicator = false
        table.automaticallyAdjustsScrollIndicatorInsets = false
        return table
    }()

    let loadingView = LoadingView()
    let emptyView = EmptyView()

    override func configureUI() {
        super.configureUI()
        addSubview(tableView)
        setUpCollection()
        addSubview(emptyView)
        addSubview(loadingView)
        emptyView.isHidden = true
        loadingView.isHidden = true

        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(cellSize + 6)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }

        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        emptyView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        emptyView.descriptionLabel.text = "구독한 DJ 레코드가 없습니다."
        loadingView.backgroundColor = .mainBackGround
    }

    func setUpCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: cellSize, height: cellSize) // 비율정해서 설정하기
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 6
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MydjCollectionCell.self, forCellWithReuseIdentifier: MydjCollectionCell.identifier)
        collectionView.register(EmptyCell.self, forCellWithReuseIdentifier: EmptyCell.identifier)
        self.addSubview(collectionView)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .mainBackGround
    }
}
