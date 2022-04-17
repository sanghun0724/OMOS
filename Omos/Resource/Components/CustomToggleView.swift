//
//  CustomToggleView.swift
//  CMC_Hackathon_App
//
//  Created by do_yun on 2022/01/29.
//
import UIKit

protocol CustomToggleViewDelegate: AnyObject {
    func item1ButtonTaped()
    func item2ButtonTaped()
}

class CustomToggleView: UIView {
    enum State {
        case item1
        case item2
    }

    // MARK: - Properties
    var state: State = .item1
    var buttons: [UIButton] = []
    weak var delegate: CustomToggleViewDelegate?

    lazy var button1: UIButton = {
       let button = UIButton()
        button.setTitle("앨범", for: .normal)
        button.setTitleColor(.mainColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        button.addTarget(self, action: #selector(didTapItem1), for: .touchUpInside)

        return button
    }()
    lazy var button2: UIButton = {
       let button = UIButton()
        button.setTitle("타임라인", for: .normal)
        button.setTitleColor(.toggleColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.addTarget(self, action: #selector(didTapItem2), for: .touchUpInside)

        return button
    }()

    // MARK: - Life Cycle
    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainColor
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 0
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(button1)
        addSubview(button2)
        addSubview(indicatorView)
        buttons = [button1, button2]
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let buttonHeight: CGFloat = 65
        button1.frame = CGRect(x: 0, y: 0, width: self.frame.size.width / 2, height: buttonHeight)
        button2.frame = CGRect(x: button1.right, y: 0, width: self.frame.size.width / 2, height: buttonHeight)

        indicatorView.frame = CGRect(x: 0, y: button1.bottom, width: button1.width, height: 3)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func didTapItem1(_ sender: UIButton) {
        delegate?.item1ButtonTaped()
        update(for: .item1, sender: sender)
    }
    @objc func didTapItem2(_ sender: UIButton) {
        delegate?.item2ButtonTaped()
        update(for: .item2, sender: sender)
        print("qwe")
    }

    func layoutIndicator() {
        let indicatorHegiht: CGFloat = 3

        switch state {
        case .item1:
            indicatorView.frame  = CGRect(x: 0, y: button1.bottom, width: button1.width, height: indicatorHegiht)
        case .item2 :
            indicatorView.frame  = CGRect(x: button1.right, y: button2.bottom, width: button2.width, height: indicatorHegiht)
        }
    }

    func update(for state: State, sender: UIButton) {
        self.state = state

        UIView.animate(withDuration: 0.1) {
            self.layoutIndicator()
            DispatchQueue.main.async {
                for button in self.buttons {
                    if sender == button {
                        // tapped button
                        button.setTitleColor(.mainColor, for: .normal)
                        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
                    } else {
                        button.setTitleColor(.toggleColor, for: .normal)
                        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
                    }
                }
            }
        }
    }
}
