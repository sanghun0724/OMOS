//
//  BaseView.swift
//  Omos
//
//  Created by sangheon on 2022/02/06.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureUI() {
        self.backgroundColor = .mainBackGround
    }
}
