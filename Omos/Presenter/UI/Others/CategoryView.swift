//
//  CategoryVIew.swift
//  Omos
//
//  Created by sangheon on 2022/02/21.
//

import UIKit

class CategoryView:BaseView {
    
    let oneLineView:reactangleView = {
       let view = reactangleView()
       return view
    }()
    
    let myOstView:reactangleView = {
       let view = reactangleView()
       return view
    }()
    
    let myStoryView:reactangleView = {
       let view = reactangleView()
       return view
    }()
    
    let lyricsView:reactangleView = {
       let view = reactangleView()
       return view
    }()
    
    let freeView:reactangleView = {
        let view = reactangleView()
        return view
    }()
    
    override func configureUI() {
        super.configureUI()
        
        
        
        
    }
}






class reactangleView:BaseView {
    
    let coverImageView:UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let titleLabel:UILabel = {
       let label = UILabel()
        label.text = "한 줄 감상"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    let subTitleLabel:UILabel = {
       let label = UILabel()
        label.text = "당신의 노래를 한줄로 표현한다면?"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    
    override func configureUI() {
        super.configureUI()
        self.addSubview(coverImageView)
        coverImageView.addSubview(titleLabel)
        coverImageView.addSubview(subTitleLabel)
        
        coverImageView.frame = self.bounds
        
        titleLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            titleLabel.sizeToFit()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom)
        }
        
        
        
    }
    
    
}
