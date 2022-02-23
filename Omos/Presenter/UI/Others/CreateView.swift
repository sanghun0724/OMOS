//
//  CreateView.swift
//  Omos
//
//  Created by sangheon on 2022/02/20.
//

import UIKit

class CreateView: BaseView {
    
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
        let view = UIImageView(image:UIImage(systemName: "person"))
        view.backgroundColor = .brown
        return view
    }()
    
    let musicTitleLabel:UITextField = {
        let label = UITextField()
        label.text = "노래 제목이 들어있습니다"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    let subMusicInfoLabel:UITextField = {
        let label = UITextField()
        label.text = "가수이름이 들어갑니다. 앨범제목이 들어갑니다."
        label.font = .systemFont(ofSize: 12)
        label.textColor = .mainGrey4
        return label
    }()
    
    ///2
    let titleImageView:UIView = {
        let view = UIView()
        let image = UIImage(systemName: "person")
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        view.addSubview(imageView)
        view.bringSubviewToFront(imageView)
        return view
    }()
    
    let titleTextView:UITextView = {
        let textView = UITextView()
        textView.text = "레코드 제목을 입력해주세요"
        textView.font = .systemFont(ofSize: 22)
        textView.textColor = .lightGray
        textView.isScrollEnabled = false
        textView.isEditable = true
        textView.translatesAutoresizingMaskIntoConstraints = true
        return textView
    }()
    
    let createdField:UITextField = {
        let label = UITextField()
        label.text = "2020 00 00 한줄감상"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .mainGrey1
        return label
    }()
    
    /// 3
    let textCoverView:UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlack
        return view
    }()
    
    let mainTextView:UITextView = {
        let view = UITextView()
        view.text = #""레코드 내용을 입력해주세요""#
        view.font = UIFont(name: "Cafe24Oneprettynight", size: 22)
        view.isScrollEnabled = false
        view.textAlignment = .center
        view.backgroundColor = .mainBlack
       
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
    
    let remainTitle:UILabel = {
       let label = UILabel()
        label.text = "제목"
        label.textColor = .mainGrey7
        return label
    }()
    
    let remainText:UILabel = {
       let label = UILabel()
        label.text = "내용"
        label.textColor = .mainGrey7
        return label
    }()
    
    let remainTitleCount:UILabel = {
       let label = UILabel()
        label.text = "0/36"
        label.textColor = .mainGrey7
        return label
    }()
    
    let remainTextCount:UILabel = {
       let label = UILabel()
        label.text = "0/50"
        label.textColor = .mainGrey7
        return label
    }()
    
    let stickerImageView:UIImageView = {
        let view = UIImageView(image:UIImage(named: "emptyStar"))
        return view
    }()
    
    let stickerLabel:UILabel = {
       let label = UILabel()
        label.text = "스티커"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    
    override func configureUI() {
        super.configureUI()
        addSubviews()
        ///1
        topLabelView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.077)
        }
        
        dummyView1.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        circleImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.64)
            make.width.equalTo(circleImageView.snp.height)
        }
        
        musicTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(circleImageView.snp.trailing).offset(14)
            make.top.equalTo(circleImageView.snp.top)
            make.bottom.equalTo(circleImageView.snp.centerY)
            musicTitleLabel.sizeToFit()
        }
        
        subMusicInfoLabel.snp.makeConstraints { make in
            make.leading.equalTo(musicTitleLabel)
            make.bottom.equalTo(circleImageView.snp.bottom)
            subMusicInfoLabel.sizeToFit()
        }
        
        ///2
        titleImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(topLabelView.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.227)
        }
        
        createdField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            createdField.sizeToFit()
        }

        titleTextView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(createdField.snp.top)
            titleTextView.sizeToFit()
        }
        
        ///4
        lastView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.13)
        }
        
        dummyView2.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        remainTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(10)
            remainTitle.sizeToFit()
        }
        
        remainTitleCount.snp.makeConstraints { make in
            make.leading.equalTo(remainTitle)
            make.top.equalTo(remainTitle.snp.bottom)
            remainTitleCount.sizeToFit()
        }
        
        
        stickerImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.height.equalToSuperview().multipliedBy(0.3)
            make.width.equalTo(stickerImageView.snp.height)
            make.trailing.equalToSuperview().offset(-10)
        }

        stickerLabel.snp.makeConstraints { make in
            make.centerX.equalTo(stickerImageView.snp.centerX)
            make.top.equalTo(stickerImageView.snp.bottom).offset(3)
            stickerLabel.sizeToFit()
        }

        ///3
        textCoverView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleImageView.snp.bottom)
            make.bottom.equalTo(lastView.snp.top)
        }
        
        mainTextView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        
    }
    
    
    func addSubviews() {
        self.addSubview(topLabelView)
        self.addSubview(titleImageView)
        self.addSubview(textCoverView)
        self.addSubview(lastView)
        
        topLabelView.addSubview(dummyView1)
        topLabelView.addSubview(circleImageView)
        topLabelView.addSubview(musicTitleLabel)
        topLabelView.addSubview(subMusicInfoLabel)
        
        titleImageView.addSubview(titleTextView)
        titleImageView.addSubview(createdField)
        
        textCoverView.addSubview(mainTextView)
        
        lastView.addSubview(remainTitle)
        lastView.addSubview(remainText)
        lastView.addSubview(remainTitleCount)
        lastView.addSubview(remainTextCount)
        lastView.addSubview(dummyView2)
        lastView.addSubview(stickerImageView)
        lastView.addSubview(stickerLabel)
        
    }
}



