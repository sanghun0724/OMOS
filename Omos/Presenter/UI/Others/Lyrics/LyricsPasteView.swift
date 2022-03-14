//
//  LyricsPasteView.swift
//  Omos
//
//  Created by sangheon on 2022/03/14.
//

import UIKit


class LyricsPastView:BaseView {
    
    ///1
    let topLabelView:UIView = {
        let view = UIView()
        view.backgroundColor = .mainBackGround
        return view
    }()
    
    let dummyView1:UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlack1
        return view
    }()
    
    let circleImageView:UIImageView = {
        let view = UIImageView(image:UIImage(named:"albumCover"))
        return view
    }()
    
    let musicTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "error"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    let subMusicInfoLabel:UILabel = {
        let label = UILabel()
        label.text = "error"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .mainGrey4
        return label
    }()
    
    
    let mainLyricsTextView:UITextView = {
        let view = UITextView()
        view.text = "레코드 가사를 입력해주세요"
        view.font = .systemFont(ofSize: 16, weight: .light)
        view.isScrollEnabled = false
        view.textAlignment = .left
        view.backgroundColor = .mainBlack
        view.textColor = .mainGrey7
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        return view
    }()
    
    ///4
    let lastView:UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlack
        return view
    }()
    
    let dummyView2:UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlack1
        return view
    }()
    
    let remainText:UILabel = {
       let label = UILabel()
        label.text = "글자수"
        label.textColor = .mainGrey7
        return label
    }()
    
    let remainTextCount:UILabel = {
       let label = UILabel()
        label.text = "0/250"
        label.textColor = .mainGrey4
        return label
    }()
    
    
    override func configureUI() {
        super.configureUI()
        self.addSubview(topLabelView)
        self.addSubview(mainLyricsTextView)
        self.addSubview(lastView)
        topLabelView.addSubview(circleImageView)
        topLabelView.addSubview(musicTitleLabel)
        topLabelView.addSubview(subMusicInfoLabel)
        lastView.addSubview(remainText)
        lastView.addSubview(remainTextCount)
        lastView.addSubview(dummyView2)
        topLabelView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(Constant.mainHeight * 0.077)
        }
        
        circleImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.64)
            make.width.equalTo(circleImageView.snp.height)
        }
        
        musicTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(circleImageView.snp.trailing).offset(14)
            make.trailing.equalToSuperview().offset(-14)
            make.top.equalTo(circleImageView.snp.top)
            make.bottom.equalTo(circleImageView.snp.centerY)
            musicTitleLabel.sizeToFit()
        }
        
        subMusicInfoLabel.snp.makeConstraints { make in
            make.leading.equalTo(musicTitleLabel)
            make.bottom.equalTo(circleImageView.snp.bottom)
            make.trailing.equalToSuperview().offset(-14)
            subMusicInfoLabel.sizeToFit()
        }
        
        //3
        lastView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(Constant.mainHeight * 0.13)
        }
        
        remainText.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(10)
            remainText.sizeToFit()
        }
        
        remainTextCount.snp.makeConstraints { make in
            make.leading.equalTo(remainText)
            make.top.equalTo(remainText.snp.bottom)
            remainTextCount.sizeToFit()
        }
        
        
        dummyView2.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        //2
        mainLyricsTextView.snp.makeConstraints { make in
            make.top.equalTo(topLabelView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(lastView.snp.top)
        }
        
        
    }
    
    
    
    
    
}
