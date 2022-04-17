//
//  PrivateLabelView.swift
//  Omos
//
//  Created by sangheon on 2022/02/12.
//

import UIKit

class PrivateLabelView: BaseView {
    let checkButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .white
        return button
    }()

    let label: UILabel = {
       let label = UILabel()
        label.attributedText = NSMutableAttributedString()
            .regular(string: "(필수) ", fontSize: 16)
            .orangeHighlight("이용약관")
            .regular(string: "에 동의합니다.", fontSize: 16)
        return label
    }()

    let subButton: UIButton = {
        let button = UIButton()
        button.setTitle("보기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .right
        button.titleLabel?.attributedText = NSMutableAttributedString().underlined("보기")
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
