//
//  MydjCollectionCell.swift
//  Omos
//
//  Created by sangheon on 2022/02/24.
//

import Kingfisher
import RxCocoa
import RxGesture
import RxSwift
import UIKit

class MydjCollectionCell: UICollectionViewCell {
    static let identifier = "MydjCollectionCell"

    var disposeBag = DisposeBag()
    var homeInfo: recommendDjResponse?

    let djImageView: UIImageView = {
       let imageView = UIImageView(image: UIImage(named: "albumCover"))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 0
        imageView.layer.borderColor = UIColor.mainOrange.cgColor
        return imageView
    }()

    let djLabel: UILabel = {
        let label = UILabel()
        label.text = "myDJ"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()

        layoutIfNeeded()
        djImageView.layer.cornerCurve = .circular
        djImageView.layer.cornerRadius = djImageView.height / 2
        djImageView.layer.masksToBounds = true
    }

    override func prepareForReuse() {
        djImageView.image = nil
        disposeBag = DisposeBag()
        super.prepareForReuse()
    }

    private func configureUI() {
        self.addSubview(djImageView)
        self.addSubview(djLabel)
        djLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.18)
        }

        djImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.bottom.equalTo(djLabel.snp.top)
            make.width.equalTo(djImageView.snp.height)
            make.centerX.equalToSuperview()
        }
    }

    func configureModel(record: MyDjListResponse) {
        djLabel.text = record.nickname
        guard let imageUrl = record.profileURL else {
            djImageView.image = UIImage(named: "albumCover")
            return
        }
        if ImageCache.default.isCached(forKey: imageUrl) {
                      print("Image is cached")
                      ImageCache.default.removeImage(forKey: imageUrl)
             }
        if imageUrl == "" {
            djImageView.image = UIImage(named: "albumCover")
        } else {
            djImageView.setImage(with: imageUrl)
        }
    }

    func configureHome(record: recommendDjResponse) {
        djImageView.image = nil
        self.homeInfo = record
        djLabel.text = record.nickname
        if let imageUrl = record.profileURL {
            if ImageCache.default.isCached(forKey: imageUrl) {
                          print("Image is cached")
                          ImageCache.default.removeImage(forKey: imageUrl)
                 }
            if imageUrl == "" {
                djImageView.image = UIImage(named: "albumCover")
            } else {
                djImageView.setImage(with: imageUrl)
            }

            return
        } else {
            djImageView.image = UIImage(named: "albumCover")
        }
    }
}
