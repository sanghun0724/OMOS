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
import Mantis

class CreateViewController:BaseViewController {
    
    let category:String
    private let selfView = CreateView()
    //    let viewModel:CreateViewModel
    //
    init(category:String) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setViewinfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func setViewinfo() {
        selfView.titleTextView.delegate = self
        selfView.mainTextView.delegate = self
        selfView.mainfullTextView.delegate = self
        selfView.cateLabel.text = "  | \(category)"
        textViewDidChange(selfView.mainfullTextView)
        // get the current date and time
        let currentDateTime = Date()
        
        // get the user's calendar
        let userCalendar = Calendar.current
        
        // choose which date and time components are needed
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day
        ]
        
        // get the components
        let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
        
        selfView.createdField.text = "\(dateTimeComponents.year!) \(dateTimeComponents.month!) \(dateTimeComponents.day!)"
    }
    
    override func configureUI() {
        super.configureUI()
        setlongTextView(category)
    }
    
    private func bind() {
        selfView.imageAddButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.configureImagePicker()
            }).disposed(by: disposeBag)
        
    }
    
    
    func configureImagePicker() {
        var config = YPImagePickerConfiguration()
        config.wordings.libraryTitle = "보관함"
        config.wordings.cameraTitle = "카메라"
        config.wordings.next = "다음"
        config.colors.tintColor = .white
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, cancelled in
            if let photo = items.singlePhoto {
                print(photo.image) // Final image selected by the user
                let cropViewController = Mantis.cropViewController(image: photo.image)
                cropViewController.delegate = self
                cropViewController.modalPresentationStyle = .fullScreen
                picker.dismiss(animated: true, completion: nil)
                self.present(cropViewController, animated: true)
            }
            if cancelled {
                print("Picker was canceled")
                picker.dismiss(animated: true, completion: nil)
                self.tabBarController?.tabBar.isHidden = true
            }
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    
    func setlongTextView(_ category:String) {
        if category == "한 줄 감상" {
            selfView.mainfullTextView.isHidden = true
            self.view.addSubview(selfView)
            selfView.frame = view.bounds
            return
        }
        
        let scrollView = UIScrollView()
        selfView.mainTextView.isHidden = true
        selfView.remainTextCount.text = "0/796"
        scrollView.addSubview(selfView)
        scrollView.frame = view.bounds
    }
    
}













extension CreateViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        switch textView {
        case selfView.titleTextView:
            if textView.text == "레코드 제목을 입력해주세요" {
                textView.text = nil
                textView.textColor = .white
            }
        case selfView.mainTextView:
            if textView.text == #""레코드 내용을 입력해주세요""# {
                textView.text = nil
                textView.textColor = .white
            }
        case selfView.mainfullTextView:
            if textView.text == "레코드 내용을 입력해주세요" {
                textView.text = nil
                textView.textColor = .white
            }
        default:
            return
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        switch textView {
        case selfView.titleTextView:
            if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                textView.text = "레코드 제목을 입력해주세요"
                textView.textColor = .lightGray
                selfView.remainTitleCount.text = "\(0)/36"
            }
        case selfView.mainTextView:
            if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                textView.text = #""레코드 내용을 입력해주세요""#
                textView.textColor = .lightGray
                selfView.remainTextCount.text = "\(0)/50"
            }
        case selfView.mainfullTextView:
            if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                textView.text = "레코드 내용을 입력해주세요"
                textView.textColor = .lightGray
                selfView.remainTextCount.text = "\(0)/796"
            }
        default:
            return
        }
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let inputString = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let oldString = textView.text, let newRange = Range(range, in: oldString) else { return true }
        let newString = oldString.replacingCharacters(in: newRange, with: inputString).trimmingCharacters(in: .whitespacesAndNewlines)
        let characterCount = newString.count
        
        
        switch textView {
        case selfView.titleTextView:
            guard characterCount <= 36 else { return false }
            selfView.remainTitleCount.text = "\(characterCount)/36"
        case selfView.mainTextView:
            guard characterCount <= 50 else { return false }
            selfView.remainTextCount.text = "\(characterCount)/50"
        case selfView.mainfullTextView:
            guard characterCount <= 796 else { return false }
            selfView.remainTextCount.text = "\(characterCount)/796"
        default:
            return true
        }
        
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        selfView.textCoverView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
        
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
        
    }
    
}


extension CreateViewController:CropViewControllerDelegate {
    func cropViewControllerDidCrop(_ cropViewController: CropViewController, cropped: UIImage, transformation: Transformation, cropInfo: CropInfo) {
        selfView.imageView.image = cropped
        self.dismiss(animated: true,completion: nil)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func cropViewControllerDidFailToCrop(_ cropViewController: CropViewController, original: UIImage) {
        
    }
    
    func cropViewControllerDidCancel(_ cropViewController: CropViewController, original: UIImage) {
        self.dismiss(animated: true, completion: nil)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func cropViewControllerDidBeginResize(_ cropViewController: CropViewController) {
        
    }
    
    func cropViewControllerDidEndResize(_ cropViewController: CropViewController, original: UIImage, cropInfo: CropInfo) {
        
    }
    
    
}
