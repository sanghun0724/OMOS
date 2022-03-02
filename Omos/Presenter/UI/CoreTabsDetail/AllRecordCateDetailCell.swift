//
//  AllRecordCateDetailCell.swift
//  Omos
//
//  Created by sangheon on 2022/02/28.
//

import Foundation
import UIKit
import RxSwift
protocol MyCellDelegate: AnyObject {
    func readMoreTapped(cell: AllRecordCateDetailCell)
}

class AllRecordCateDetailCell:UITableViewCell {
    static let identifier = "AllRecordCateDetailCell"
    let disposeBag = DisposeBag()
    
    weak var delegate:MyCellDelegate?
    let myView = CellContainerView()
    
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
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalToSuperview().priority(999)
        }
    }
    
    func bind() {
        myView.readMoreButton.rx
            .tap
            .asDriver()
            .drive(onNext:{ [weak self] _ in
                guard let self = self else { return }
                self.delegate?.readMoreTapped(cell: self)
            })
            .disposed(by: disposeBag)
    }

    
    override func prepareForReuse() {
        super.prepareForReuse()
      
    }
    
}

class CellContainerView:BaseView {
    
    let myView = MyRecordDetailView()
    
    let dummyLabel:UILabel = {
        let label = UILabel()
        label.text = " 더보기"
        label.font = .systemFont(ofSize: 14,weight:.medium)
        label.backgroundColor = .mainBlack
        return label
    }()
    
    let readMoreButton:UIButton = {
        let button = UIButton()
//        button.setTitle("... 더보기", for: .normal)
//        button.titleLabel?.font = .systemFont(ofSize: 16)
//        button.titleLabel?.minimumScaleFactor = 0.0
//        button.titleLabel?.numberOfLines = 1
    //button.backgroundColor = .red
//        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        super.configureUI()
        setupView()
    }
    
    func setupView() {
        self.addSubview(myView)
        myView.textCoverView.addSubview(dummyLabel)
        myView.textCoverView.addSubview(readMoreButton)
        myView.mainLabelView.textAlignment = .left
        myView.mainLabelView.font = .systemFont(ofSize: 16)
        myView.mainLabelView.numberOfLines = 3
        myView.mainLabelView.lineBreakMode = .byTruncatingTail
        myView.mainLabelView.text = "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
       
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
        
        dummyLabel.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview()
            dummyLabel.sizeToFit()
        }
        
        readMoreButton.snp.makeConstraints { make in
            make.edges.equalTo(dummyLabel)
        }

        myView.lastView.snp.remakeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(Constant.mainHeight * 0.077)
        }
       
}
}
