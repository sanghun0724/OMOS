//
//  InfoController.swift
//  Omos
//
//  Created by sangheon on 2022/02/14.
//

import Foundation
import UIKit

class InfoController: UIViewController {
    let infoView: UITextView = {
        let info = UITextView()
//        info.textContainer.lineBreakMode = .byTruncatingTail
        info.adjustsFontForContentSizeCategory = true
        info.allowsEditingTextAttributes = false
        info.backgroundColor = .mainBackGround
        info.textColor = .white
        info.font = .systemFont(ofSize: 16)
        return info
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .mainBackGround
        self.view.addSubview(infoView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        infoView.frame = view.bounds
    }

    func getInfoView(file: String) {
        let url = Bundle.main.url(forResource: file, withExtension: "rtf")!
        let opts: [NSAttributedString.DocumentReadingOptionKey: Any] =
            [.documentType: NSAttributedString.DocumentType.rtf]
        var d: NSDictionary?
        let s = try! NSAttributedString(url: url, options: opts, documentAttributes: &d)
//        let new = NSAttributedString(string: s.string, attributes: [.foregroundColor: UIColor.red])
        self.infoView.text = s.string
    }
}
