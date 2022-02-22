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
    
    // selfView. bottom 앵커를 옵셔널 (lessthan ) (점선) 으로 줘야댐. @@@@@
        private lazy var horiStack1:UIStackView = {
            let stack = UIStackView(arrangedSubviews: [oneLineView,myOstView])
            stack.axis = .horizontal
            stack.alignment = .fill
            stack.spacing = 16
            stack.distribution = .fillEqually
            return stack
        }()
    
        private lazy var horiStack2:UIStackView = {
            let stack = UIStackView(arrangedSubviews: [myStoryView,lyricsView])
            stack.axis = .horizontal
            stack.alignment = .fill
            stack.spacing = 16
            stack.distribution = .fillEqually
            return stack
        }()
    
        private lazy var vertiStack:UIStackView = {
            let stack = UIStackView(arrangedSubviews: [horiStack1,horiStack2,freeView])
            stack.axis = .vertical
            stack.alignment = .fill
            stack.distribution = .fill
            stack.spacing = 16
            return stack
        }()
    
    override func configureUI() {
        super.configureUI()
        self.addSubview(vertiStack)
        
        vertiStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        horiStack2.snp.makeConstraints { make in
            make.height.equalTo(horiStack1)
        }
        
        freeView.snp.makeConstraints { make in
            make.height.equalTo(horiStack1)
        }
        
        oneLineView.snp.makeConstraints { make in
            make.height.equalTo(oneLineView.snp.width).multipliedBy(1.0)
        }
        
        myOstView.snp.makeConstraints { make in
            make.height.equalTo(myOstView.snp.width).multipliedBy(1.0)
        }
        myStoryView.snp.makeConstraints { make in
            make.height.equalTo(myStoryView.snp.width).multipliedBy(1.0)
        }
        
        lyricsView.snp.makeConstraints { make in
            make.height.equalTo(lyricsView.snp.width).multipliedBy(1.0)
        }
        
    }
    
}






class reactangleView:BaseView {

let coverImageView:UIImageView = {
    let view = UIImageView()
    view.backgroundColor = .mainBlack
    return view
}()

let titleLabel:UILabel = {
    let label = UILabel()
    label.text = "한 줄 감상"
    label.font = .systemFont(ofSize: 18, weight:.medium)
    label.textColor = .white
    return label
}()

let subTitleLabel:UILabel = {
    let label = UILabel()
    label.text = "당신의 노래를 한줄로 표현한다면?"
    label.font = .systemFont(ofSize: 14, weight: .light)
    label.textColor = .mainGrey6
    label.numberOfLines = 0
    return label
}()


override func configureUI() {
    super.configureUI()
    self.addSubview(coverImageView)
    coverImageView.addSubview(titleLabel)
    coverImageView.addSubview(subTitleLabel)
    
    coverImageView.snp.makeConstraints { make in
        make.edges.equalToSuperview()
    }
    
    titleLabel.snp.makeConstraints { make in
        make.leading.top.equalToSuperview().offset(10)
        titleLabel.sizeToFit()
    }
    
    subTitleLabel.snp.makeConstraints { make in
        make.leading.trailing.equalToSuperview().offset(10)
        make.top.equalTo(titleLabel.snp.bottom).offset(4)
        subTitleLabel.sizeToFit()
    }
    
}

}
