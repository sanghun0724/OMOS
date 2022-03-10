//
//  HomeView.swift
//  Omos
//
//  Created by sangheon on 2022/03/04.
//

import Foundation
import UIKit
import RxSwift

class HomeView:BaseView {
    
    let tableView:UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(AllRecordTableCell.self, forCellReuseIdentifier: AllRecordTableCell.identifier)
        table.register(HomeHeaderView.self, forHeaderFooterViewReuseIdentifier: HomeHeaderView.identifier)
        table.register(AllRecordHeaderView.self, forHeaderFooterViewReuseIdentifier: AllRecordHeaderView.identifier)
        
        table.showsVerticalScrollIndicator = false
        table.automaticallyAdjustsScrollIndicatorInsets = false
        table.insetsContentViewsToSafeArea = true
        table.contentInsetAdjustmentBehavior = .never
        return table
    }()
    
    let floatingButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .mainGrey4
        button.setImage(UIImage(named: "edit2"), for: .normal)
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        floatingButton.layer.cornerCurve = .circular
        floatingButton.layer.masksToBounds = true
        floatingButton.layer.cornerRadius = floatingButton.height / 2
    }
    
    override func configureUI() {
        self.addSubview(tableView)
        self.addSubview(floatingButton)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        floatingButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(16)
            make.width.equalToSuperview().multipliedBy(0.17)
            make.height.equalTo(floatingButton.snp.width)
        }
        
    }
    
}


class HomeHeaderView:UITableViewHeaderFooterView {
    static let identifier = "HomeHeaderView"
    let disposeBag = DisposeBag()
    
    let groundView:UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    let backImageView:UIImageView = {
        let view = UIImageView(image:UIImage(named:"photo1"))
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let backView:UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let omosImageView:UIImageView = {
        let view = UIImageView(image: UIImage(named: "logo"))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let notiButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "bell"), for: .normal)
        return button
    }()
    
    let decoLabel1:UILabel = {
        let label = UILabel()
        label.text = "현재 OMOS DJ들이"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    let decoLabel2:UILabel = {
        let label = UILabel()
        label.text = "가장 많이 기록하고 있는,"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    let todayLabel:UILabel = {
        let label = UILabel()
        label.text = "오늘의 노래"
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    let albumImageView:UIImageView = {
        let view = UIImageView(image:UIImage(named: "albumCover"))
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let songTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "노래 재목이 들어갑니다."
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    let artistTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "가수 이름이 들어갑니다"
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    let albumTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "앨범 제목이 들어갑니다."
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    let albumLabelImageView:UIImageView = {
        let view = UIImageView(image:UIImage(named: "disc"))
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let createdButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "edit"), for: .normal)
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    
    func configureUI() {
        self.addSubview(groundView)
        groundView.addSubview(backImageView)
        groundView.addSubview(backView)
        backView.addSubview(omosImageView)
        backView.addSubview(notiButton)
        backView.addSubview(decoLabel1)
        backView.addSubview(decoLabel2)
        backView.addSubview(todayLabel)
        backView.addSubview(albumImageView)
        backView.addSubview(songTitleLabel)
        backView.addSubview(artistTitleLabel)
        backView.addSubview(albumTitleLabel)
        backView.addSubview(albumLabelImageView)
        backView.addSubview(createdButton)
        
        groundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(44)
        }
        
        omosImageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.256)
            make.height.equalTo(omosImageView.snp.width).multipliedBy(0.204)
        }
        
        notiButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.height.width.equalTo(24)
        }
        
        decoLabel1.snp.makeConstraints { make in
            make.top.equalTo(omosImageView.snp.bottom).offset(24)
            make.leading.equalToSuperview()
            decoLabel1.sizeToFit()
        }
        
        decoLabel2.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(decoLabel1.snp.bottom)
        }
        
        todayLabel.snp.makeConstraints { make in
            make.top.equalTo(decoLabel2.snp.bottom).offset(16)
            make.leading.equalToSuperview()
            todayLabel.sizeToFit()
        }
        
        albumImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.247)
            make.height.equalTo(albumImageView.snp.width)
            make.leading.equalToSuperview()
            make.top.equalTo(todayLabel.snp.bottom).offset(30).priority(300)
        }
        
        createdButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(albumImageView)
            make.height.equalTo(albumImageView.snp.height).multipliedBy(0.28)
            make.width.equalTo(createdButton.snp.height)
        }
        
        artistTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(albumImageView.snp.centerY)
            make.leading.equalTo(albumImageView.snp.trailing).offset(24)
            make.trailing.equalToSuperview()
            artistTitleLabel.sizeToFit()
        }
        
        songTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(artistTitleLabel.snp.top).offset(-10)
            make.leading.trailing.equalTo(artistTitleLabel)
            songTitleLabel.sizeToFit()
        }
        
        albumLabelImageView.snp.makeConstraints { make in
            make.leading.equalTo(artistTitleLabel)
            make.top.equalTo(artistTitleLabel.snp.bottom)
            make.width.equalTo(createdButton).multipliedBy(0.6)
            make.height.equalTo(albumLabelImageView.snp.width)
        }
        
        albumTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(albumLabelImageView.snp.trailing).offset(6)
            make.centerY.equalTo(albumLabelImageView)
            make.trailing.equalToSuperview()
            albumTitleLabel.sizeToFit()
        }
        
        
        
    }
}
