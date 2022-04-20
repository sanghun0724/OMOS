//
//  LoadingCell.swift
//  Omos
//
//  Created by sangheon on 2022/04/20.
//

import UIKit

class LoadingCell: UITableViewCell {
    static let identifier = "LoadingCell"
    
    let selfView = LoadingView()
    
    func start() {
        selfView.isHidden = false
    }
    
    func dismiss() {
        selfView.isHidden = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(selfView)
        selfView.backgroundColor = .mainBackGround
        selfView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


