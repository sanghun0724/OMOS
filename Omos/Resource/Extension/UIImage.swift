//
//  UIImage.swift
//  CMC_Hackathon_App
//
//  Created by do_yun on 2022/01/29.
//

import Foundation
import Kingfisher
import UIKit

extension UIImageView {
    // 서버에서 이미지 가져오기
    func setImage(with urlString: String) {
        let cache = ImageCache.default
        cache.retrieveImage(forKey: urlString, options: nil) { result in // 캐시에서 키를 통해 이미지를 가져온다.
            switch result {
            case .success(let value):
                if let image = value.image { // 만약 캐시에 이미지가 존재한다면
                    self.image = image // 바로 이미지를 셋한다.
                } else {
                    guard let url = URL(string: urlString) else { return }
                    let resource = ImageResource(downloadURL: url, cacheKey: urlString) // URL로부터 이미지를 다운받고 String 타입의 URL을 캐시키로 지정하고
                    self.kf.setImage(with: resource, placeholder: UIImage(named: "albumCover")) // 이미지를 셋한다.
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func setImageNocache(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: "albumCover"),
            options: [.forceRefresh]
        )
    }
    
//    func setImageWithPadding(with urlString: String) {
//        guard let url = URL(string: urlString) else { return }
//        self.kf.setImage(
//            with: url,
//            placeholder: UIImage(named: "albumCover")?.with(.init(top: 6, left: 6, bottom: 6, right: 6)),
//            options: [.forceRefresh]) { result in
//                switch result {
//                case .success(let data):
//                    let padding:CGFloat = 6
//                    let dataImage = data.image.withAlignmentRectInsets(UIEdgeInsets(top: -4, left: -4, bottom: -4, right: -4))
//                    self.image = dataImage
//                case .failure(let error):
//                    print(error)
//                }
//            }
//    }
    
    // 서버에서 받아온 이미지 cornerRadius적용하기
    func download(url: String?, rounded: Bool = true) {
        guard let tmpUrl = url else {
            return
        }
        if rounded {
            let processor = ResizingImageProcessor(referenceSize: self.frame.size) |> RoundCornerImageProcessor(cornerRadius: self.frame.size.width / 2)
            self.kf.setImage(with: URL(string: tmpUrl), placeholder: nil, options: [.processor(processor)])
        } else {
            self.kf.setImage(with: URL(string: tmpUrl))
        }
    }

    // UIImageView에 border에 그라데이션 적용하기
    func addCircleGradiendBorder(_ width: CGFloat) {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(origin: CGPoint.zero, size: bounds.size)
        let colors: [CGColor] = [UIColor.init(red: 23 / 255, green: 170 / 255, blue: 107 / 255, alpha: 1.0).cgColor,
                                 UIColor.init(red: 179 / 255, green: 242 / 255, blue: 160 / 255, alpha: 1.0).cgColor]
        gradient.colors = colors
        gradient.startPoint = CGPoint(x: 1, y: 0.5)
        gradient.endPoint = CGPoint(x: 0, y: 0.5)

        let cornerRadius = frame.size.width / 2
        layer.cornerRadius = cornerRadius
        clipsToBounds = true

        let shape = CAShapeLayer()
        let path = UIBezierPath(ovalIn: bounds)

        shape.lineWidth = width
        shape.path = path.cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor // clear
        gradient.mask = shape

        layer.insertSublayer(gradient, below: layer)
    }
}

extension UIImage {
    func alpha(_ value: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
     func with(_ insets: UIEdgeInsets) -> UIImage {
         let targetWidth = size.width + insets.left + insets.right
         let targetHeight = size.height + insets.top + insets.bottom
         let targetSize = CGSize(width: targetWidth, height: targetHeight)
         let targetOrigin = CGPoint(x: insets.left, y: insets.top)
         let format = UIGraphicsImageRendererFormat()
         format.scale = scale
         let renderer = UIGraphicsImageRenderer(size: targetSize, format: format)
         return renderer.image { _ in
             draw(in: CGRect(origin: targetOrigin, size: size))
         }.withRenderingMode(renderingMode)
     }
    
    func imageWithInsets(insets: UIEdgeInsets) -> UIImage? {
            UIGraphicsBeginImageContextWithOptions(
                CGSize(width: self.size.width + insets.left + insets.right,
                       height: self.size.height + insets.top + insets.bottom), false, self.scale)
            let _ = UIGraphicsGetCurrentContext()
            let origin = CGPoint(x: insets.left, y: insets.top)
            self.draw(at: origin)
            let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return imageWithInsets
        }
    
}

class PaddedImageView: UIImageView {
    override var alignmentRectInsets: UIEdgeInsets {
        return UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)
    }
}



