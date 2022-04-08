//
//  File.swift
//  Omos
//
//  Created by sangheon on 2022/03/11.
//

import UIKit

class LaunchViewController:BaseViewController {
    
    let launchImageView:UIImageView = {
        let view = UIImageView(image:UIImage(named: "splash_logo"))
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = . mainBackGround
    }
    
    override func configureUI() {
        super.configureUI()
        self.view.addSubview(launchImageView)
        
        launchImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.9)
            make.height.equalToSuperview().multipliedBy(0.08)
            make.width.equalToSuperview().multipliedBy(0.282)
        }
        
    }
}
