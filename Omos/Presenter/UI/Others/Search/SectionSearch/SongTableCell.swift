//
//  SongTableCell.swift
//  Omos
//
//  Created by sangheon on 2022/02/27.
//

import Foundation
import UIKit


class SongTableCell:UITableViewCell {
    static let identifier = "SongTableCell"
    
    
    let songImageView:UIImageView = {
        let view = UIImageView(image:UIImage(named: "albumCover"))
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.text = "상수역"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    let subTitleLabel:UILabel = {
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
            make.height.equalToSuperview().multipliedBy(0.571)
            make.width.equalTo(songImageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(songImageView.snp.trailing).offset(14)
            make.centerY.equalToSuperview().multipliedBy(0.75)
            titleLabel.sizeToFit()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(titleLabel)
            make.centerY.equalToSuperview().multipliedBy(1.25)
            subTitleLabel.sizeToFit()
        }
        
    }
}
