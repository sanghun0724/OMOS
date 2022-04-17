//
//  MydjTableCell.swift
//  Omos
//
//  Created by sangheon on 2022/02/24.
//

import Foundation
import UIKit

class MydjTableCell: UITableViewCell {
    static let identifier = "MydjTableCell"

    let selfView = MyRecordDetailView()

    let dummyView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlack2
        return view
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }

    func configureUI() {
        self.addSubview(dummyView)
        self.addSubview(selfView)

        dummyView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(4)
        }

        selfView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(dummyView.snp.top)
        }
    }
}
