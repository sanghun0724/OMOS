//
//  MydjProfileView.swift
//  Omos
//
//  Created by sangheon on 2022/02/27.
//

import Foundation
import UIKit
import RxSwift

class MydjProfieView:BaseView {
    
    let tableView:UITableView = {
       let table = UITableView()
        table.register(MyRecordTableCell.self, forCellReuseIdentifier: MyRecordTableCell.identifier)
        table.register(MydjProfileHeader.self, forHeaderFooterViewReuseIdentifier: MydjProfileHeader.identifier)
        table.backgroundColor = .mainBackGround
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.automaticallyAdjustsScrollIndicatorInsets = false
       return table
    }()
    
    let loadingView = LoadingView()
        
    override func configureUI() {
        self.addSubview(tableView)
        self.addSubview(loadingView)
        
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingView.isHidden = true
    }
    
}


class MydjProfileHeader:UITableViewHeaderFooterView {
    static let identifier = "MydjProfileHeader"
    var disposeBag = DisposeBag()
        
    let profileImageView:UIImageView = {
        let view = UIImageView(image:UIImage(named: "albumCover"))
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let djLabel:UILabel = {
        let label = UILabel()
        label.text = "DJ"
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    let profileLabel:UILabel = {
       let label = UILabel()
        label.text = "닉네임두자닉네임두자닉네임두자"
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.textAlignment = .left
        return label
    }()
    
    let followButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .mainOrange
        button.setTitle("팔로우", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.borderColor = UIColor.mainGrey4.cgColor
        return button
    }()
    
    let recordTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "레코드"
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    let recordCountLabel:UILabel = {
        let label = UILabel()
        label.text = "0000억"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    let followerTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "팔로워"
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    let followerCountLabel:UILabel = {
        let label = UILabel()
        label.text = "0000억"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    let followingTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "팔로잉"
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    let followingCountLabel:UILabel = {
        let label = UILabel()
        label.text = "0000억"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    let settingButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "setting"), for: .normal)
        return button
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
        layoutIfNeeded()
        profileImageView.layer.cornerCurve = .circular
        profileImageView.layer.cornerRadius = profileImageView.height / 2
        profileImageView.layer.masksToBounds = true
        
        followButton.layer.cornerCurve = .continuous
        followButton.layer.cornerRadius = 10
        followButton.layer.masksToBounds = true
        
        let distance = ((followingTitleLabel.frame.minX - recordTitleLabel.frame.maxX) - recordTitleLabel.width) / 2
        
        followerTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(recordTitleLabel.snp.trailing).offset(distance)
            make.centerY.equalTo(recordTitleLabel)
            followerTitleLabel.sizeToFit()
        }
        
        followerCountLabel.snp.makeConstraints { make in
            make.centerX.equalTo(followerTitleLabel)
            make.top.equalTo(followerTitleLabel.snp.bottom).offset(2)
            followerCountLabel.sizeToFit()
        }
        
    }
    
    func configureUI() {
        plusSubViews()
        
        djLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
            make.top.equalToSuperview().offset(8)
            djLabel.sizeToFit()
        }
        
        followButton.snp.makeConstraints { make in
            make.centerY.equalTo(djLabel)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalToSuperview().multipliedBy(0.192)
            make.height.equalTo(followButton.snp.width).multipliedBy(0.35)
        }
        
        profileLabel.snp.makeConstraints { make in
            make.centerY.equalTo(djLabel)
            make.leading.equalTo(djLabel.snp.trailing).offset(6)
            profileLabel.sizeToFit()
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(djLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalTo(profileImageView.snp.width)
        }
        
        recordTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView).multipliedBy(0.8)
            make.leading.equalTo(profileImageView.snp.trailing).offset(34)
            recordTitleLabel.sizeToFit()
        }
        
        recordCountLabel.snp.makeConstraints { make in
            make.centerX.equalTo(recordTitleLabel)
            make.top.equalTo(recordTitleLabel.snp.bottom).offset(2)
            recordCountLabel.sizeToFit()
        }
        
        followingTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(recordTitleLabel)
            make.trailing.equalToSuperview().offset(-34)
            followingTitleLabel.sizeToFit()
        }
        
        followingCountLabel.snp.makeConstraints { make in
            make.centerX.equalTo(followingTitleLabel)
            make.top.equalTo(followingTitleLabel.snp.bottom).offset(2)
            followingCountLabel.sizeToFit()
        }
        
        settingButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.trailing.equalToSuperview().offset(-12)
            make.width.equalToSuperview().multipliedBy(0.065)
            make.height.equalTo(settingButton.snp.width)
        }
        
    }
    
    func plusSubViews() {
        self.addSubview(djLabel)
        self.addSubview(profileImageView)
        self.addSubview(profileLabel)
        self.addSubview(followButton)
        self.addSubview(recordTitleLabel)
        self.addSubview(recordCountLabel)
        self.addSubview(followerTitleLabel)
        self.addSubview(followerCountLabel)
        self.addSubview(followingTitleLabel)
        self.addSubview(followingCountLabel)
        self.addSubview(settingButton)
    }
    
    func configureModel(profile:MyDjProfileResponse) {
        profileLabel.text = profile.profile.nickName
        profileImageView.setImage(with: profile.profile.profileURL ?? "")
        followerCountLabel.text = "\(profile.count.followerCount)"
        followingCountLabel.text = "\(profile.count.followingCount)"
        recordCountLabel.text = "\(profile.count.recordsCount)"
        
        if profile.isFollowed {
            followButton.setTitle("팔로잉", for:  .normal)
            followButton.backgroundColor = .clear
            followButton.setTitleColor(.mainGrey4, for: .normal)
            followButton.layer.borderWidth = 1
        }
    }
    
}
