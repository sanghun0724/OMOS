//
//  CreateViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/20.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import YPImagePicker

class CreateViewController:BaseViewController {
    
    private let selfView = CreateView()
//    let viewModel:CreateViewModel
//
//    init(viewModel:CreateViewModel) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selfView.titleTextView.delegate = self
    }
    
    override func configureUI() {
        super.configureUI()
        self.view.addSubview(selfView)
    
        selfView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        
    }
    
    func test() {
        var config = YPImagePickerConfiguration()
        config.wordings.libraryTitle = "보관함"
        config.wordings.cameraTitle = "카메라"
        config.wordings.next = "다음"
        config.colors.tintColor = .black
        UINavigationBar.appearance().tintColor = .black
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, cancelled in
            if let photo = items.singlePhoto {
                print(photo.image) // Final image selected by the user
                picker.dismiss(animated: true, completion: {
                    
                })
//                let vc = CreateVC(postImage: photo.image)
//                vc.title = "기록하기"
//                self.navigationController?.pushViewController(vc, animated: true)
            }
            if cancelled {
                print("Picker was canceled")
                picker.dismiss(animated: true, completion: nil)
            }
        }

        present(picker, animated: true, completion: nil)
    }
    
    
    private func updateTitleCountLabel(characterCount: Int) {
        selfView.remainTitleCount.text = "\(characterCount)/50"
       }
    
}


//#""레코드 내용을 입력해주세요""#

extension CreateViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("check")
        if textView.text == "레코드 제목을 입력해주세요" {
            textView.text = nil
            textView.textColor = .white
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "레코드 제목을 입력해주세요"
            textView.textColor = .lightGray
            updateTitleCountLabel(characterCount: 0)
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let inputString = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let oldString = textView.text, let newRange = Range(range, in: oldString) else { return true }
        let newString = oldString.replacingCharacters(in: newRange, with: inputString).trimmingCharacters(in: .whitespacesAndNewlines)

        let characterCount = newString.count
        guard characterCount <= 50 else { return false }
        updateTitleCountLabel(characterCount: characterCount)

        return true
    }
}
