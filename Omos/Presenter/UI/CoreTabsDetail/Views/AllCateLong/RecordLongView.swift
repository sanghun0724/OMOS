//
//  RecordLongView.swift
//  Omos
//
//  Created by sangheon on 2022/04/20.
//
import UIKit

class RecordLongView: BaseView {
    /// 1
    let topLabelView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBackGround
        return view
    }()
    
    let circleImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "albumCover"))
        return view
    }()
    
    let musicTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "노래 제목이 들어있습니다"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    let subMusicInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "가수이름이 들어갑니다. 앨범제목이 들어갑니다."
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .mainGrey1
        return label
    }()
    
    /// 2
    let titleImageView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBackGround
        return view
    }()
    
    let backImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .mainBackGround
        view.alpha = 0.4
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "백예린 노래"
        label.font = .systemFont(ofSize: 22, weight: .light)
        label.textColor = .white
        return label
    }()
    
    let createdLabel: UILabel = {
        let label = UILabel()
        label.text = "2020 00 00"
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .mainGrey1
        return label
    }()
    
    let cateLabel: UILabel = {
        let label = UILabel()
        label.text = " | 한줄감상"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .mainGrey1
        return label
    }()
    
    let reportButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "report"), for: .normal)
        return button
    }()
    
    let lockButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "unlock"), for: .normal)
        button.setImage(UIImage(named: "lock"), for: .selected)
        return button
    }()
    
    /// 3
    let textCoverView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlack
        return view
    }()
    
    var mainLabelView: UILabel = {
        let view = UILabel()
        view.text = #"“한줄감상이나옵니다글자수는50자이내여야합니다한줄감상이나옵니다글자수는50자이내여야합니다한@@@@@@@@@@@@@@@@@@@@@줄감상”"#
        view.font = .systemFont(ofSize: 16, weight: .light)
        view.textAlignment = .left
        view.backgroundColor = .mainBlack
        view.textColor = .mainGrey1
        view.numberOfLines = 0
        return view
    }()
    
    /// 4
    let lastView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlack
        return view
    }()
    
    let dummyView2: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlack1
        return view
    }()
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "DJ닉네임이들어갑니다다다"
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .mainGrey3
        return label
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "emptyLove"), for: .normal)
        return button
    }()
    
    let likeCountLabel: UILabel = {
        let label = UILabel()
        label.text = "122"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    let scrapButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "emptyStar"), for: .normal)
        return button
    }()
    
    let scrapCountLabel: UILabel = {
        let label = UILabel()
        label.text = "144"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    let dummyView3: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlack1
        return view
    }()
    
    let dummyLabel: UILabel = {
        let label = UILabel()
        label.text = " 더보기"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.backgroundColor = .mainBlack
        return label
    }()
    
    let readMoreButton: AdjustButton = {
        let button = AdjustButton()
        button.setTitle(" 더 보기", for: .normal)
        button.setTitleColor(UIColor.mainGrey6, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.backgroundColor = .mainBlack
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configure()
        
        circleImageView.layoutIfNeeded()
        circleImageView.layer.cornerRadius = circleImageView.height / 2
        circleImageView.layer.masksToBounds = true
    }
    
    func configure() {
        addSubviews()
        /// 1
        topLabelView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(Constant.mainHeight * 0.077)
        }
        
        circleImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.64)
            make.width.equalTo(circleImageView.snp.height)
        }
        
        musicTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(circleImageView.snp.right).offset(14)
            make.top.equalTo(circleImageView.snp.top)
            make.bottom.equalTo(circleImageView.snp.centerY)
            make.trailing.equalToSuperview().offset(-16)
            musicTitleLabel.sizeToFit()
        }
        
        subMusicInfoLabel.snp.makeConstraints { make in
            make.left.equalTo(musicTitleLabel)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(circleImageView.snp.bottom)
            subMusicInfoLabel.sizeToFit()
        }
        
        /// 2
        titleImageView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(topLabelView.snp.bottom)
            make.height.equalTo(Constant.mainHeight * 0.227)
        }
        
        backImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        createdLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            createdLabel.sizeToFit()
        }
        
        cateLabel.snp.makeConstraints { make in
            make.leading.equalTo(createdLabel.snp.trailing)
            make.centerY.equalTo(createdLabel)
            cateLabel.sizeToFit()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalTo(createdLabel.snp.top)
            titleLabel.sizeToFit()
        }
        
        reportButton.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview().inset(16)
            make.height.width.equalTo(20)
        }
        
        lockButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-10)
            make.width.height.equalTo(18)
        }
        
        /// 4
        lastView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(Constant.mainHeight * 0.07)
        }
        
        dummyView2.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(0.5)
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
        
        dummyView3.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(2)
        }
        
        /// 3
        textCoverView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleImageView.snp.bottom)
            //            self.heightConst = make.height.equalTo(Constant.mainHeight * 0.28).constraint
            make.bottom.equalTo(lastView.snp.top).priority(999)
        }
        
        mainLabelView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            mainLabelView.sizeToFit()
        }
        print(mainLabelView.intrinsicContentSize.height)
        
        readMoreButton.snp.makeConstraints { make in
            make.bottom.equalTo(textCoverView.snp.bottom).offset(-2)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(readMoreButton.intrinsicContentSize.width)
            make.height.equalTo(readMoreButton.intrinsicContentSize.height)
        }
        //        print(readMoreButton.intrinsicContentSize.width)
        //        print(readMoreButton.intrinsicContentSize.height)
        
    }
    
    func addSubviews() {
        self.addSubview(topLabelView)
        self.addSubview(titleImageView)
        self.addSubview(textCoverView)
        self.addSubview(lastView)
        
        topLabelView.addSubview(circleImageView)
        topLabelView.addSubview(musicTitleLabel)
        topLabelView.addSubview(subMusicInfoLabel)
        
        titleImageView.addSubview(backImageView)
        titleImageView.addSubview(titleLabel)
        titleImageView.addSubview(createdLabel)
        titleImageView.addSubview(cateLabel)
        titleImageView.addSubview(reportButton)
        titleImageView.addSubview(lockButton)
        
        textCoverView.addSubview(mainLabelView)
        textCoverView.addSubview(readMoreButton)
        
        lastView.addSubview(nicknameLabel)
        lastView.addSubview(dummyView2)
        lastView.addSubview(likeButton)
        lastView.addSubview(likeCountLabel)
        lastView.addSubview(scrapButton)
        lastView.addSubview(scrapCountLabel)
        lastView.addSubview(dummyView3)
    }
}

