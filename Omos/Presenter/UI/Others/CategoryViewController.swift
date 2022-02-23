//
//  CategoryViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit
import RxGesture

class CategoryViewController:BaseViewController {
    
    private let selfView = CategoryView()
    
    
    //    init(viewModel:CreateViewModel) {
    //        self.viewModel = viewModel
    //        super.init(nibName: nil, bundle: nil)
    //    }
    
    //    required init?(coder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func configureUI() {
        super.configureUI()
        self.view.addSubview(selfView)
        
        selfView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.bottom.equalToSuperview().offset(40).priority(1)
        }
    }
    
    private func bind() {
        selfView.oneLineView.rx.tapGesture()
            .when(.recognized)
            .asDriver{_ in .never()}
            .drive(onNext: { [weak self] _ in
                self?.selfView.oneLineView.layer.borderWidth = 1
                self?.selfView.oneLineView.layer.borderColor = UIColor.mainOrange.cgColor
                let vc = CreateViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
        
        selfView.myOstView.rx.tapGesture()
            .when(.recognized)
            .asDriver{_ in .never()}
            .drive(onNext: { [weak self] _ in
                self?.selfView.myOstView.layer.borderWidth = 1
                self?.selfView.myOstView.layer.borderColor = UIColor.mainOrange.cgColor
            })
            .disposed(by: disposeBag)
        
        selfView.myStoryView.rx.tapGesture()
            .when(.recognized)
            .asDriver{_ in .never()}
            .drive(onNext: { [weak self] _ in
                self?.selfView.myStoryView.layer.borderWidth = 1
                self?.selfView.myStoryView.layer.borderColor = UIColor.mainOrange.cgColor
            })
            .disposed(by: disposeBag)
        
        selfView.lyricsView.rx.tapGesture()
            .when(.recognized)
            .asDriver{_ in .never()}
            .drive(onNext: { [weak self] _ in
                self?.selfView.lyricsView.layer.borderWidth = 1
                self?.selfView.lyricsView.layer.borderColor = UIColor.mainOrange.cgColor
            })
            .disposed(by: disposeBag)
        
        selfView.freeView.rx.tapGesture()
            .when(.recognized)
            .asDriver{_ in .never()}
            .drive(onNext: { [weak self] _ in
                self?.selfView.freeView.layer.borderWidth = 1
                self?.selfView.freeView.layer.borderColor = UIColor.mainOrange.cgColor
            })
            .disposed(by: disposeBag)
        
    }
    
}
