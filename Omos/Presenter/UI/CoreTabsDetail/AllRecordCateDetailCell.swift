//
//  AllRecordCateDetailCell.swift
//  Omos
//
//  Created by sangheon on 2022/02/28.
//

import Foundation
import UIKit
import ReadMoreTextView

class AllRecordCateDetailCell:UITableViewCell {
    static let identifier = "AllRecordCateDetailCell"
    
    let myView = CellContainerView()
    
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
        
    }
    
}



class CellContainerView:BaseView {
    
    let myView = MyRecordDetailView()
    
    let readMore:ReadMoreTextView = {
       let view = ReadMoreTextView()
        view.textAlignment = .left
        view.font = .systemFont(ofSize: 16)
        view.backgroundColor = .mainBlack
        view.shouldTrim = true
        view.maximumNumberOfLines = 6
        view.readLessText = "  접기"
        let readMoreTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.mainGrey5,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)
             ]
        view.attributedReadMoreText = NSAttributedString(string: "... 더보기", attributes: readMoreTextAttributes)
        view.text = "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        super.configureUI()
        
    }
    
    func setupView() {
        self.addSubview(myView)
        myView.mainLabelView.isHidden = true
        myView.mainLabelView = readMore
        myView.textCoverView.addSubview(myView.mainLabelView)
        //Constant.mainHeight * 0.347 + myView.mainLabelView.intrinsicContentSize.height + 18
        //remake
        
        myView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
   
        myView.topLabelView.snp.remakeConstraints { make in
                make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(Constant.mainHeight * 0.069)
        }
        
        myView.titleImageView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(myView.topLabelView.snp.bottom)
            make.height.equalTo(Constant.mainHeight * 0.201)
        }
        
        myView.mainLabelView.snp.remakeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        myView.lastView.snp.remakeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(Constant.mainHeight * 0.077)
        }
       
}
}
