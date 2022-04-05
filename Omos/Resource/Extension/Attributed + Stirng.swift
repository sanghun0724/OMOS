//
//  AttributedStirng.swift
//  Omos
//
//  Created by sangheon on 2022/02/14.
//

import UIKit

extension NSMutableAttributedString {
    
    var fontSize: CGFloat {
        return 16
    }
    var boldFont: UIFont {
        return UIFont(name: "AvenirNext-Bold", size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize)
    }
    var normalFont: UIFont {
        return UIFont(name: "AppleSDGothicNeo-Regular", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
    
    func bold(string: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }
    
    func regular(string: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let font = UIFont.systemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }
    
    func orangeHighlight(_ value:String) -> NSMutableAttributedString {
        let attributes:[NSAttributedString.Key : Any] = [
            .font: normalFont,
            .foregroundColor: UIColor.mainOrange
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func blackHighlight(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font: normalFont,
            .foregroundColor: UIColor.white,
            .backgroundColor: UIColor.black
            
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func underlined(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font: normalFont,
            .underlineStyle : NSUnderlineStyle.single.rawValue
            
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}



extension String {
    // 이메일 정규식
    func validateEmail() -> Bool {
        let emailRegEx = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: self)
    }
    
    // 패스워드
    func validatePassword() -> Bool {
        let passwordRegEx = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return predicate.evaluate(with: self)
    }
}

//라벨에 패딩값주기 
class BasePaddingLabel: UILabel {
    private var padding = UIEdgeInsets(top: 10.0, left: 16.0, bottom: 18, right: 16.0)
    
    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        
        return contentSize
    }
    
    //    override var text: String? {
    //        didSet {
    //            if let text = text {
    //               print(text)
    //            } else {
    //                print("Text not changed.")
    //            }
    //        }
    //    }
}

//라벨 라인수 구하기
extension UILabel {
    var maxNumberOfLines: Int {
        self.layoutIfNeeded()
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let text = (self.text ?? "") as NSString
        let textHeight = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil).height
        let lineHeight = font.lineHeight
        return Int(ceil(textHeight / lineHeight))
    }
}


extension String { // 한글 숫자 영문 특수문자 포함 정규식 (이모티콘 제외)
    func hasCharacters() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[0-9a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ`~!@#$%^&*()\\-_=+\\[{\\]}\\\\|;:'\",<.>/?\\s]$", options: .caseInsensitive)
            if let _ = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count)) {
                return true
            }
        }
        catch {
            return false
        }
        return false
        
    }
    
    func getReverseCate() -> String {
        switch self {
        case "A_LINE":
            return "한 줄 감상"
        case "STORY":
            return "노래 속 나의 이야기"
        case "OST":
            return "내 인생의 OST"
        case "LYRICS":
            return "나만의 가사해석"
        case "FREE":
            return "자유 공간"
        default:
            return self
        }
    }
    
     func toDate() -> String {
         let dateFormatter = DateFormatter()
         let tempLocale = dateFormatter.locale // save locale temporarily
         dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
         dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
         let date = dateFormatter.date(from: self)!
         dateFormatter.dateFormat = "yyyy-MM-dd"
         dateFormatter.locale = tempLocale // reset the locale
         let dateString = dateFormatter.string(from: date)
         
        return dateString
    }
    
}

extension Date {
    
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: self)
    }

}

extension UILabel {
    func asColor(targetString: String, color: UIColor) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        attributedText = attributedString
    }
}



class VerticalAlignedLabel: UILabel {
    
    override func drawText(in rect: CGRect) {
        var newRect = rect
        switch contentMode {
        case .top:
            newRect.size.height = sizeThatFits(rect.size).height
        case .bottom:
            let height = sizeThatFits(rect.size).height
            newRect.origin.y += rect.size.height - height
            newRect.size.height = height
        default:
            ()
        }
        
        super.drawText(in: newRect)
    }
}

extension Notification.Name {
    static let follow = Notification.Name("follow")
    static let followCancel = Notification.Name("followCancel")
    static let reload = Notification.Name("reload")
    static let loginInfo = Notification.Name("login")
    static let profileReload = Notification.Name("profile")
}



