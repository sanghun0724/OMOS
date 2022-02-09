//
//  LoadingView.swift
//  Omos
//
//  Created by sangheon on 2022/02/09.
//

import UIKit

class LoadingView:UIView {
    let spinner = UIActivityIndicatorView(style: .large)
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        
        addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        spinner.startAnimating()
     }
    
    required init?(coder: NSCoder) {
        fatalError("init((coder:) has not been implemented")
    }
    
}
