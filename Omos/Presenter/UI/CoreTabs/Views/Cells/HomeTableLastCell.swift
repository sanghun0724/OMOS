//
//  HomeTableLastCell.swift
//  Omos
//
//  Created by sangheon on 2022/03/11.
//

import Foundation
import UIKit

class HomeTableLastCell:UITableViewCell {
    static let identifier = "HomeTableLastCell"
    
    let backImageView:UIImageView = {
        let imageView = UIImageView(image:UIImage(named: "photo2"))
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let albumImageView:UIImageView = {
        let imageView = UIImageView(image:UIImage(named: "albumCover"))
        return imageView
    }()
    
    let trackTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "노래 재목이 들어갑니다."
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    let artistTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "가수 이름이 들어갑니다"
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    let albumTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "앨범 제목이 들어갑니다."
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    let albumLabelImageView:UIImageView = {
        let view = UIImageView(image:UIImage(named: "disc"))
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let decoView:UIView = {
       let view = UIView()
        view.backgroundColor = .mainBlack
        view.alpha = 0.92
        return view
    }()
    
    let arrowButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "keyboard_arrow_left"), for: .normal)
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
        
    }
    
    func configureUI() {
        self.addSubview(backImageView)
        backImageView.addSubview(albumImageView)
        backImageView.addSubview(trackTitleLabel)
        backImageView.addSubview(artistTitleLabel)
        backImageView.addSubview(albumTitleLabel)
        backImageView.addSubview(albumLabelImageView)
        backImageView.addSubview(decoView)
        decoView.addSubview(arrowButton)
        
        backImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        albumImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(14)
            make.height.equalToSuperview().multipliedBy(0.396)
            make.width.equalTo(albumImageView.snp.height)
        }
        
        trackTitleLabel.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(albumImageView.snp.bottom).offset(14)
            make.leading.equalTo(albumImageView)
            make.trailing.equalToSuperview().offset(-16)
            trackTitleLabel.sizeToFit()
        }
        
        artistTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(trackTitleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalTo(trackTitleLabel)
            artistTitleLabel.sizeToFit()
        }
        
        albumLabelImageView.snp.makeConstraints { make in
            make.height.width.equalTo(artistTitleLabel.snp.height)
            make.leading.equalTo(artistTitleLabel)
            make.top.equalTo(artistTitleLabel.snp.bottom).offset(4)
        }
        
        albumTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(albumLabelImageView.snp.trailing).offset(4)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(albumLabelImageView)
            albumTitleLabel.sizeToFit()
        }
        
        decoView.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.15)
        }
        
        arrowButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalTo(arrowButton.snp.width)
            make.center.equalToSuperview()
        }
        
    }
    
}
