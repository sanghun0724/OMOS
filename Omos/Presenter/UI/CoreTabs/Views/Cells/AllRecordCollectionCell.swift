//
//  AllRecordCollectionCell.swift
//  Omos
//
//  Created by sangheon on 2022/02/15.
//

import UIKit
import RxGesture
import RxSwift
protocol AllRecordCellProtocol:AnyObject {
    func collecCellTap(cate:String)
}

class AllRecordCollectionCell:UICollectionViewCell {
    static let identifier = "AllRecordCollectionCell"
    let disposeBag = DisposeBag()
    var delegate:AllRecordCellProtocol?
    
    let backImageView:UIImageView = {
        let imageView = UIImageView(image: UIImage(named: ""))
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .mainBackGround
        return imageView
    }()
    
    let albumImageView:UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "albumCover"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    private let labelCoverView:UIView = {
        let view = UIView()
        view.layer.cornerCurve = .continuous
        view.layer.backgroundColor = UIColor(red: 0.388, green: 0.388, blue: 0.4, alpha: 0.5).cgColor
        return view
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.text = "노래제목이 들어갑니다.노래제목이 들어갑니다.노래제목이 들어갑니다."
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    let subTitleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.text = "노래제목이 들어갑니다.노래제목이 들어갑니다.노래제목이 들어갑니다."
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    let descLabel:UILabel = {
        let label = UILabel()
        label.text = "record main title here..노래제목이 들어갑니다.노래제목이 들어갑니다.노래제목이 들어갑니다.노래제목이 들어갑니다"
        label.numberOfLines = 2
        return label
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "by. nickname"
        return label
    }()
    
    private let dummyView:UIView = {
        let view = UIView()
        view.backgroundColor = .mainOrange
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
        labelCoverView.layer.cornerRadius = labelCoverView.height / 2
        labelCoverView.layer.masksToBounds = true
        
        albumImageView.layer.cornerRadius = albumImageView.height / 2
        albumImageView.layer.masksToBounds = true
    }
    
    func configureModel() {
        
    }
    
    
   private func configureUI() {
        self.addSubview(backImageView)
       labelCoverView.addSubview(titleLabel)
       labelCoverView.addSubview(albumImageView)
       labelCoverView.addSubview(subTitleLabel)
       backImageView.addSubview(labelCoverView)
       backImageView.addSubview(descLabel)
       backImageView.addSubview(nameLabel)
        
       backImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
       nameLabel.snp.makeConstraints { make in
           make.leading.trailing.bottom.equalToSuperview().inset(14)
           nameLabel.sizeToFit()
       }
       
       descLabel.snp.makeConstraints { make in
           make.leading.trailing.equalToSuperview().inset(14)
           make.bottom.equalTo(nameLabel.snp.top).offset(-8)
           descLabel.sizeToFit()
       }
       
       labelCoverView.snp.makeConstraints { make in
           make.leading.trailing.equalToSuperview().inset(12)
           make.top.equalToSuperview().offset(10)
           make.bottom.equalTo(descLabel.snp.top).offset(-40).priority(2)
       }
       
       albumImageView.snp.makeConstraints { make in
           make.leading.top.bottom.equalToSuperview()
           make.width.equalTo(albumImageView.snp.height)
       }
       
       titleLabel.snp.makeConstraints { make in
           make.leading.equalTo(albumImageView.snp.trailing).offset(10)
           make.trailing.equalToSuperview().offset(-6)
           make.top.equalToSuperview().offset(4)
           make.bottom.equalTo(albumImageView.snp.centerY)
       }
       
       subTitleLabel.snp.makeConstraints { make in
           make.top.equalTo(titleLabel.snp.bottom).offset(4)
           make.trailing.leading.equalTo(titleLabel)
           make.bottom.equalToSuperview().offset(-6)
       }
       
//       self.rx.tapGesture()
//           .when(.recognized)
//           .asDriver{_ in .never()}
//           .drive(onNext: { [weak self] _ in
//               self?.delegate?.collecCellTap(cate: "두 줄 감상")
//               print("tap")
//           })
//           .disposed(by: disposeBag)
       
       
       
       layoutIfNeeded()
       
       
       
       
    }
    
}
