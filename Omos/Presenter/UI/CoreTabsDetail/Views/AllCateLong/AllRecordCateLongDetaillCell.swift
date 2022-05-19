//
//  AllRecordCateDetailCell.swift
//  Omos
//
//  Created by sangheon on 2022/02/28.
//

import Foundation
import RxSwift
import UIKit

class AllRecordCateLongDetailCell: UITableViewCell ,ConfigurableCell, ExpandableCellProtocol {
    static let identifier = "AllRecordCateLongDetailCell"
    var disposeBag = DisposeBag()
    let myView = RecordLongView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        myView.lockButton.isHidden = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myView.backImageView.image = nil
        myView.likeButton.setImage(nil, for: .normal)
        myView.scrapButton.setImage(nil, for: .normal)
        myView.likeCountLabel.textColor = nil
        myView.scrapCountLabel.textColor = nil
        disposeBag = DisposeBag()
        myView.mainLabelView.text = nil
    }
    
    func configure(record: RecordResponse) {
        myView.mainLabelView.text = record.recordContents
        myView.musicTitleLabel.text = record.music.musicTitle
        myView.subMusicInfoLabel.text = record.music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)" } + "- \(record.music.albumTitle)"
        if myView.subMusicInfoLabel.text?.first == " " {
            myView.subMusicInfoLabel.text?.removeFirst()
        }
        myView.circleImageView.setImage(with: record.music.albumImageURL)
        myView.backImageView.setImage(with: record.recordImageURL ?? "")
        myView.titleLabel.text = record.recordTitle
        myView.createdLabel.text = record.createdDate.toDate()
        myView.cateLabel.text = " | \(record.category.getReverseCate())"
        myView.nicknameLabel.text = record.nickname
        myView.likeCountLabel.text = String(record.likeCnt)
        myView.scrapCountLabel.text = String(record.scrapCnt)
        
        let textCount = Array(record.recordContents).count
        if textCount < 80 {
            myView.readMoreButton.isHidden = true
        } else {
            myView.mainLabelView.numberOfLines = 3
            myView.mainLabelView.sizeToFit()
            myView.readMoreButton.isHidden = false
        }
        
        if record.isLiked {
            myView.likeButton.setImage(UIImage(named: "fillLove"), for: .normal)
            myView.likeCountLabel.textColor = .mainOrange
        } else {
            myView.likeButton.setImage(UIImage(named: "emptyLove"), for: .normal)
            myView.likeCountLabel.textColor = .white
        }
        
        if record.isScraped {
            myView.scrapButton.setImage( UIImage(named: "fillStar"), for: .normal)
            myView.scrapCountLabel.textColor = .mainOrange
        } else {
            myView.scrapButton.setImage( UIImage(named: "emptyStar"), for: .normal)
            myView.scrapCountLabel.textColor = .white
        }
    }
    
    func shrinkCell(_ hasSet:Bool) {
        print("내말이")
        if hasSet {
            self.myView.mainLabelView.numberOfLines = 0
            self.myView.mainLabelView.sizeToFit()
            self.myView.mainLabelView.setNeedsLayout()
            self.myView.mainLabelView.layoutIfNeeded()
            self.myView.readMoreButton.isHidden = true
        }
    }
    
    func cellHelper() {
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.myView.lockButton.isHidden = true
        self.selectionStyle = . none
        print("this work")
    }
    
}
