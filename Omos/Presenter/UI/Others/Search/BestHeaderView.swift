//
//  BestHeaderView.swift
//  Omos
//
//  Created by sangheon on 2022/04/20.
//

import UIKit

class BestHeaderView: UITableViewHeaderFooterView {
    static let identtifier = "BestHeaderView"

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "인기검색어"
        label.textColor = .mainGrey1
        label.font = .systemFont(ofSize: 18)
        return label
    }()

    let subLabel: UILabel = {
        let label = UILabel()
        label.text = "전일기준"
        label.textColor = .mainGrey6
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }

    private func configureUI() {
        self.addSubview(titleLabel)
        self.addSubview(subLabel)

        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            titleLabel.sizeToFit()
        }

        subLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            subLabel.sizeToFit()
        }
    }
}

