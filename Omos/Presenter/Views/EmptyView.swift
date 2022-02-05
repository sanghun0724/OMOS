//
//  EmptyView.swift
//  Omos
//
//  Created by sangheon on 2022/02/06.
//

import UIKit

class EmptyView: UIView {
    
    let descriptionLabel = UILabel()
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        descriptionLabel.text = "There is no any ccontents"
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
