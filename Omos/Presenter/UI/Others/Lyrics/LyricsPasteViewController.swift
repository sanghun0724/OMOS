//
//  LyricsPastViewController.swift
//  Omos
//
//  Created by sangheon on 2022/03/14.
//

import Foundation
import UIKit

class LyricsPasteViewController:BaseViewController {
    let selfView = LyricsPastView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selfView.mainLyricsTextView.delegate = self
        
    }
    
    override func configureUI() {
        super.configureUI()
        self.view.addSubview(selfView)
        
        selfView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }

    }
        
}

extension LyricsPasteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if selfView.mainLyricsTextView.text == "레코드 가사를 입력해주세요" {
            selfView.mainLyricsTextView.text = nil
            selfView.mainLyricsTextView.textColor = .white
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if selfView.mainLyricsTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            selfView.mainLyricsTextView.text = "레코드 가사를 입력해주세요"
            selfView.mainLyricsTextView.textColor = .lightGray
            selfView.remainTextCount.text = "\(0)/250"
        }
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let inputString = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let oldString = textView.text, let newRange = Range(range, in: oldString) else { return true }
        let newString = oldString.replacingCharacters(in: newRange, with: inputString).trimmingCharacters(in: .whitespacesAndNewlines)
        let characterCount = newString.count
        
        guard characterCount <= 250 else { return false }
        selfView.remainTextCount.text =  "\(characterCount)/250"
        
        return true
    }
}
