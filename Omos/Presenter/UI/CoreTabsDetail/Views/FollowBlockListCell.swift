//
//  FollowListCell.swift
//  Omos
//
//  Created by sangheon on 2022/05/27.
//

import RxSwift
import UIKit

class FollowBlockListCell: UITableViewCell {
    static let identifier = "FollowBlockListCell"
    var disposeBag = DisposeBag()
    
    let profileImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "defaultprofile"))
        view.backgroundColor = .mainBackGround
        view.layer.masksToBounds = true
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
        button.backgroundColor = .mainOrange
        button.setTitle("삭제", for: .normal)
        button.layer.masksToBounds = true
        button.clipsToBounds = true
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
        backgroundColor = .mainBackGround
        
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
        
        profileImageView.layoutIfNeeded()
        profileImageView.layer.cornerRadius = profileImageView.height / 2
        
        listButton.layoutIfNeeded()
        listButton.layer.cornerRadius = (listButton.height / 2) - 2
    }
    
    func configure(data: ListResponse) {
        profileImageView.download(url: data.profileURL)
        nicknameLabel.text = data.nickname
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = .init()
    }
}

