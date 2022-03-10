//
//  AllRecordCateShortDetailCell.swift
//  Omos
//
//  Created by sangheon on 2022/03/03.
//

import Foundation
import UIKit
import RxSwift

class AllRecordCateShortDetailCell:UITableViewCell {
    static let identifier = "AllRecordCateShortDetailCell"
    let disposeBag = DisposeBag()
    let myView = MyRecordDetailView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    
    func configureUI() {
        self.addSubview(myView)
       
        myView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func bind() {
       
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //myView.myView.backImageView.image = nil
    }
    
    func configureModel(record:CategoryRespone) {
        myView.reportButton.isHidden = true 
        myView.musicTitleLabel.text = record.music.musicTitle
        myView.subMusicInfoLabel.text = record.music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)"} + "- \(record.music.albumTitle)"
        myView.circleImageView.setImage(with: record.music.albumImageURL)
        //myView.myView.backImageView.setImage(with: ) 추후 추가되면 삽입
        myView.titleLabel.text = record.recordTitle
        myView.mainLabelView.text = record.recordContents
        myView.createdLabel.text = record.createdDate
        myView.nicknameLabel.text = record.nickname
        myView.loveCountLabel.text = String(record.likeCnt)
        myView.starCountLabel.text = String(record.scrapCnt)
        
        if record.isLiked {
            myView.loveImageView.image = UIImage(named: "fillLove")
            myView.loveCountLabel.textColor = .mainOrange
        }
        
        if record.isScraped {
            myView.starImageView.image = UIImage(named: "fillStar")
            myView.starCountLabel.textColor = .mainOrange
        }
    }
    
    func configureOneMusic(record:OneMusicRecordRespone) {
        myView.reportButton.isHidden = true
        myView.musicTitleLabel.text = record.music.musicTitle
        myView.subMusicInfoLabel.text = record.music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)"} + "- \(record.music.albumTitle)"
        myView.circleImageView.setImage(with: record.music.albumImageURL)
        //myView.myView.backImageView.setImage(with: ) 추후 추가되면 삽입
        myView.titleLabel.text = record.recordTitle
        myView.mainLabelView.text = record.recordContents
        myView.createdLabel.text = record.createdDate
        myView.nicknameLabel.text = record.nickname
        myView.loveCountLabel.text = String(record.likeCnt)
        myView.starCountLabel.text = String(record.scrapCnt)
        myView.cateLabel.text = record.category
        if record.isLiked {
            myView.loveImageView.image = UIImage(named: "fillLove")
            myView.loveCountLabel.textColor = .mainOrange
        }
        
        if record.isScraped {
            myView.starImageView.image = UIImage(named: "fillStar")
            myView.starCountLabel.textColor = .mainOrange
        }
    }
    
    
}
