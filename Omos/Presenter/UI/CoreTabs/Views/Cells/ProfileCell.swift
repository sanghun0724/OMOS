//
//  ProfileCell.swift
//  Omos
//
//  Created by sangheon on 2022/03/18.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class ProfileCell: UITableViewCell {
    var disposeBag = DisposeBag()
    static let identifier = "ProfileCell"

    let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "아직 스크랩한\n레코드가 없어요"
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()

    let selfViewOne = SquareView()
    let selfViewTwo = SquareView()

    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(selfViewOne)
        self.addSubview(selfViewTwo)
        addSubview(emptyLabel)

        selfViewOne.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(Constant.mainWidth * 0.045)
            make.bottom.lessThanOrEqualToSuperview().offset(12)
            // height
            make.height.equalTo(Constant.mainWidth * 0.44)
            make.width.equalTo(selfViewOne.snp.height)
        }

        selfViewTwo.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(selfViewOne.snp.trailing).offset(Constant.mainWidth * 0.029_9)
            make.trailing.equalToSuperview().offset(-Constant.mainWidth * 0.045)
            make.bottom.lessThanOrEqualToSuperview().offset(12)
            make.height.width.equalTo(selfViewOne).priority(751)
        }

        emptyLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-12)
            emptyLabel.sizeToFit()
        }
//        emptyLabel.isHidden = true
//
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    func configureLike(record: MyProfileRecordResponse) {
        if record.likedRecords.isEmpty {
            self.backgroundColor = .mainBlack
            emptyLabel.text = "아직 공감한\n레코드가 없어요"
            emptyLabel.isHidden = false
            selfViewOne.isHidden = true
            selfViewTwo.isHidden = true
        } else if record.likedRecords.count == 1 {
            self.backgroundColor = .mainBackGround
            emptyLabel.isHidden = true
            selfViewOne.isHidden = false
            selfViewTwo.isHidden = true
            selfViewOne.albumImageView.setImage(with: record.likedRecords[0].music.albumImageURL)
            selfViewOne.backGroundImageView.setImage(with: record.likedRecords[0].recordImageURL ?? "")
            selfViewOne.recordTitleLabel.text = record.likedRecords[0].recordTitle
            selfViewOne.artistTitleLabel.text = record.likedRecords[0].music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)" }
           selfViewOne.trackTitleLabel.text = record.likedRecords[0].music.musicTitle
        } else {
            self.backgroundColor = .mainBackGround
            emptyLabel.isHidden = true
            selfViewOne.isHidden = false
            selfViewTwo.isHidden = false
            selfViewOne.albumImageView.setImage(with: record.likedRecords[0].music.albumImageURL)
            selfViewOne.backGroundImageView.setImage(with: record.likedRecords[0].recordImageURL ?? "")
            selfViewOne.recordTitleLabel.text = record.likedRecords[0].recordTitle
            selfViewOne.artistTitleLabel.text = record.likedRecords[0].music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)" }
            selfViewOne.trackTitleLabel.text = record.likedRecords[0].music.musicTitle

           selfViewTwo.albumImageView.setImage(with: record.likedRecords[1].music.albumImageURL)
            selfViewTwo.backGroundImageView.setImage(with: record.likedRecords[1].recordImageURL ?? "")
            selfViewTwo.recordTitleLabel.text = record.likedRecords[1].recordTitle
            selfViewTwo.artistTitleLabel.text = record.likedRecords[1].music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)" }
            selfViewTwo.trackTitleLabel.text = record.likedRecords[1].music.musicTitle
        }
    }

    func configureScrap(record: MyProfileRecordResponse) {
        if record.scrappedRecords.isEmpty {
            self.backgroundColor = .mainBlack
            emptyLabel.isHidden = false
            selfViewOne.isHidden = true
            selfViewTwo.isHidden = true
        } else if record.scrappedRecords.count == 1 {
            self.backgroundColor = .mainBackGround
            emptyLabel.isHidden = true
            selfViewOne.isHidden = false
            selfViewTwo.isHidden = true
            selfViewOne.albumImageView.setImage(with: record.scrappedRecords[0].music.albumImageURL)
            selfViewOne.backGroundImageView.setImage(with: record.scrappedRecords[0].recordImageURL ?? "")
            selfViewOne.recordTitleLabel.text = record.scrappedRecords[0].recordTitle
            selfViewOne.artistTitleLabel.text = record.scrappedRecords[0].music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)" }
            selfViewOne.trackTitleLabel.text = record.scrappedRecords[0].music.musicTitle
        } else {
            self.backgroundColor = .mainBackGround
            emptyLabel.isHidden = true
            selfViewOne.isHidden = false
            selfViewTwo.isHidden = false
            selfViewOne.albumImageView.setImage(with: record.scrappedRecords[0].music.albumImageURL)
            selfViewOne.backGroundImageView.setImage(with: record.scrappedRecords[0].recordImageURL ?? "")
            selfViewOne.recordTitleLabel.text = record.scrappedRecords[0].recordTitle
            selfViewOne.artistTitleLabel.text = record.scrappedRecords[0].music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)" }
            selfViewOne.trackTitleLabel.text = record.scrappedRecords[0].music.musicTitle

            selfViewTwo.albumImageView.setImage(with: record.scrappedRecords[1].music.albumImageURL)
            selfViewTwo.backGroundImageView.setImage(with: record.scrappedRecords[1].recordImageURL ?? "")
            selfViewTwo.recordTitleLabel.text = record.scrappedRecords[1].recordTitle
            selfViewTwo.artistTitleLabel.text = record.scrappedRecords[1].music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)" }
            selfViewTwo.trackTitleLabel.text = record.scrappedRecords[1].music.musicTitle
    }
}

class ProfileRecordEmptyCell: UITableViewCell {
    static let identifier = "ProfileRecordEmptyCell"

    let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "아직 스크랩한\n레코드가 없어요"
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .white
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .mainBlack
        addSubview(emptyLabel)

        emptyLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-12)
            emptyLabel.sizeToFit()
        }
    }
}

class SquareView: BaseView {
    let baseView: UIView = {
        let view = UIView()
        return view
    }()

    let backGroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "photo2"))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.4
        return imageView
    }()

    let albumImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "photo1"))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let trackTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "dasdasdawdasdwdasdawdwdawd"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .white
        return label
    }()

    let artistTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "dasdasdawdasdwdasdawdwdawd"
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .mainGrey3
        return label
    }()

    let recordTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "dasdasdawdasdwdasdawdwdawd"
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        albumImageView.layer.cornerRadius = albumImageView.height / 2
        albumImageView.layer.masksToBounds = true
    }

    override func configureUI() {
        super.configureUI()
        self.addSubview(baseView)
        baseView.addSubview(backGroundImageView)
        baseView.addSubview(albumImageView)
        baseView.addSubview(trackTitleLabel)
        baseView.addSubview(artistTitleLabel)
        baseView.addSubview(recordTitleLabel)

        baseView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        backGroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        albumImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(12)
            make.width.equalToSuperview().multipliedBy(0.215)
            make.height.equalTo(albumImageView.snp.width)
        }

        trackTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(albumImageView)
            make.trailing.equalToSuperview().offset(-8)
            make.top.equalTo(albumImageView.snp.bottom).offset(8)
            trackTitleLabel.sizeToFit()
        }

        artistTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.top.equalTo(trackTitleLabel.snp.bottom).offset(2)
            artistTitleLabel.sizeToFit()
        }

        recordTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().offset(-12)
            recordTitleLabel.sizeToFit()
        }
    }
}
}
