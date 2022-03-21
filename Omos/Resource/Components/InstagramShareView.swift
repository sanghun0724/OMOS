//
//  InstagramShareView.swift
//  Omos
//
//  Created by sangheon on 2022/03/22.
//

import Foundation
import UIKit

class InstagramShareView:BaseView {
    
    let instaShareView:UIView
    
    let topView:UIView = {
       let view = UIView()
        view.backgroundColor = .mainBackGround
        return view
    }()
    
    init(instaShareView:UIView) {
        self.instaShareView = instaShareView
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    override func configureUI() {
        super.configureUI()
        topView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Constant.mainHeight * 0.091)
        }
        
        instaShareView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Constant.mainHeight * 0.7)
        }
        
    }
    
    
    
    

    
}
