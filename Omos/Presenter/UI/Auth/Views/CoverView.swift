//
//  CoverView.swift
//  Omos
//
//  Created by sangheon on 2022/04/20.
//

import UIKit

class CoverView: BaseView {
    let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "loginlogo"))
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "로그인"
        label.font = .systemFont(ofSize: 22)
        label.textColor = .mainOrange
        return label
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow-left"), for: .normal)
        return button
    }()
    
    override func configureUI() {
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        self.addSubview(backButton)
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(Constant.mainWidth * 0.170_6)
            make.width.equalTo(Constant.mainWidth * 0.201_5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview()
            titleLabel.sizeToFit()
        }
        
        backButton.snp.makeConstraints { make in
            make.left.top.equalToSuperview().inset(6)
            make.width.height.greaterThanOrEqualTo(18)
        }
    }
}

