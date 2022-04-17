//
//  SearchAlbumDetailCell.swift
//  Omos
//
//  Created by sangheon on 2022/02/27.
//

import Foundation
import RxSwift
import UIKit

class SearchAlbumDetailCell: UITableViewCell {
    static let identifier = "SearchAlbumDetailCell"
    var disposeBag = DisposeBag()

    let countLabel: UILabel = {
        let label = UILabel()
        label.text = "01"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "상수역"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "검정 치마"
        label.textColor = .mainGrey4
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()

    let createdButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "edit"), for: .normal)
        return button
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        confgirueUI()
    }

    func confgirueUI() {
        self.backgroundColor = .mainBackGround
        self.addSubview(countLabel)
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
        self.addSubview(createdButton)

        countLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.width.equalTo(20)
        }

        createdButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalTo(createdButton.snp.height)
        }

        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(countLabel)
            make.leading.equalTo(countLabel.snp.trailing).offset(12)
            make.trailing.equalTo(createdButton.snp.leading).offset(-12)
            titleLabel.sizeToFit()
        }

        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.trailing.equalTo(titleLabel)
            subTitleLabel.sizeToFit()
        }
    }

    func configureModel(albumDetail: AlbumDetailRespone, count: Int) {
        titleLabel.text = albumDetail.musicTitle
        subTitleLabel.text = albumDetail.artists.map { $0.artistName }.reduce("") { $0 + " \($1)" }
        countLabel.text = count < 10 ? "0\(count)" : "\(count)"
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subTitleLabel.text = nil
        disposeBag = DisposeBag()
    }
}
