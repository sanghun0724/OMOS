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
        view.backgroundColor = .purple
       return view
    }()
    
    let myOstView:reactangleView = {
       let view = reactangleView()
        view.backgroundColor = .white
       return view
    }()
    
    let myStoryView:reactangleView = {
       let view = reactangleView()
        view.backgroundColor = .white
       return view
    }()
    
    let lyricsView:reactangleView = {
       let view = reactangleView()
        view.backgroundColor = .white
       return view
    }()
    
    let freeView:reactangleView = {
        let view = reactangleView()
        view.backgroundColor = .white
        return view
    }()
    
//    private lazy var horiStack1:UIStackView = {
//        let stack = UIStackView(arrangedSubviews: [oneLineView,myOstView])
//        stack.axis = .horizontal
//        stack.alignment = .fill
//        stack.spacing = 10
//        stack.distribution = .equalSpacing
//        return stack
//    }()
//
//    private lazy var horiStack2:UIStackView = {
//        let stack = UIStackView(arrangedSubviews: [myStoryView,lyricsView])
//        stack.axis = .horizontal
//        stack.alignment = .fill
//        stack.spacing = 10
//        stack.distribution = .equalSpacing
//        return stack
//    }()
//
//    private lazy var vertiStack:UIStackView = {
//        let stack = UIStackView(arrangedSubviews: [horiStack1,horiStack2,freeView])
//        stack.axis = .vertical
//        stack.alignment = .fill
//        stack.distribution = .fill
//        return stack
//    }()
//
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let constant = myOstView.frame.minX - oneLineView.frame.maxX
        myStoryView.snp.updateConstraints { make in
            make.top.equalTo(myOstView.snp.bottom).offset(constant)
        }
        
        lyricsView.snp.updateConstraints { make in
            make.top.equalTo(myStoryView)
        }
        
        freeView.snp.updateConstraints { make in
            make.top.equalTo(myStoryView.snp.bottom).offset(constant)
        }
    }
    
    let squareSize = UIScreen.main.bounds.width * 0.44
    
    override func configureUI() {
        super.configureUI()
        self.addSubview(oneLineView)
        self.addSubview(myOstView)
        self.addSubview(myStoryView)
        self.addSubview(lyricsView)
        self.addSubview(freeView)
        
        oneLineView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
            make.width.equalTo(squareSize)
            make.height.equalTo(oneLineView.snp.width)
        }
        
        myOstView.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview()
            make.width.height.equalTo(oneLineView)
        }
        
        myStoryView.snp.makeConstraints { make in
            make.width.height.equalTo(oneLineView)
            make.leading.equalToSuperview()
            make.top.equalTo(myOstView.snp.bottom).offset(0)
        }
        
        lyricsView.snp.makeConstraints { make in
            make.width.height.equalTo(oneLineView)
            make.trailing.equalToSuperview()
            make.top.equalTo(myStoryView)
        }
        
        freeView.snp.makeConstraints { make in
            make.top.equalTo(myStoryView.snp.bottom).offset(0)
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(oneLineView)
        }
     
        
       
        

        
        
        
    }
    
}






class reactangleView:BaseView {
    
    let coverImageView:UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let titleLabel:UILabel = {
       let label = UILabel()
        label.text = "한 줄 감상"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    let subTitleLabel:UILabel = {
       let label = UILabel()
        label.text = "당신의 노래를 한줄로 표현한다면?"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
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
            make.leading.top.equalToSuperview()
            titleLabel.sizeToFit()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom)
            subTitleLabel.sizeToFit()
        }
        
        
        
    }
    
    
}
