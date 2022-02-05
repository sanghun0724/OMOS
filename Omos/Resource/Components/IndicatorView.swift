//
//  Indicator.swift
//  CMC_Hackathon_App
//
//  Created by do_yun on 2022/01/29.


import Foundation
import UIKit

open class IndicatorView {
    static let shared = IndicatorView()
        
    let containerView = UIView()
    let activityIndicator = UIActivityIndicatorView()
    var container = UIView()
    var indicator =  UIImageView()
    
    open func show() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        self.containerView.frame = window.frame
        self.containerView.center = window.center
        self.containerView.backgroundColor = .clear
        
        self.containerView.addSubview(self.activityIndicator)
        UIApplication.shared.windows.first?.addSubview(self.containerView)
    }
    
    open func showIndicator() {
        self.containerView.backgroundColor = .white
        
        self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.activityIndicator.style = .large
        self.activityIndicator.color = .mainColor
        self.activityIndicator.center = self.containerView.center
        
        self.activityIndicator.startAnimating()
    }
    
    open func dismiss() {
        self.activityIndicator.stopAnimating()
        self.containerView.removeFromSuperview()
    }
    open func showgif(){
        container = UIView(frame: UIScreen.main.bounds)
        indicator = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 225, height: 450)))
        let images: [UIImage] = Array(1...6).map{ UIImage(named: "gif_\($0)")! }
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        container.frame = window.frame
        container.center = window.center
        container.backgroundColor = .clear
        container.addSubview(indicator)
        UIApplication.shared.windows.first?.addSubview(container)
        
        container.backgroundColor = UIColor(hex: 0x000000, alpha: 0.1)
        indicator.center = container.center
        indicator.animationImages = images
        indicator.animationDuration = Double(indicator.animationImages?.count ?? 0) / 12
        indicator.animationRepeatCount = 0
        indicator.startAnimating()
        
       
    }
    open func hidegif() {
        self.indicator.stopAnimating()
        self.container.removeFromSuperview()
        
    }
}

