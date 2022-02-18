//
//  MyRecordDetailView.swift
//  Omos
//
//  Created by sangheon on 2022/02/19.
//

import Foundation
import UIKit

class MyRecordDetailView:BaseView {
    /// 1
    let titleLabelView:UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    let circleImageView:UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let musicTitleLabel:UILabel = {
        let label = UILabel()
        return label
    }()
    
    let subMusicInfoLabel:UILabel = {
        let label = UILabel()
        return label
    }()
    
    /// 2
    let titleImageView:UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .blue
        return view
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        return label
    }()
    
    let createdLabel:UILabel = {
        let label = UILabel()
        return label
    }()
    
    /// 3
    let textCoverView:UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    let mainTextView:UITextView = {
        let view = UITextView()
        return view
    }()
    
    ///4
    let lastView:UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let nicknameLabel:UILabel = {
        let label = UILabel()
        return label
    }()
    
    let loveImageView:UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let loveCountLabel:UILabel = {
       let label = UILabel()
        return label
    }()
    
    let starImageView:UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let starCountLabel:UILabel = {
       let label = UILabel()
        return label
    }()
    
    
    override func configureUI() {
        addSubviews()
        
        titleLabelView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.11)
        }
        
        titleImageView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLabelView.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.32)
        }
        
        lastView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.124)
        }
        
        textCoverView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleImageView.snp.bottom)
            make.bottom.equalTo(lastView.snp.top)
        }
        
        
        
        
    }
    
    
    func addSubviews() {
        self.addSubview(titleLabelView)
        self.addSubview(titleImageView)
        self.addSubview(textCoverView)
        self.addSubview(lastView)
        
        titleLabelView.addSubview(circleImageView)
        titleLabelView.addSubview(musicTitleLabel)
        titleLabelView.addSubview(subMusicInfoLabel)
        
        titleImageView.addSubview(titleLabel)
        titleImageView.addSubview(createdLabel)
        
        textCoverView.addSubview(mainTextView)
        
        lastView.addSubview(nicknameLabel)
        lastView.addSubview(loveImageView)
        lastView.addSubview(loveCountLabel)
        lastView.addSubview(starImageView)
        lastView.addSubview(starCountLabel)
    }
    
    
    
}
