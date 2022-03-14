//
//  LyricsTableCell.swift
//  Omos
//
//  Created by sangheon on 2022/03/14.
//

import UIKit

class LyriscTableCell:UITableViewCell {
    static let identifier = "LyriscTableCell"
    
    let label:UILabel = {
        let label = UILabel()
        label.text = "짤리나?어떻게되는건데짤리나?어떻게되는건데짤리나?어떻게되는건데짤리나?어떻게되는건데짤리나?어떻게되는건데짤리나?어떻게되는건데짤리나?어떻게되는건데짤리나?어떻게되는건데짤리나?어떻게되는건데짤리나?어떻게되는건데짤리나?어떻게되는건데짤리나?어떻게되는건데짤리나?어떻게되는건데"
        label.numberOfLines = 0
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .LyricsBack
        contentView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
            label.sizeToFit()
        }
    }
    
}

protocol TextTableCellProtocol:AnyObject {
    func updateTextViewHeight(_ cell:TextTableCell,_ textView:UITextView)
}


class TextTableCell:UITableViewCell,UITextViewDelegate {
    static let identifier = "TextTableCell"
    
    weak var delegate:TextTableCellProtocol?
    
    let textView:UITextView = {
      let view = UITextView()
        view.text = "레코드 가사해석을 입력해주세요"
        view.isScrollEnabled = false 
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
            make.edges.equalToSuperview().inset(12)
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
