//
//  CreateView.swift
//  Omos
//
//  Created by sangheon on 2022/02/20.
//

import UIKit

class CreateView: BaseView {
    
    let topLabelView:UIView = {
        let view = UIView()
        view.backgroundColor = .mainBackGround
        return view
    }()
    
    let circleImageView:UIImageView = {
        let view = UIImageView(image:UIImage(systemName: "person"))
        view.backgroundColor = .brown
        return view
    }()
    
    let musicTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "노래 제목이 들어있습니다"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    let subMusicInfoLabel:UILabel = {
        let label = UILabel()
        label.text = "가수이름이 들어갑니다. 앨범제목이 들어갑니다."
        label.font = .systemFont(ofSize: 12)
        label.textColor = .mainGrey4
        return label
    }()
    
    
    
    override func configureUI() {
        super.configureUI()
        
        
        
    }
}
