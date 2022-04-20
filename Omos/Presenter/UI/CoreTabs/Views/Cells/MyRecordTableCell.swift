//
//  MyRecordCell.swift
//  Omos
//
//  Created by sangheon on 2022/02/15.
//

import Foundation
import UIKit

class MyRecordTableCell: UITableViewCell {
    static let identifier = "MyRecordTableCell"

    private let backCoverView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlack
        return view
    }()

    let albumImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "albumCover"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let backGroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBackGround
        return view
    }()

    private let labelCoverView: UIView = {
        let view = UIView()
        view.layer.cornerCurve = .continuous
        view.layer.backgroundColor = UIColor(red: 0.388, green: 0.388, blue: 0.4, alpha: 0.5).cgColor
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainGrey1
        label.textAlignment = .left
        label.text = "노래제목이 들어갑니다.노래제목이 들어갑니다.노래제목이 들어갑니다."
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()

    let artistLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainGrey4
        label.textAlignment = .left
        label.text = "가수"
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    let recordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "노래제목이 들어갑니다.노래제목이 들어갑니다.노래제목이 들어갑니다."
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textAlignment = .left
        return label
    }()

    let descLabel: UILabel = {
        let label = UILabel()
        label.text = "record main title here..노래제목이 들어갑니다.노래제목이 들어갑니다.노래제목이 들어갑니다.노래제목이 들어갑니다"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .light)
//        label.textAlignment = .left
        label.textColor = .mainGrey3
        label.contentMode = .bottomLeft
        return label
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainGrey6
        label.text = "2022 00 00 카테코리가 들어갑니다"
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .left
        return label
    }()

    let lockImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "lock"))
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.backgroundColor = .mainBackGround
        configureUI()

        albumImageView.layer.cornerRadius = albumImageView.width / 2
        albumImageView.layer.masksToBounds = true

        labelCoverView.layer.cornerRadius = labelCoverView.height / 2
        labelCoverView.layer.masksToBounds = true
    }

    private func configureUI() {
        self.contentView.addSubview(backCoverView)
        backCoverView.addSubview(albumImageView)
        backCoverView.addSubview(backGroundView)
        backGroundView.addSubview(recordLabel)
        backGroundView.addSubview(labelCoverView)
        backGroundView.addSubview(titleLabel)
        backGroundView.addSubview(artistLabel)
        backGroundView.addSubview(descLabel)
        backGroundView.addSubview(nameLabel)
        backCoverView.addSubview(lockImageView)

        backCoverView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }

        albumImageView.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.64)
            make.width.equalTo(albumImageView.snp.height)
        }

        backGroundView.snp.makeConstraints { make in
            make.left.equalTo(albumImageView.snp.centerX).multipliedBy(1.5)
            make.right.bottom.top.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            titleLabel.sizeToFit()
        }
        titleLabel.layoutIfNeeded()

        artistLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(titleLabel.snp.trailing).offset(2)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalTo(titleLabel)
            artistLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        }
        artistLabel.layoutIfNeeded()

        recordLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        recordLabel.sizeToFit()

        nameLabel.snp.makeConstraints { make in
            make.left.right.equalTo(recordLabel)
            make.bottom.equalToSuperview()
            nameLabel.sizeToFit()
        }
        nameLabel.layoutIfNeeded()

        descLabel.snp.makeConstraints { make in
            make.bottom.equalTo(nameLabel.snp.top).offset(-10)
            make.left.right.equalTo(recordLabel)
            make.top.equalTo(recordLabel.snp.bottom).offset(10)
            descLabel.sizeToFit()
        }
        descLabel.layoutIfNeeded()

        lockImageView.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview()
        }
        lockImageView.sizeToFit()

//        layoutIfNeeded()

        let wholeWidth = titleLabel.intrinsicContentSize.width + artistLabel.intrinsicContentSize.width + 16
        if wholeWidth < backGroundView.width {
            labelCoverView.snp.remakeConstraints { make in
                make.leading.equalToSuperview().offset(8)
                make.centerY.equalTo(titleLabel)
                make.height.equalTo(titleLabel.height + 12)
                make.width.equalTo(wholeWidth)
            }
        } else {
            labelCoverView.snp.remakeConstraints { make in
                make.leading.equalToSuperview().offset(8)
                make.centerY.equalTo(titleLabel)
                make.height.equalTo(titleLabel.height + 12)
                make.trailing.equalToSuperview()
            }
        }

        labelCoverView.layoutIfNeeded()
    }

    func configureModel(record: MyRecordRespone) {
        albumImageView.setImage(with: record.music.albumImageURL)
        titleLabel.text = record.music.musicTitle
        artistLabel.text = record.music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)" }
        recordLabel.text = record.recordTitle
        descLabel.text = record.recordContents
        nameLabel.text = record.createdDate.toDate() + " | " + record.category.getReverseCate()
        record.isPublic ? (lockImageView.image = UIImage(named: "unlock")) : (lockImageView.image = UIImage(named: "lock"))
    }

    func configureUserRecordModel(record: MyRecordRespone) {
        lockImageView.isHidden = true
        albumImageView.setImage(with: record.music.albumImageURL)
        titleLabel.text = record.music.musicTitle
        artistLabel.text = record.music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)" }
        recordLabel.text = record.recordTitle
        descLabel.text = record.recordContents
        nameLabel.text = record.createdDate.toDate() + " | " + record.category.getReverseCate()
       // record.isPublic ? (lockImageView.image = UIImage(named:"unlock")) : (lockImageView.image = UIImage(named:"lock"))
    }
}
