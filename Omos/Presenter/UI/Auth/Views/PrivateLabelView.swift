//
//  PrivateLabelView.swift
//  Omos
//
//  Created by sangheon on 2022/02/12.
//

import UIKit

class PrivateLabelView:BaseView {
    
    let checkButton:UIButton = {
       let button = UIButton()
        button.backgroundColor = .mainOrange
        return button
    }()
    
    let label:UILabel = {
       let label = UILabel()
        label.text = "(필수) 이용약관에 동의합니다"
        return label
    }()
    
    let subButton:UIButton = {
        let button = UIButton()
        button.setTitle("보기", for: .normal)
        button.titleLabel?.textAlignment = .right
        return button
    }()
    
    override func configureUI() {
        self.addSubview(checkButton)
        self.addSubview(label)
        self.addSubview(subButton)
        
        checkButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.width.height.equalTo(12)
        }
        
        subButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
            make.width.greaterThanOrEqualTo(30)
        }
        
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(checkButton.snp.right).offset(10)
        }
        label.sizeToFit()
        
        layoutIfNeeded()
        checkButton.layer.cornerRadius = checkButton.frame.width / 2
        checkButton.layer.masksToBounds = true
    }
}
