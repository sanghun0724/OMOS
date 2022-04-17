//
//  ArtistTableCell.swift
//  Omos
//
//  Created by sangheon on 2022/02/27.
//

import Foundation
import UIKit

class ArtistTableCell: UITableViewCell {
    static let identifier = "ArtistTableCell"

    let songImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "albumCover"))
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
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

    override func layoutSubviews() {
        super.layoutSubviews()
        confgirueUI()

        layoutIfNeeded()
        songImageView.layer.cornerCurve = .circular
        songImageView.layer.cornerRadius = songImageView.height / 2
        songImageView.layer.masksToBounds = true
    }

    func confgirueUI() {
        self.addSubview(songImageView)
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)

        songImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.height.equalToSuperview()
            make.width.equalTo(songImageView.snp.height)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(songImageView.snp.trailing).offset(14)
            make.trailing.equalToSuperview().offset(-14)
            make.centerY.equalToSuperview().multipliedBy(0.75)
        }

        subTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.centerY.equalToSuperview().multipliedBy(1.25)
        }
    }

    func configureModel(artist: ArtistRespone, keyword: String) {
        titleLabel.text = artist.artistName
        subTitleLabel.text = artist.genres.reduce("") { $0 + " \($1)" }
//        if subTitleLabel.text?.first == " " {
//            subTitleLabel.text?.removeFirst()
//        }
        titleLabel.asColor(targetString: keyword, color: .mainOrange)
        subTitleLabel.asColor(targetString: keyword, color: .mainOrange)
        guard let url = artist.artistImageURL else {
            songImageView.image = UIImage(named: "albumCover")
            return
        }
        songImageView.setImage(with: url)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        songImageView.image = nil
        titleLabel.text = nil
        subTitleLabel.text = nil
    }
}
