//
//  LyrisPasteCreateView.swift
//  Omos
//
//  Created by sangheon on 2022/03/14.
//

import SnapKit
import UIKit

class LyricsPasteCreateView: BaseView {
    var tableHeightConstraint: Constraint?
    var inputAccessoryViewContentHeightSum_mx: CGFloat = 0.0
    
    /// 1
    let topLabelView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBackGround
        return view
    }()

    let dummyView1: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlack1
        return view
    }()

    let circleImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "albumCover"))
        return view
    }()

    let musicTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "error"
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    let subMusicInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "error"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .mainGrey4
        return label
    }()

    /// 2
    let titleImageView: UIView = {
        let view = UIView()
        return view
    }()

    let imageView: UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()

    let imageAddButton: UIButton = {
       let button = UIButton()
        button.setBackgroundImage(UIImage(named: "addImage"), for: .normal)
        return button
    }()

    let titleTextView: UITextView = {
        let textView = UITextView()
        textView.text = "레코드 제목을 입력해주세요"
        textView.font = .systemFont(ofSize: 22)
        textView.textColor = .mainGrey4
        textView.isScrollEnabled = false
        textView.isEditable = true
        textView.backgroundColor = nil
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .none
        return textView
    }()

    let createdField: UILabel = {
        let label = UILabel()
        label.text = "2020 00 00"
        label.font = .systemFont(ofSize: 12)
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

    let lockButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "unlock"), for: .normal)
        button.setImage(UIImage(named: "lock"), for: .selected)
        return button
    }()

    /// 3
    let tableView: IntrinsicTableView = {
       let table = IntrinsicTableView()
        table.register(LyriscTableCell.self, forCellReuseIdentifier: LyriscTableCell.identifier)
        table.register(TextTableCell.self, forCellReuseIdentifier: TextTableCell.identifier)
        table.backgroundColor = .mainBackGround
        table.separatorStyle = .none
        table.estimatedRowHeight = 190
        table.rowHeight = UITableView.automaticDimension
        table.estimatedSectionHeaderHeight = 0
        table.estimatedSectionFooterHeight = 0
        table.showsVerticalScrollIndicator = false
        table.automaticallyAdjustsScrollIndicatorInsets = false
        table.isScrollEnabled = false
       return table
    }()

    /// 4
    let lastView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlack
        return view
    }()
    
    let dummyLastView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlack
        return view
    }()

    let dummyView2: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlack1
        return view
    }()

    let remainTitle: UILabel = {
       let label = UILabel()
        label.text = "제목"
        label.textColor = .mainGrey7
        return label
    }()

    let remainText: UILabel = {
       let label = UILabel()
        label.text = "내용"
        label.textColor = .mainGrey7
        return label
    }()

    let remainTitleCount: UILabel = {
       let label = UILabel()
        label.text = "0/36"
        label.textColor = .mainGrey4
        return label
    }()

    let remainTextCount: UILabel = {
       let label = UILabel()
        label.text = "0/380"
        label.textColor = .mainGrey4
        return label
    }()

    let stickerImageView: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "sticker"), for: .normal)
        return view
    }()

    let stickerLabel: UILabel = {
       let label = UILabel()
        label.text = "스티커"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.textColor = .mainGrey3
        return label
    }()

    let dummyView: UIView = {
        let view = UIView()
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
        addSubviews()
        /// 1
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

        /// 2
        titleImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(topLabelView.snp.bottom)
            make.height.equalTo(mainHeight * 0.227)
        }

        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        imageAddButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(10)
            make.height.width.equalTo(24)
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

        cateLabel.snp.makeConstraints { make in
            make.leading.equalTo(createdField.snp.trailing)
            make.centerY.equalTo(createdField)
            cateLabel.sizeToFit()
        }

        lockButton.snp.makeConstraints { make in
            make.top.equalTo(cateLabel.snp.top).offset(-4)
            make.bottom.equalTo(cateLabel.snp.bottom)
            make.centerX.equalTo(imageAddButton)
            make.width.equalTo(lockButton.snp.height)
        }
        /// ++
        dummyView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleImageView.snp.top)
            make.height.equalTo(mainHeight * 0.5)
        }

        /// 4
        lastView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(mainHeight * 0.13)
        }
        
        dummyLastView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(mainHeight * 0.13)
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

        remainText.snp.makeConstraints { make in
            make.leading.equalTo(remainTitleCount.snp.trailing).offset(40)
            make.centerY.equalTo(remainTitle)
            remainText.sizeToFit()
        }

        remainTextCount.snp.makeConstraints { make in
            make.leading.equalTo(remainText)
            make.top.equalTo(remainText.snp.bottom)
            remainTextCount.sizeToFit()
        }

        stickerImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-24)
            make.height.width.equalTo(20)
            make.top.equalToSuperview().offset(10)
        }

        stickerLabel.snp.makeConstraints { make in
            make.top.equalTo(stickerImageView.snp.bottom).offset(3)
            make.centerX.equalTo(stickerImageView)
            stickerLabel.sizeToFit()
        }

        /// 3
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleImageView.snp.bottom)
            self.tableHeightConstraint = make.height.greaterThanOrEqualTo(1_200).constraint
            make.bottom.equalTo(dummyLastView.snp.top).priority(751)
        }
        
        operateLastViewHeight()
    }

    func addSubviews() {
        self.addSubview(dummyView)
        self.addSubview(topLabelView)
        self.addSubview(titleImageView)
        self.addSubview(tableView)
        self.addSubview(dummyLastView)
        self.addSubview(lastView)
        topLabelView.addSubview(circleImageView)
        topLabelView.addSubview(musicTitleLabel)
        topLabelView.addSubview(subMusicInfoLabel)

        titleImageView.addSubview(imageView)
        titleImageView.addSubview(titleTextView)
        titleImageView.addSubview(createdField)
        titleImageView.addSubview(cateLabel)
        titleImageView.addSubview(imageAddButton)
        titleImageView.addSubview(lockButton)

        lastView.addSubview(remainTitle)
        lastView.addSubview(remainText)
        lastView.addSubview(remainTitleCount)
        lastView.addSubview(remainTextCount)
        lastView.addSubview(dummyView2)
        lastView.addSubview(stickerImageView)
        lastView.addSubview(stickerLabel)
    }
    
    private func operateLastViewHeight() {
        let remainTextHeight = remainText.height + remainTextCount.height
        let remainTitleHeight = remainTitle.height + remainTitleCount.height
        let stickerHeight = stickerImageView.height + stickerLabel.height
        
        self.inputAccessoryViewContentHeightSum_mx = [remainTextHeight, remainTitleHeight, stickerHeight].max()!
    }
}
