//
//  SearchAlbumDetailView.swift
//  Omos
//
//  Created by sangheon on 2022/02/27.
//

import UIKit

class SearchAlbumDetailView: BaseView {
    let tableView: UITableView = {
        let table = UITableView()
        table.register(SearchAlbumDetailCell.self, forCellReuseIdentifier: SearchAlbumDetailCell.identifier)
        table.register(SearchAlbumDetailHeader.self, forHeaderFooterViewReuseIdentifier: SearchAlbumDetailHeader.identifier)
        table.backgroundColor = .mainBackGround
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.automaticallyAdjustsScrollIndicatorInsets = false
        return table
    }()

    override func configureUI() {
        super.configureUI()
        self.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

class SearchAlbumDetailHeader: UITableViewHeaderFooterView {
    static let identifier = "SearchAlbumDetailHeader"

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "앨범 제목이 들어갑니다"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()

    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "가수이름이 들어갑니다"
        label.textColor = .mainGrey4
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()

    let createdLabel: UILabel = {
        let label = UILabel()
        label.text = "발매일 언제언제언제"
        label.textColor = .mainGrey4
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()

    let albumImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "albumSquare"))
        view.contentMode = .scaleAspectFill
        return view
    }()

    let decoImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "albumSquare"))
        view.contentMode = .scaleAspectFill
        return view
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()

        layoutIfNeeded()
        albumImageView.layer.cornerRadius = 4
        albumImageView.layer.masksToBounds = true

        decoImageView.layer.cornerRadius = decoImageView.height / 2
        decoImageView.layer.masksToBounds = true
    }

    func configureUI() {
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
        self.addSubview(createdLabel)
        self.addSubview(albumImageView)
        self.addSubview(decoImageView)

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.centerX.equalToSuperview()
            titleLabel.sizeToFit()
        }

        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            subTitleLabel.sizeToFit()
        }

        createdLabel.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
            createdLabel.sizeToFit()
        }

        albumImageView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.548)
            make.width.equalTo(albumImageView.snp.height)
            make.centerX.equalToSuperview()
            make.top.equalTo(createdLabel.snp.bottom).offset(14)
        }

        decoImageView.snp.makeConstraints { make in
            make.height.equalTo(albumImageView).multipliedBy(0.466)
            make.width.equalTo(decoImageView.snp.height)
            make.centerX.equalTo(albumImageView.snp.trailing).multipliedBy(0.94)
            make.centerY.equalTo(albumImageView.snp.bottom).multipliedBy(0.94)
        }
    }
}
