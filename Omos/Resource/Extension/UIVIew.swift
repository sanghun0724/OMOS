//
//  UIVIew.swift
//  CMC_Hackathon_App
//
//  Created by do_yun on 2022/01/29.
//

import Foundation
import UIKit

// MARK: - UITextView extension
extension UITextView {
    func centerVerticalText() {
        self.textAlignment = .center
        let fitSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fitSize)
        let calculate = (bounds.size.height - size.height * zoomScale) / 2
        let offset = max(1, calculate)
        contentOffset.y = -offset
    }
}

class TabBarBackgroundView: BaseView {
    override func configureUI() {
        super.configureUI()
    }
}

extension UIStackView {
    func removeFully(view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }

    func removeFullyAllArrangedSubviews() {
        arrangedSubviews.forEach { view in
            removeFully(view: view)
        }
    }
}

class AdjustButton: UIButton {
    override var intrinsicContentSize: CGSize {
           let labelSize = titleLabel?.sizeThatFits(CGSize(width: frame.width, height: .greatestFiniteMagnitude)) ?? .zero
           let desiredButtonSize = CGSize(width: labelSize.width + titleEdgeInsets.left + titleEdgeInsets.right, height: labelSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom)

           return desiredButtonSize
        }
}

extension UIView {
    public func removeAllConstraints() {
        var vsuperview = self.superview

        while let superview = vsuperview {
            for constraint in superview.constraints {
                if let first = constraint.firstItem as? UIView, first == self {
                    superview.removeConstraint(constraint)
                }

                if let second = constraint.secondItem as? UIView, second == self {
                    superview.removeConstraint(constraint)
                }
            }

            vsuperview = superview.superview
        }

        self.removeConstraints(self.constraints)
        self.translatesAutoresizingMaskIntoConstraints = true
    }
}

extension UIView {
    public var width: CGFloat {
        self.frame.size.width
    }
    public var height: CGFloat {
        self.frame.size.height
    }
    public var top: CGFloat {
        self.frame.origin.y
    }
    public var bottom: CGFloat {
        self.frame.size.height + self.frame.origin.y
    }
    public var left: CGFloat {
        self.frame.origin.x
    }
    public var right: CGFloat {
        self.frame.size.width + self.frame.origin.x
    }
    // 뷰 그라데이션
    func setGradient(color1: UIColor, color2: UIColor) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.7, y: 0.0)
        gradient.frame = self.bounds
        self.layer.addSublayer(gradient)
    }
    func setVerticalGradient(color1: UIColor, color2: UIColor) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 0.4)
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
}
