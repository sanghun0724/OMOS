//
//  InstagramShareView.swift
//  Omos
//
//  Created by sangheon on 2022/03/22.
//

import Foundation
import UIKit

class InstagramShareView: BaseView {
    let instaShareView = MyRecordDetailView()

    let topView: UIView = {
       let view = UIView()
        view.backgroundColor = .mainBackGround
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: Constant.mainWidth, height: 1_200))
        }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // scrollview는 어케할건지 tableView도

    override func configureUI() {
        super.configureUI()
        self.addSubview(topView)
        self.addSubview(instaShareView)
        topView.frame = .init(x: 0, y: 45, width: Constant.mainWidth, height: Constant.mainHeight * 0.091)
        instaShareView.frame = .init(x: 0, y: topView.height + 1, width: Constant.mainWidth, height: instaShareView.height)
        layoutIfNeeded()
        print(instaShareView.frame)
        topView.backgroundColor = .red
        instaShareView.backgroundColor = .yellow
        self.backgroundColor = .orange
    }
}
