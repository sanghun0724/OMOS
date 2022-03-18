//
//  ProfileCell.swift
//  Omos
//
//  Created by sangheon on 2022/03/18.
//

import Foundation
import UIKit

class ProfileCell:UITableViewCell {
    static let identifier = "ProfileCell"
    
    let selfViewOne = SquareView()
    let selfViewTwo = SquareView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(selfViewOne)
        self.addSubview(selfViewTwo)
        
        selfViewOne.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(Constant.mainWidth * 0.045)
            make.bottom.lessThanOrEqualToSuperview().offset(12)
            //height
            make.height.equalTo(Constant.mainWidth * 0.44)
            make.width.equalTo(selfViewOne.snp.height)
        }
        
        selfViewTwo.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(selfViewOne.snp.trailing).offset(Constant.mainWidth * 0.0299)
            make.trailing.equalToSuperview().offset(-Constant.mainWidth * 0.045)
            make.bottom.lessThanOrEqualToSuperview().offset(12)
            make.height.width.equalTo(selfViewOne).priority(751)
        }
        
    }
    
    
}




class SquareView:BaseView {
    
    let baseView:UIView = {
        let view = UIView()
        return view
    }()
    
    let backGroundImageView:UIImageView = {
        let imageView = UIImageView(image:UIImage(named: "photo2"))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let albumImageView:UIImageView = {
        let imageView = UIImageView(image:UIImage(named: "photo1"))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let trackTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "dasdasdawdasdwdasdawdwdawd"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    let artistTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "dasdasdawdasdwdasdawdwdawd"
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .mainGrey3
        return label
    }()
    
    let recordTitleLabel:UILabel = {
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
        self.addSubview(backGroundImageView)
        backGroundImageView.addSubview(albumImageView)
        backGroundImageView.addSubview(trackTitleLabel)
        backGroundImageView.addSubview(artistTitleLabel)
        backGroundImageView.addSubview(recordTitleLabel)
        
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
