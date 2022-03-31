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
    
    let baseView:UIView = {
        let view = UIView()
        return view
    }()
    
    let backImageView:UIImageView = {
        let imageView = UIImageView(image:UIImage(named: "photo2"))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.4
        return imageView
    }()
    
    let albumImageView:UIImageView = {
        let imageView = UIImageView(image:UIImage(named: "albumCover"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
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
        
        layoutIfNeeded()
        
        albumImageView.layer.cornerRadius = albumImageView.height / 2
        albumImageView.layer.masksToBounds = true
        
    }
    
    func configureUI() {
        self.addSubview(baseView)
        baseView.addSubview(backImageView)
        baseView.addSubview(albumImageView)
        baseView.addSubview(trackTitleLabel)
        baseView.addSubview(artistTitleLabel)
        baseView.addSubview(albumTitleLabel)
        baseView.addSubview(albumLabelImageView)
        baseView.addSubview(decoView)
        decoView.addSubview(arrowButton)
        
        baseView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
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
    
    func configureModel(record:LovedResponse) {
        backImageView.setImage(with: record.music.albumImageURL) //바꿔야함
        albumImageView.setImage(with: record.music.albumImageURL)
        trackTitleLabel.text = record.music.musicTitle
        artistTitleLabel.text = record.music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)"}
        albumTitleLabel.text = record.music.albumTitle
    }
    
}


class LovedEmptyCell:UITableViewCell {
    static let identifier = "LovedEmptyCell"
    
    let label:UILabel = {
        let label = UILabel()
        label.text = "당신이 사랑하는 노래를\n 기록하러 가실래요?"
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    let decoLabel:UILabel = {
        let label = UILabel()
        label.text = "MY 레코드 기록하러 가기"
        label.textColor = .mainOrange
        return label
    }()
    
    let decoImageView:UIImageView = {
        let imageView = UIImageView(image:UIImage(named: "orangeright"))
        imageView.tintColor = .mainOrange
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    
    func configureUI() {
        self.addSubview(label)
        self.addSubview(decoLabel)
        self.addSubview(decoImageView)
        
        label.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(16)
            label.sizeToFit()
        }
        
        decoLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(label.snp.bottom).offset(16)
        }
        
        decoImageView.snp.makeConstraints { make in
            make.leading.equalTo(decoLabel.snp.trailing).offset(6)
            make.top.equalTo(decoLabel)
            make.height.width.equalTo(16)
        }
    }
}
