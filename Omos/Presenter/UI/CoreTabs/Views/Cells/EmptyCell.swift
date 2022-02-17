//
//  EmptyCell.swift
//  Omos
//
//  Created by sangheon on 2022/02/16.
//

import Foundation
import UIKit

class EmptyCell:UICollectionViewCell {
    static let identifier = "EmptyCell"
    
    let albumImageView:UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "albumCover"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let backGroundView:UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 0.87).cgColor

        return view
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.text = "레코드가 아직 생성되지 않았어요!"
        label.font = .systemFont(ofSize: 12)
        return label
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
        
        albumImageView.layer.cornerRadius = albumImageView.width / 2
        albumImageView.layer.masksToBounds = true
    }
    
    
   private func configureUI() {
        self.addSubview(albumImageView)
        self.addSubview(backGroundView)
       backGroundView.addSubview(titleLabel)
  
        albumImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalTo(albumImageView.snp.width)
        }
        
        backGroundView.snp.makeConstraints { make in
            make.left.equalTo(albumImageView.snp.centerX)
            make.right.bottom.top.equalToSuperview()
        }
       
        titleLabel.snp.makeConstraints { make in
           make.center.equalToSuperview()
        }
       
       layoutIfNeeded()
    }
    
    
}
