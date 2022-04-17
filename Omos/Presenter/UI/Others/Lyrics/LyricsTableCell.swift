//
//  LyricsTableCell.swift
//  Omos
//
//  Created by sangheon on 2022/03/14.
//

import UIKit

class LyriscTableCell: UITableViewCell {
    static let identifier = "LyriscTableCell"

    let label: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Cafe24Oneprettynight", size: 18)
        label.numberOfLines = 0
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .LyricsBack
        contentView.addSubview(label)

        label.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            label.sizeToFit()
        }
    }
}

protocol TextTableCellProtocol: AnyObject {
    func updateTextViewHeight(_ cell: TextTableCell, _ textView: UITextView)
}

class TextTableCell: UITableViewCell, UITextViewDelegate {
    static let identifier = "TextTableCell"

    weak var delegate: TextTableCellProtocol?

    let textView: UITextView = {
      let view = UITextView()
        view.text = "가사해석을 적어주세요"
        view.textColor = .mainGrey7
        view.isScrollEnabled = false
        view.font = .systemFont(ofSize: 16, weight: .light)
      return view
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
       // textView.delegate = self
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(textView)
        contentView.addSubview(textView)

        textView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-20)
            textView.sizeToFit()
        }
    }

//    func textViewDidChange(_ textView: UITextView) {
//        if let delegate = delegate {
//            delegate.updateTextViewHeight(self, textView)
//        }
//        print("check")
//    }

}
