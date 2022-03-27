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

enum CreateType {
    case modify
    case create
}

class CreateViewController:BaseViewController {
    
    let scrollView = UIScrollView()
    let category:String
    private let selfView = CreateView()
    let viewModel:CreateViewModel
    let type:CreateType
    lazy var awsHelper = AWSS3Helper()
    
    
    init(viewModel:CreateViewModel,category:String,type:CreateType) {
        self.viewModel = viewModel
        self.category = category
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selfView.titleTextView.delegate = self
        selfView.mainTextView.delegate = self
        selfView.mainfullTextView.delegate = self
        bind()
        
        if type == .create { setCreateViewinfo() }
        else { setModifyView() }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setlongTextView(category)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.rightBarButtonItems?.removeAll()
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(didTapDone))
        doneButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = doneButton
        enableScrollWhenKeyboardAppeared(scrollView: scrollView)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backgroundColor = .mainBackGround
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeListeners()
    }
    
    @objc func didTapDone() {
        var mainText:String?
        if category == "한 줄 감상" {
            mainText = selfView.mainTextView.text
        } else {
            mainText = selfView.mainfullTextView.text
        }
        let backImage = selfView.imageView.image
        guard let titleText = selfView.titleTextView.text,
              let text = mainText else {
                  //alert
                  print("alert here")
                  return
              }
        
        if type == .create {
            viewModel.saveRecord(cate: getCate(cate: category), content: text, isPublic: !(selfView.lockButton.isSelected), musicId: viewModel.defaultModel.musicId, title: titleText, userid: Account.currentUser,recordImageURL: "https://omos-image.s3.ap-northeast-2.amazonaws.com/record/\(viewModel.curTime).png")
            
            print("check Point\(viewModel.curTime)")
        } else {
            var recordContent = ""
            if  selfView.mainTextView.text != viewModel.modifyDefaultModel?.recordTitle {
                recordContent = selfView.mainTextView.text
            } else {
                recordContent = selfView.mainfullTextView.text
            }
            
            viewModel.updateRecord(postId: viewModel.modifyDefaultModel?.recordID ?? 0, request: .init(contents: recordContent, title: selfView.titleTextView.text,isPublic:  !(selfView.lockButton.isSelected),recordImageUrl: viewModel.modifyDefaultModel?.recordImageURL ?? "" ))
        }
        
    }
    
    private func setCreateViewinfo() {
        selfView.cateLabel.text = "  | \(category)"
        selfView.circleImageView.setImage(with: viewModel.defaultModel.imageURL)
        selfView.musicTitleLabel.text = viewModel.defaultModel.musicTitle
        selfView.subMusicInfoLabel.text = viewModel.defaultModel.subTitle
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
    
    func setModifyView() {
        print(viewModel.modifyDefaultModel!)
        selfView.cateLabel.text = "  | \(category)"
        selfView.circleImageView.setImage(with: viewModel.modifyDefaultModel?.music.albumImageURL ?? "")
        selfView.musicTitleLabel.text = viewModel.modifyDefaultModel?.music.musicTitle
        selfView.subMusicInfoLabel.text = viewModel.modifyDefaultModel?.music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)" }
        selfView.titleTextView.text = viewModel.modifyDefaultModel?.recordTitle
        selfView.mainTextView.text = viewModel.modifyDefaultModel?.recordContents
        selfView.mainfullTextView.text = viewModel.modifyDefaultModel?.recordContents
        selfView.mainTextView.textColor = .white
        selfView.mainfullTextView.textColor = .white
        selfView.titleTextView.textColor = .white
        
        textViewDidChange(selfView.mainfullTextView)
    }
    
    override func configureUI() {
        super.configureUI()
    }
    
    private func bind() {
        selfView.imageAddButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.configureImagePicker()
            }).disposed(by: disposeBag)
        
        viewModel.state
            .subscribe(onNext: { [weak self] info in
                
                for controller in (self?.navigationController?.viewControllers ?? [UIViewController()] )  as Array {
                    if controller.isKind(of: MyRecordViewController.self) {
                        self?.navigationController?.popToViewController(controller, animated: true)
                        UserDefaults.standard.set(1, forKey: "reload")
                        break
                    }
                    
                    if controller.isKind(of: HomeViewController.self) {
                        self?.navigationController?.popToViewController(controller, animated: true)
                        break
                    }
                    if controller.isKind(of: AllRecordCateDetailViewController.self) {
                        self?.navigationController?.popToViewController(controller, animated: true)
                        
                        break
                    }
                    if controller.isKind(of: AllRecordSearchDetailViewController.self) {
                        self?.navigationController?.popToViewController(controller, animated: true)
                        break
                    }
                }
                for controller in (self?.navigationController?.viewControllers ?? [UIViewController()] )  as Array {
                    if controller.isKind(of: AllRecordViewController.self) {
                        self?.navigationController?.popToViewController(controller, animated: true)
                        break
                    }
                }
                
                
                
                // print("here is \(self?.navigationController!.viewControllers ?? [UIViewController()])")
            }).disposed(by: disposeBag)
        
        viewModel.loading
            .subscribe(onNext: { [weak self] loading in
                
            }).disposed(by: disposeBag)
        
        selfView.lockButton.rx.tap
            .scan(false) { (lastState, newValue) in
                !lastState
            }
            .bind(to: selfView.lockButton.rx.isSelected)
            .disposed(by: disposeBag)
        
    }
    
    
    func configureImagePicker() {
        var config = YPImagePickerConfiguration()
        config.wordings.libraryTitle = "보관함"
        config.wordings.cameraTitle = "카메라"
        config.wordings.next = "다음"
        config.colors.tintColor = .white
        UINavigationBar.appearance().backgroundColor = .black
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
                UINavigationBar.appearance().backgroundColor = .mainBackGround
            }
        }
        present(picker, animated: true, completion: nil)
    }
    
    func setlongTextView(_ category:String) {
        if category == "한 줄 감상" {
            selfView.mainfullTextView.isHidden = true
            self.view.addSubview(scrollView)
            scrollView.addSubview(selfView)
            scrollView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.width.equalToSuperview()
                make.bottom.equalToSuperview()
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            }
            selfView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.width.equalToSuperview()
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
            }
            selfView.textCoverView.translatesAutoresizingMaskIntoConstraints = false
            selfView.textCoverView.heightAnchor.constraint(equalToConstant: Constant.mainHeight * 0.49).isActive = true
            scrollView.showsVerticalScrollIndicator = false
            return
        }
        
        selfView.remainTextCount.text = "0/796"
        selfView.mainTextView.isHidden = true
        self.view.addSubview(scrollView)
        scrollView.addSubview(selfView)
        scrollView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        
        selfView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        selfView.mainfullTextView.translatesAutoresizingMaskIntoConstraints = false
        selfView.mainfullTextView.heightAnchor.constraint(equalToConstant: Constant.mainHeight * 0.49).isActive = true
        scrollView.showsVerticalScrollIndicator = false
    }
    
    private func getCate(cate:String) -> String {
        switch cate {
        case "한 줄 감상":
            return "A_LINE"
        case "노래 속 나의 이야기":
            return "STORY"
        case "내 인생의 OST":
            return "OST"
        case "나만의 가사해석":
            return "LYRICS"
        case "자유 공간":
            return "FREE"
        default:
            return "FREE"
        }
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
        
        textView.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                guard constraint.constant != estimatedSize.height else {
                    return
                }
                // Disable the scroll
                if estimatedSize.height <  Constant.mainHeight * 0.49 {
                    constraint.constant =  Constant.mainHeight * 0.49
                } else {
                    constraint.constant = estimatedSize.height
                    // scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentSize.height-scrollView.bounds.height), animated: true)
                    
                }
            }
        }
    }
}


extension CreateViewController:CropViewControllerDelegate {
    func cropViewControllerDidCrop(_ cropViewController: CropViewController, cropped: UIImage, transformation: Transformation, cropInfo: CropInfo) {
        selfView.imageView.image = cropped
        awsHelper.uploadImage(cropped, sender: self, imageName: "record/\(viewModel.curTime)" , type: .record) { _ in
           
        }
        print("check Point\(viewModel.curTime)")
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
