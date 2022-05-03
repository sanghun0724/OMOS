//
//  AccountOutView.swift
//  Omos
//
//  Created by sangheon on 2022/04/20.
//

import UIKit

class AccountOutView: BaseView {
    let topLabel: UILabel = {
        let label = UILabel()
        label.text = "OOO님과 \n이별인가요? 너무 아쉬워요... "
        label.textColor = .mainOrange
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 2
        return label
    }()

    let bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "계정을 삭제하면 MY 레코드, 공감, 스크랩 등 모든 활동\n정보가 삭제됩니다. 다음에 다시 만날 수 있길 바라요!"
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 2
        return label
    }()

    let buttonView: UIButton = {
       let button = UIButton()
        button.backgroundColor = .mainGrey4
        button.setTitle("탈퇴하기", for: .normal)
        button.setTitleColor(.mainGrey7, for: .normal)
        return button
    }()

    override func configureUI() {
        super.configureUI()
        self.addSubview(topLabel)
        self.addSubview(bottomLabel)
        self.addSubview(buttonView)

        topLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(24)
            topLabel.sizeToFit()
        }

        bottomLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(topLabel.snp.bottom).offset(16)
            bottomLabel.sizeToFit()
        }

        buttonView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(bottomLabel)
            make.height.equalToSuperview().multipliedBy(0.07)
            make.bottom.equalToSuperview().offset(-34)
        }
    }
}

