//
//  LyricsRecordView.swift
//  Omos
//
//  Created by sangheon on 2022/03/16.
//

import UIKit

class LyricsRecordView:BaseView {
    
   let myView = LyricsPasteCreateView()
    
    let nicknameLabel:UILabel = {
        let label = UILabel()
        label.text = "DJ닉네임이들어갑니다다다"
        label.font = .systemFont(ofSize: 14,weight: .light)
        label.textColor = .mainGrey3
        return label
    }()
    
    let likeButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "emptyLove"), for: .normal)
        return button
    }()
    
    let likeCountLabel:UILabel = {
       let label = UILabel()
        label.text = "122"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    let scrapButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "emptyStar"), for: .normal)
        return button
    }()
    
    let scrapCountLabel:UILabel = {
       let label = UILabel()
        label.text = "144"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    override func configureUI() {
        super.configureUI()
        setDefault()
        
        myView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        myView.lastView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(Constant.mainHeight * 0.07)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            nicknameLabel.sizeToFit()
        }
        
        scrapButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.height.equalToSuperview().multipliedBy(0.3)
            make.width.equalTo(scrapButton.snp.height)
            make.right.equalToSuperview().offset(-10)
        }

        scrapCountLabel.snp.makeConstraints { make in
            make.centerX.equalTo(scrapButton.snp.centerX)
            make.top.equalTo(scrapButton.snp.bottom).offset(3)
            scrapCountLabel.sizeToFit()
        }


        likeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.height.equalToSuperview().multipliedBy(0.3)
            make.width.equalTo(likeButton.snp.height)
            make.right.equalTo(scrapButton.snp.left).offset(-30)
        }

        likeCountLabel.snp.makeConstraints { make in
            make.centerX.equalTo(likeButton.snp.centerX)
            make.top.equalTo(likeButton.snp.bottom).offset(3)
            likeCountLabel.sizeToFit()
        }
       
    }
    
    func setDefault() {
        myView.lastView.addSubview(nicknameLabel)
        myView.lastView.addSubview(likeButton)
        myView.lastView.addSubview(likeCountLabel)
        myView.lastView.addSubview(scrapButton)
        myView.lastView.addSubview(scrapCountLabel)
        self.addSubview(myView)
        
        myView.imageAddButton.isHidden = true
        myView.titleTextView.isUserInteractionEnabled = false 
        myView.titleTextView.textColor = .white
        myView.lockButton.isHidden = true
        myView.remainTitle.isHidden = true
        myView.remainText.isHidden = true
        myView.remainTitleCount.isHidden = true
        myView.remainTextCount.isHidden = true
        myView.stickerLabel.isHidden = true
        myView.stickerImageView.isHidden = true
    }
}
