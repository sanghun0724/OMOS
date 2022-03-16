//
//  AllrecordLyricsTableCell.swift
//  Omos
//
//  Created by sangheon on 2022/03/16.
//

import Foundation
import UIKit

class AllrecordLyricsTableCell:UITableViewCell {
    static let identifier = "AllrecordLyricsTableCell"
    
    let selfView = LyricsRecordView()
    var lyricsText:String = "" {
        didSet {
            lyricsText.enumerateSubstrings(in: lyricsText.startIndex..., options: .byParagraphs) { [weak self] substring, range, _, stop in
                if  let substring = substring,
                    !substring.isEmpty {
                    self?.lyricsArr.append(substring)
                }
            }
            selfView.myView.tableView.reloadData()
        }
    }
    var lyricsArr:[String] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
          super.init(style: style , reuseIdentifier: reuseIdentifier)
        selfView.myView.tableView.dataSource = self
        selfView.myView.tableView.delegate = self
      }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
        
        selfView.myView.circleImageView.layer.cornerRadius = selfView.myView.circleImageView.height / 2
        selfView.myView.circleImageView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureUI() {
        self.contentView.addSubview(selfView)
        
        selfView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lyricsArr = []
        lyricsText = ""
    }
    
    func configureModel(record:CategoryRespone) {
        selfView.myView.musicTitleLabel.text = record.music.musicTitle
        selfView.myView.subMusicInfoLabel.text = record.music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)"} + "- \(record.music.albumTitle)"
        selfView.myView.circleImageView.setImage(with: record.music.albumImageURL)
        //myView.myView.backImageView.setImage(with: ) 추후 추가되면 삽입
        selfView.myView.titleTextView.text = record.recordTitle
        self.lyricsText = record.recordContents
        selfView.myView.createdField.text = record.createdDate
        selfView.nicknameLabel.text = record.nickname
        selfView.likeCountLabel.text = String(record.likeCnt)
        selfView.scrapCountLabel.text = String(record.scrapCnt)
        
        if record.isLiked {
            selfView.likeButton.setImage(UIImage(named: "fillLove"), for: .normal)
            selfView.likeCountLabel.textColor = .mainOrange
        }
        
        if record.isScraped {
            selfView.scrapButton.setImage( UIImage(named: "fillStar"), for: .normal)
            selfView.scrapCountLabel.textColor = .mainOrange
        }
        
        
    }
    
    func configureOneMusic(record:OneMusicRecordRespone) {
        selfView.myView.musicTitleLabel.text = record.music.musicTitle
        selfView.myView.subMusicInfoLabel.text = record.music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)"} + "- \(record.music.albumTitle)"
        selfView.myView.circleImageView.setImage(with: record.music.albumImageURL)
        //myView.myView.backImageView.setImage(with: ) 추후 추가되면 삽입
        selfView.myView.titleTextView.text = record.recordTitle
        self.lyricsText = record.recordContents
        selfView.myView.createdField.text = record.createdDate
        selfView.nicknameLabel.text = record.nickname
        selfView.likeCountLabel.text = String(record.likeCnt)
        selfView.scrapCountLabel.text = String(record.scrapCnt)
        
        if record.isLiked {
            selfView.likeButton.setImage(UIImage(named: "fillLove"), for: .normal)
            selfView.likeCountLabel.textColor = .mainOrange
        }
        
        if record.isScraped {
            selfView.scrapButton.setImage( UIImage(named: "fillStar"), for: .normal)
            selfView.scrapCountLabel.textColor = .mainOrange
        }
    }
    
    func configureMyDjRecord(record:MyDjResponse) {
        selfView.myView.musicTitleLabel.text = record.music.musicTitle
        selfView.myView.subMusicInfoLabel.text = record.music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)"} + "- \(record.music.albumTitle)"
        selfView.myView.circleImageView.setImage(with: record.music.albumImageURL)
        //myView.myView.backImageView.setImage(with: ) 추후 추가되면 삽입
        selfView.myView.titleTextView.text = record.recordTitle
        self.lyricsText = record.recordContents
        selfView.myView.createdField.text = record.createdDate
        selfView.nicknameLabel.text = record.nickname
        selfView.likeCountLabel.text = String(record.likeCnt)
        selfView.scrapCountLabel.text = String(record.scrapCnt)
        
        if record.isLiked {
            selfView.likeButton.setImage(UIImage(named: "fillLove"), for: .normal)
            selfView.likeCountLabel.textColor = .mainOrange
        }
        
        if record.isScraped {
            selfView.scrapButton.setImage( UIImage(named: "fillStar"), for: .normal)
            selfView.scrapCountLabel.textColor = .mainOrange
        }
    }
    
}


extension AllrecordLyricsTableCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lyricsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: LyriscTableCell.identifier, for: indexPath) as! LyriscTableCell
            if indexPath.row == 0 {
                cell.label.text = lyricsArr[0]
            }
            cell.label.text = lyricsArr[indexPath.row/2]
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TextTableCell.identifier, for: indexPath) as! TextTableCell
            cell.textView.text = lyricsArr[indexPath.row/2+1]
            cell.selectionStyle = .none
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         tableView.layoutIfNeeded()
         selfView.myView.tableHeightConstraint?.update(offset: ceil(selfView.myView.tableView.contentSize.height) )
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
      
    }
}
