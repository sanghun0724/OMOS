//
//  ShareCustomView.swift
//  Omos
//
//  Created by sangheon on 2022/02/09.
//

import UIKit

class ShareCustomViewController:UIViewController {
    
    private let customView:UIView = {
        let view = UIView()
        let label = UILabel()
        label.text = "this is test label"
        view.addSubview(label)
        label.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
        view.backgroundColor = .orange
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(customView)
        view.addSubview(button)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customView.frame = CGRect(x: 20, y: 20, width: 300, height: 300)
        button.frame = CGRect(x: 200, y:200, width: 100, height: 100)
    }
    
    private let button:UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .white
        bt.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return bt
    }()
    
    @objc func tap() {
        shareStroy()
    }
    
    
    func shareStroy() {
        if let storyShareURL = URL(string: "instagram-stories://share") {
            if UIApplication.shared.canOpenURL(storyShareURL) {
                let renderer = UIGraphicsImageRenderer(size: customView.bounds.size)
                let renderImage = renderer.image { _ in
                    print(customView.bounds.size)
                    customView.drawHierarchy(in: customView.bounds, afterScreenUpdates: true)
                }
                
                guard let imageData = renderImage.pngData() else { return }
                
                let pasteboardItems : [String:Any] = [
                    "com.instagram.sharedSticker.stickerImage": imageData,
                    "com.instagram.sharedSticker.backgroundTopColor" : "#636e72",
                    "com.instagram.sharedSticker.backgroundBottomColor" : "#b2bec3",
                    
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
