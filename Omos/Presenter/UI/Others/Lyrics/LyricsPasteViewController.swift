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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.rightBarButtonItems?.removeAll()
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(didTapDone))
        doneButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func didTapDone() {
        if selfView.mainLyricsTextView.text == "레코드 가사를 입력해주세요" || selfView.mainLyricsTextView.text.isEmpty {
            print("비어이")
            return 
        }
        var lyricsArr:[String] = []
        
        let textView = selfView.mainLyricsTextView
        guard let text = selfView.mainLyricsTextView.text else { return }

 
        text.enumerateSubstrings(in: text.startIndex..., options: .byParagraphs) { substring, range, _, stop in
            let nsRange = NSRange(range, in: text)

            if  let substring = substring,
                !substring.isEmpty,
                let start = textView.position(from: textView.beginningOfDocument, offset: nsRange.location),
                let end = textView.position(from: start, offset: nsRange.length)
               // let textRange = self.textView.textRange(from: start, to: end)
            {
                if substring != "" {
                    lyricsArr.append(substring)
                }

            }
        }
  
        let rp = RecordsRepositoryImpl(recordAPI: RecordAPI())
        let uc = RecordsUseCase(recordsRepository: rp)
        let vm = LyricsViewModel(usecase: uc)
        vm.lyricsStringArray = lyricsArr
        let vc = LyricsPasteCreateViewController(viewModel: vm, type: .create)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func getParagraphs() {
       
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
