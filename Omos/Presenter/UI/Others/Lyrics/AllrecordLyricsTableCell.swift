//
//  AllrecordLyricsTableCell.swift
//  Omos
//
//  Created by sangheon on 2022/03/16.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxGesture


class AllrecordLyricsTableCell:UITableViewCell {
    static let identifier = "AllrecordLyricsTableCell"
    var disposeBag = DisposeBag()
    var hiddenFlag = true
    let selfView = LyricsRecordView()
    var lyricsText:String = "" {
        didSet {
            lyricsText.enumerateSubstrings(in: lyricsText.startIndex..., options: .byParagraphs) { [weak self] substring, range, _, stop in
                if  let substring = substring,
                    !substring.isEmpty {
                    self?.lyricsArr.append(substring)
                }
            }
        }
    }
    var lyricsArr:[String] = []
    
    let readMoreButton:UIButton = {
        let button = UIButton()
        button.setTitle("더 보기", for: .normal)
        button.setTitleColor(.mainGrey6, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
          super.init(style: style , reuseIdentifier: reuseIdentifier)
        selfView.tableView.dataSource = self
        selfView.tableView.delegate = self
      }
   
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
        
        selfView.circleImageView.layer.cornerRadius = selfView.circleImageView.height / 2
        selfView.circleImageView.layer.masksToBounds = true
        selfView.lockButton.isHidden = true
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureUI() {
        self.contentView.addSubview(selfView)
        
        selfView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lyricsArr = []
        lyricsText = ""
        disposeBag = DisposeBag()
    }
    
    func configureModel(record:CategoryRespone) {
        selfView.musicTitleLabel.text = record.music.musicTitle
        selfView.subMusicInfoLabel.text = record.music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)"} + "- \(record.music.albumTitle)"
        selfView.circleImageView.setImage(with: record.music.albumImageURL)
        selfView.imageView.setImage(with: record.recordImageURL ?? "")
        selfView.titleTextView.text = record.recordTitle
        self.lyricsText = record.recordContents
        selfView.createdField.text = record.createdDate.toDate()
        selfView.nicknameLabel.text = record.nickname
        selfView.likeCountLabel.text = String(record.likeCnt)
        selfView.scrapCountLabel.text = String(record.scrapCnt)
        selfView.cateLabel.text = record.category.getReverseCate()

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
        selfView.musicTitleLabel.text = record.music.musicTitle
        selfView.subMusicInfoLabel.text = record.music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)"} + "- \(record.music.albumTitle)"
        selfView.circleImageView.setImage(with: record.music.albumImageURL)
        selfView.imageView.setImage(with: record.recordImageURL ?? "")
        selfView.titleTextView.text = record.recordTitle
        self.lyricsText = record.recordContents
        selfView.createdField.text = record.createdDate.toDate()
        selfView.nicknameLabel.text = record.nickname
        selfView.likeCountLabel.text = String(record.likeCnt)
        selfView.scrapCountLabel.text = String(record.scrapCnt)
        selfView.cateLabel.text = " | \(record.category.getReverseCate())"
        
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
        selfView.musicTitleLabel.text = record.music.musicTitle
        selfView.subMusicInfoLabel.text = record.music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)"} + "- \(record.music.albumTitle)"
        selfView.circleImageView.setImage(with: record.music.albumImageURL)
        selfView.imageView.setImage(with: record.recordImageURL ?? "")
        selfView.titleTextView.text = record.recordTitle
        self.lyricsText = record.recordContents
        selfView.createdField.text = record.createdDate.toDate()
        selfView.nicknameLabel.text = record.nickname
        selfView.likeCountLabel.text = String(record.likeCnt)
        selfView.scrapCountLabel.text = String(record.scrapCnt)
        selfView.cateLabel.text = " | \(record.category.getReverseCate())"
        
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
        print( "cell count \(lyricsArr.count)")
        return lyricsArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: LyriscTableCell.identifier, for: indexPath) as! LyriscTableCell
            if indexPath.row == 0 {
                cell.label.text = lyricsArr[0]
            } else {
                cell.label.text = lyricsArr[safe:indexPath.row/2] ?? " "
            }
            
            cell.selectionStyle = .none
            cell.layoutIfNeeded()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TextTableCell.identifier, for: indexPath) as! TextTableCell
            cell.textView.text = lyricsArr[safe:indexPath.row] ?? " "
            cell.selectionStyle = .none
            cell.textView.isUserInteractionEnabled = false
            cell.textView.textColor = .white
            cell.layoutIfNeeded()
            return cell
        }
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

}
