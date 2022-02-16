//
//  EmptyView.swift
//  Omos
//
//  Created by sangheon on 2022/02/06.
//

import UIKit

class EmptyView: UIView {
    
    let descriptionLabel = UILabel()
    let imageView = UIImageView(image:UIImage(named: "empty"))
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        descriptionLabel.text = "작성된 레코드가 없어요"
        descriptionLabel.tintColor = .white
        addSubview(descriptionLabel)
        addSubview(imageView)
        
        descriptionLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(descriptionLabel.snp.top)
            make.width.height.equalTo(72)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
