//
//  AllRecordCollectionCell.swift
//  Omos
//
//  Created by sangheon on 2022/02/15.
//

import RxGesture
import RxSwift
import UIKit
protocol AllRecordCellProtocol: AnyObject {
    func collecCellTap(cate: String)
}

class AllRecordCollectionCell: UICollectionViewCell {
    static let identifier = "AllRecordCollectionCell"
    var disposeBag = DisposeBag()
    weak var delegate: AllRecordCellProtocol?
    var detailInfo: ALine?
    var homeInfo: PopuralResponse?

    let coverView: UIView = {
        let view = UIView()
        return view
    }()

    let backImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "test"))
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .mainBackGround
        imageView.clipsToBounds = true
        imageView.alpha = 0.4
        return imageView
    }()

    let albumImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "albumCover"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let labelCoverView: UIView = {
        let view = UIView()
        view.layer.cornerCurve = .continuous
        view.layer.backgroundColor = UIColor(red: 0.388, green: 0.388, blue: 0.4, alpha: 0.5).cgColor
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "노래제목이 들어갑니다.노래제목이 들어갑니다.노래제목이 들어갑니다."
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .left
        return label
    }()

    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainGrey4
        label.text = "노래제목이 들어갑니다.노래제목이 들어갑니다.노래제목이 들어갑니다."
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .left
        return label
    }()

    let descLabel: UILabel = {
        let label = UILabel()
        label.text = "record main title here..노래제목이 들어갑니다.노래제목이 들어갑니다.노래제목이 들어갑니다.노래제목이 들어갑니다"
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "by. nickname"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()

    private let dummyView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainOrange
        return view
    }()

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        backImageView.image = nil
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
        labelCoverView.layer.cornerRadius = labelCoverView.height / 2
        labelCoverView.layer.masksToBounds = true

        albumImageView.layer.cornerRadius = albumImageView.height / 2
        albumImageView.layer.masksToBounds = true
    }

    func configureModel(record: ALine) {
        self.detailInfo = record
        descLabel.text = record.recordTitle
        albumImageView.setImage(with: record.music.albumImageURL)
        backImageView.setImage(with: record.recordImageURL ?? "")
        nameLabel.text = "by. \(record.nickname)"
        titleLabel.text = record.music.musicTitle
        subTitleLabel.text = record.music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)" } + "- \(record.music.albumTitle)"
        if subTitleLabel.text?.first == " " {
            subTitleLabel.text?.removeFirst()
        }
    }

    func configureHome(record: PopuralResponse) {
        self.homeInfo = record
        descLabel.text = record.recordTitle
        albumImageView.setImage(with: record.music.albumImageURL)
        backImageView.setImage(with: record.recordImageURL) // 바까야함 
        nameLabel.text = "by. \(record.nickname)"
        titleLabel.text = record.music.musicTitle
        subTitleLabel.text = record.music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)" } + "- \(record.music.albumTitle)"
        if subTitleLabel.text?.first == " " {
            subTitleLabel.text?.removeFirst()
        }
    }

   private func configureUI() {
        self.addSubview(coverView)
       coverView.addSubview(backImageView)
       labelCoverView.addSubview(titleLabel)
       labelCoverView.addSubview(albumImageView)
       labelCoverView.addSubview(subTitleLabel)
       coverView.addSubview(labelCoverView)
       coverView.addSubview(descLabel)
       coverView.addSubview(nameLabel)

       coverView.snp.makeConstraints { make in
           make.edges.equalToSuperview()
       }

       backImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

       nameLabel.snp.makeConstraints { make in
           make.leading.trailing.bottom.equalToSuperview().inset(14)
           nameLabel.sizeToFit()
       }

       descLabel.snp.makeConstraints { make in
           make.leading.trailing.equalToSuperview().inset(14)
           make.bottom.equalTo(nameLabel.snp.top).offset(-8)
           descLabel.sizeToFit()
       }

       labelCoverView.snp.makeConstraints { make in
           make.leading.trailing.equalToSuperview().inset(12)
           make.top.equalToSuperview().offset(10)
           make.height.equalTo(44)
       }

       albumImageView.snp.makeConstraints { make in
           make.leading.top.bottom.equalToSuperview()
           make.width.equalTo(albumImageView.snp.height)
       }

       titleLabel.snp.makeConstraints { make in
           make.leading.equalTo(albumImageView.snp.trailing).offset(10)
           make.trailing.equalToSuperview().offset(-6)
           make.top.equalToSuperview().offset(4)
           titleLabel.sizeToFit()
       }

       subTitleLabel.snp.makeConstraints { make in
           make.top.equalTo(titleLabel.snp.bottom).offset(4)
           make.trailing.leading.equalTo(titleLabel)
           make.bottom.equalToSuperview().offset(-6)
           subTitleLabel.sizeToFit()
       }

       layoutIfNeeded()
    }
}
