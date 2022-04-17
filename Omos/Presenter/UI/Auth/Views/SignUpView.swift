//
//  SignUpView.swift
//  Omos
//
//  Created by sangheon on 2022/02/12.
//

import UIKit

class SignUpView: BaseView {
    let coverView = CoverView()

    let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "이메일(아이디)를 입력해주세요"
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.layer.cornerRadius = Constant.loginCorner
        field.layer.masksToBounds = true
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.textColor = .white
        field.backgroundColor = .black
        return field
    }()

    let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "비밀번호를 입력해주세요"
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.textContentType = .password
        field.isSecureTextEntry = true
        field.layer.cornerRadius = Constant.loginCorner
        field.layer.masksToBounds = true
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.textColor = .white
        field.backgroundColor = .black
        field.rightViewMode = .always
        return field
    }()

    let repasswordField: UITextField = {
        let field = UITextField()
        field.placeholder = "비밀번호를 다시 입력해주세요"
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.textContentType = .password
        field.isSecureTextEntry = true
        field.layer.cornerRadius = Constant.loginCorner
        field.layer.masksToBounds = true
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.textColor = .white
        field.backgroundColor = .black
        field.rightViewMode = .always
        return field
    }()

    let emailLabel: EmailLabelView = {
        let view = EmailLabelView()
        return view
    }()

    let passwordLabel: PasswordLabelView = {
        let view = PasswordLabelView()
        return view
    }()

    let repaswwordLabel: PasswordLabelView = {
        let view = PasswordLabelView()
        view.passwordLabel.text = "비밀번호 재확인"
        return view
    }()

    let passwordDecoView: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "visible2" ), for: .normal)
        return button
    }()

    let repasswordDecoView: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "visible2" ), for: .normal)
        return button
    }()

    let emailCheckView: EmailCheckView = {
       let view = EmailCheckView()
        return view
    }()

    lazy var views = [emailLabel, emailField, emailCheckView, passwordLabel, passwordField, repaswwordLabel, repasswordField]

    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: views)
        stack.axis = .vertical
        return stack
    }()

    override func configureUI() {
        self.addSubview(stack)
        self.addSubview(coverView)
        passwordField.addSubview(passwordDecoView)
        repasswordField.addSubview(repasswordDecoView)

        coverView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.42)
        }

        stack.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(coverView.snp.bottom)
        }

        for view in views {
            view.snp.makeConstraints { make in
                make.height.equalTo(self.snp.height).multipliedBy(0.089)
            }
        }

        passwordDecoView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.greaterThanOrEqualTo(24)
        }

        repasswordDecoView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.greaterThanOrEqualTo(24)
        }
    }
}

class EmailCheckView: BaseView {
    let labelView: UILabel = {
       let label = UILabel()
        return label
    }()

    let isSuccessView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "check"))
        view.isHidden = true
        return view
    }()

    override func configureUI() {
        self.addSubview(labelView)
        self.addSubview(isSuccessView)
        setAtt()

        labelView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            labelView.sizeToFit()
        }

        isSuccessView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.height.width.equalTo(20)
        }
    }

    func setAtt() {
        let text = NSMutableAttributedString.init(string: "인증메일 보내기")

            let range = NSRange(location: 0, length: text.length)
            // add large fonts
            // text.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.red, range: range)
            text.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.mainGrey4, range: range)
            text.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 16), range: range)

            // add underline
            text.addAttribute(NSAttributedString.Key.underlineStyle, value: NSNumber(value: NSUnderlineStyle.double.rawValue), range: range)
            text.addAttribute(NSAttributedString.Key.underlineColor, value: UIColor.mainGrey4, range: range)

            labelView.attributedText = text
    }
}
