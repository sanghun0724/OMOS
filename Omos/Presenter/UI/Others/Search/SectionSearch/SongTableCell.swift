//
//  SongTableCell.swift
//  Omos
//
//  Created by sangheon on 2022/02/27.
//

import Foundation
import UIKit
import RxSwift

class SongTableCell:UITableViewCell {
    static let identifier = "SongTableCell"
    var disposeBag = DisposeBag()
    
    let songImageView:UIImageView = {
        let view = UIImageView(image:UIImage(named: "albumCover"))
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.text = "상수역"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    let subTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "검정 치마"
        label.textColor = .mainGrey4
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    let createdButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "edit"), for: .normal)
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        confgirueUI()
        
        layoutIfNeeded()
        songImageView.layer.cornerCurve = .circular
        songImageView.layer.cornerRadius = songImageView.height / 2
        songImageView.layer.masksToBounds = true
    }
    
    func confgirueUI() {
        self.addSubview(songImageView)
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
        self.addSubview(createdButton)
        
        songImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.height.equalToSuperview().multipliedBy(0.571)
            make.width.equalTo(songImageView.snp.height)
        }
        
        createdButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalToSuperview().multipliedBy(0.6)
            make.width.equalTo(createdButton.snp.height)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(songImageView.snp.trailing).offset(14)
            make.centerY.equalToSuperview().multipliedBy(0.75)
            make.trailing.equalTo(createdButton.snp.leading)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.centerY.equalToSuperview().multipliedBy(1.25)
        }
        
    }
    
    func configureModel(track:TrackRespone,keyword:String) {
        songImageView.setImage(with: track.albumImageURL )
        titleLabel.text = track.musicTitle
        subTitleLabel.text = track.artists.map { $0.artistName }.reduce("") { $0 + " \($1)" }
//        DispatchQueue.global().sync {
//            if subTitleLabel.text?.first == " " {
//                subTitleLabel.text?.removeFirst()
//            }
//        }
       
        titleLabel.asColor(targetString: keyword, color: .mainOrange)
        subTitleLabel.asColor(targetString: keyword, color: .mainOrange)
    }
    
    func configureModelArtistTrack(track:ArtistDetailRespone,keyword:String) {
        songImageView.setImage(with: track.albumImageURL)
        titleLabel.text = track.musicTitle
        subTitleLabel.text = track.artistName.reduce("") { $0 + " \($1)" }
//        DispatchQueue.global().sync {
//            if subTitleLabel.text?.first == " " {
//                subTitleLabel.text?.removeFirst()
//            }
//        }
        titleLabel.asColor(targetString: keyword, color: .mainOrange)
        subTitleLabel.asColor(targetString: keyword, color: .mainOrange)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        songImageView.image = nil
        titleLabel.text = nil
        subTitleLabel.text = nil 
        disposeBag = DisposeBag()
    }
    
}
