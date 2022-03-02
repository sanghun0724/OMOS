//
//  SearchArtistView.swift
//  Omos
//
//  Created by sangheon on 2022/02/28.
//
import UIKit

class SearchArtistHeaderView:UIView {
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.text = "앨범 제목이 들어갑니다"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    let subTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "가수이름이 들어갑니다"
        label.textColor = .mainGrey4
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    let artistImageView:UIImageView = {
        let view = UIImageView(image:UIImage(named: "albumSquare"))
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
        
        layoutIfNeeded()

        
        artistImageView.layer.cornerRadius = artistImageView.height / 2
        artistImageView.layer.masksToBounds = true
        
    }
    
    func configureUI() {
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
        self.addSubview(artistImageView)
        
        
        artistImageView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.8)
            make.width.equalTo(artistImageView.snp.height)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(artistImageView.snp.centerY)
            make.leading.equalTo(artistImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            titleLabel.sizeToFit()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalTo(titleLabel)
            subTitleLabel.sizeToFit()
        }
        
    }
    
}
