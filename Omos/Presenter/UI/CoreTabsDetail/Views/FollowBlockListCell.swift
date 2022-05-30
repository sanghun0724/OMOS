//
//  FollowListCell.swift
//  Omos
//
//  Created by sangheon on 2022/05/27.
//

import UIKit

class FollowBlockListCell: UITableViewCell {
    static let identifier = "FollowBlockListCell"
    
    let profileImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "defaultprofile"))
        return view
    }()
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.text = "닉네임 입니다열두자"
        label.textColor = .white
        return label
    }()
    
    let listButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    
    private func configureUI() {
        addSubview(profileImageView)
        addSubview(nicknameLabel)
        addSubview(listButton)
        
        profileImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(16)
            make.width.equalTo(profileImageView.snp.height)
        }
        
        listButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(Constant.mainWidth * 0.23).priority(999)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(listButton.snp.width).multipliedBy(0.38)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(14)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(listButton.snp.leading).offset(-16)
        }
    }
}

