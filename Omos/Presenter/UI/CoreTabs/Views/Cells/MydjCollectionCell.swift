//
//  MydjCollectionCell.swift
//  Omos
//
//  Created by sangheon on 2022/02/24.
//

import Foundation
import UIKit

class MydjCollectionCell:UICollectionViewCell {
    static let identifier = "MydjCollectionCell"
    
    
    let djImageView:UIImageView = {
       let imageView = UIImageView(image: UIImage(named: "albumCover"))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let djLabel:UILabel = {
        let label = UILabel()
        label.text = "myDJ"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(djImageView)
        contentView.addSubview(djLabel)
        configureUI()
        
        layoutIfNeeded()
        djImageView.layer.cornerCurve = .circular
        djImageView.layer.cornerRadius = djImageView.height / 2
        djImageView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //djImageView.image = nil
    }
    
    private func configureUI() {
        
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
    
    
}
