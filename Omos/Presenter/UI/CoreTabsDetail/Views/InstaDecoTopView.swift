//
//  InstaDecoView.swift
//  Omos
//
//  Created by sangheon on 2022/04/20.
//

import UIKit

class InstaDecoTopView: BaseView {
    let logoImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "logo"))
        view.contentMode = .scaleAspectFill
        return view
    }()

    override func configureUI() {
        self.backgroundColor = .mainBackGround
        self.addSubview(logoImageView)

        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.width.equalToSuperview().multipliedBy(0.230)
            make.height.equalTo(logoImageView.snp.width).multipliedBy(0.208)
        }
    }
}
