//
//  LyricsRecordView.swift
//  Omos
//
//  Created by sangheon on 2022/03/16.
//

import UIKit
import SnapKit

class LyricsRecordView:BaseView {
    
    var tableHeightConstraint: Constraint? = nil
    var subTableHeightConstraint: Constraint? = nil
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
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    let subMusicInfoLabel:UILabel = {
        let label = UILabel()
        label.text = "error"
        label.font = .systemFont(ofSize: 12,weight: .light)
        label.textColor = .mainGrey1
        return label
    }()
    
    ///2
    let titleImageView:UIView = {
        let view = UIView()
        return view
    }()
    
    let imageView:UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.alpha = 0.4
        return view
    }()
    
    let lockButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "unlock"), for: .normal)
        button.setImage(UIImage(named: "lock"), for: .selected)
        return button
    }()
    
 
    
    let titleTextView:UITextView = {
        let textView = UITextView()
        textView.text = "레코드 제목을 입력해주세요"
        textView.font = .systemFont(ofSize: 22,weight: .light)
        textView.textColor = .mainGrey4
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = false 
        textView.backgroundColor = nil
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .none
        return textView
    }()
    
    let createdField:UILabel = {
        let label = UILabel()
        label.text = "2020 00 00"
        label.font = .systemFont(ofSize: 12,weight: .light)
        label.textColor = .mainGrey1
        return label
    }()
    
    let cateLabel:UILabel = {
       let label = UILabel()
        label.text = " | 한줄감상"
        label.font = .systemFont(ofSize: 12,weight: .light)
        label.textColor = .mainGrey1
        return label
    }()
    
    let reportButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "report"), for: .normal)
        return button
    }()
    
    
    ///3
    
    let tableView:IntrinsicTableView = {
       let table = IntrinsicTableView()
        table.register(LyriscTableCell.self, forCellReuseIdentifier: LyriscTableCell.identifier)
        table.register(TextTableCell.self, forCellReuseIdentifier: TextTableCell.identifier)
        table.backgroundColor = .mainBackGround
        table.separatorStyle = .none
        table.estimatedRowHeight = 190
        table.rowHeight = UITableView.automaticDimension
        table.showsVerticalScrollIndicator = false
        table.automaticallyAdjustsScrollIndicatorInsets = false
        table.isScrollEnabled = true
       return table
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
    
    let dummyView3:UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlack1
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circleImageView.layoutIfNeeded()
        circleImageView.layer.cornerRadius = circleImageView.height / 2
        circleImageView.layer.masksToBounds = true
    }
    
    override func configureUI() {
        super.configureUI()
        setDefault()
        ///1
        let mainHeight = UIScreen.main.bounds.height
        
        topLabelView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(mainHeight * 0.077)
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
        
        dummyView1.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        ///2
        titleImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(topLabelView.snp.bottom)
            make.height.equalTo(mainHeight * 0.227)
        }
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        createdField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            createdField.sizeToFit()
        }

        titleTextView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.leading.equalTo(createdField)
            make.bottom.equalTo(createdField.snp.top)
            titleTextView.sizeToFit()
        }
        
        reportButton.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview().inset(16)
            make.height.width.equalTo(20)
        }
        
        cateLabel.snp.makeConstraints { make in
            make.leading.equalTo(createdField.snp.trailing)
            make.centerY.equalTo(createdField)
            cateLabel.sizeToFit()
        }
        lockButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-10)
            make.width.height.equalTo(18)
        }
       
        //4
        lastView.snp.remakeConstraints { make in
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
        
        dummyView3.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(2)
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
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleImageView.snp.bottom)
            self.tableHeightConstraint = make.height.equalTo(1200).constraint
            self.subTableHeightConstraint = make.height.equalTo(Constant.mainHeight * 0.28).constraint
            make.bottom.equalTo(lastView.snp.top).priority(751)
        }
        
        
    }
    
    func setDefault() {
        self.addSubview(topLabelView)
        self.addSubview(titleImageView)
        self.addSubview(tableView)
        self.addSubview(lastView)
        topLabelView.addSubview(circleImageView)
        topLabelView.addSubview(musicTitleLabel)
        topLabelView.addSubview(subMusicInfoLabel)
        topLabelView.addSubview(dummyView1)
        
        titleImageView.addSubview(imageView)
        titleImageView.addSubview(titleTextView)
        titleImageView.addSubview(createdField)
        titleImageView.addSubview(cateLabel)
        titleImageView.addSubview(reportButton)
        titleImageView.addSubview(lockButton)
        
        lastView.addSubview(nicknameLabel)
        lastView.addSubview(likeButton)
        lastView.addSubview(likeCountLabel)
        lastView.addSubview(scrapButton)
        lastView.addSubview(scrapCountLabel)
        lastView.addSubview(dummyView3)
        
        
    
        titleTextView.isUserInteractionEnabled = false
        titleTextView.textColor = .white
       
    }
}
