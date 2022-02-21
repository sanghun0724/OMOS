//
//  CategoryVIew.swift
//  Omos
//
//  Created by sangheon on 2022/02/21.
//

import UIKit

class CategoryView:BaseView {
    
    
    
    override func configureUI() {
        super.configureUI()
        
        
        
        
    }
}






class reactangleView:BaseView {
    
    let titleLabel:UILabel = {
       let label = UILabel()
        label.text = "한 줄 감상"
        return label
    }()
    
    let subTitleLabel:UILabel = {
       let label = UILabel()
        label.text = "당신의 노래를 한줄로 표현한다면?"
        return label
    }()
    
    
    override func configureUI() {
        super.configureUI()
        
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
