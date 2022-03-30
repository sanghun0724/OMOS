//
//  ShareCustomView.swift
//  Omos
//
//  Created by sangheon on 2022/02/09.
//

import UIKit

class ShareCustomViewController:UIViewController {
    
    let instaShareView:UIView
    
    init(instaShareView:UIView) {
        self.instaShareView = instaShareView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let customView:UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .mainBackGround
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.addSubview(instaShareView)
        self.view.addSubview(customView)
        
        customView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Constant.mainHeight * 0.091)
        }
        
        instaShareView.snp.makeConstraints { make in
            make.top.equalTo(customView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Constant.mainHeight * 0.7)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        shareStroy()
        dismiss(animated: false, completion: nil)
       
    }
    
    
    func shareStroy() {
        if let storyShareURL = URL(string: "instagram-stories://share") {
            if UIApplication.shared.canOpenURL(storyShareURL) {
                let renderer = UIGraphicsImageRenderer(size: self.view.bounds.size)
                let renderImage = renderer.image { _ in
                  
                    self.view.drawHierarchy(in: self.view.bounds, afterScreenUpdates: true)
                }
                
                guard let imageData = renderImage.pngData() else { return }
                
                let pasteboardItems : [String:Any] = [
                    "com.instagram.sharedSticker.stickerImage": imageData,
                ]
                let pasteboardOptions = [
                    UIPasteboard.OptionsKey.expirationDate : Date().addingTimeInterval(300)
                ]
                
                UIPasteboard.general.setItems([pasteboardItems], options: pasteboardOptions)
                
                
                UIApplication.shared.open(storyShareURL, options: [:], completionHandler: nil)
            } else {
                let alert = UIAlertController(title: "알림", message: "인스타그램이 필요합니다", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
}
