//
//  LyricsPasteCreateViewController.swift
//  Omos
//
//  Created by sangheon on 2022/03/14.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import YPImagePicker
import Mantis
import Combine


class LyricsPasteCreateViewController:BaseViewController {
    
    
    let scrollView = UIScrollView()
    var cancellables = Set<AnyCancellable>()
    let selfView = LyricsPasteCreateView()
    let viewModel:LyricsPasteCreateViewModel
    let type:CreateType
    var totalString = 0
    var textTagCount = 0
    var textCellsArray = [Int](repeating: 0, count: 6)
    
    init(viewModel:LyricsPasteCreateViewModel,type:CreateType) {
        self.viewModel = viewModel
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selfView.tableView.delegate = self
        selfView.tableView.dataSource = self
        bind()
        
        //        if type == .create { setCreateViewinfo() }
        //        else { setModifyView() }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        selfView.tableView.layoutIfNeeded()
        selfView.tableView.reloadData()
        // selfView.tableHeightConstraint!.update(offset: selfView.tableView.contentSize.height)
        print(selfView.tableView.contentSize.height)
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
        //        var mainText:String?
        //        if category == "한 줄 감상" {
        //            mainText = selfView.mainTextView.text
        //        } else {
        //            mainText = selfView.mainfullTextView.text
        //        }
        //        let backImage = selfView.imageView.image
        //        guard let titleText = selfView.titleTextView.text,
        //              let text = mainText else {
        //                  //alert
        //                  print("alert here")
        //                  return
        //              }
        //
        //        if type == .create {
        //            viewModel.saveRecord(cate: getCate(cate: category), content: text, isPublic: !(selfView.lockButton.isSelected), musicId: viewModel.defaultModel.musicId, title: titleText, userid: UserDefaults.standard.integer(forKey: "user"))
        //        } else {
        //            var recordContent = ""
        //            if  selfView.mainTextView.text != viewModel.modifyDefaultModel?.recordTitle {
        //                recordContent = selfView.mainTextView.text
        //            } else {
        //                recordContent = selfView.mainfullTextView.text
        //            }
        //
        //            viewModel.updateRecord(postId: viewModel.modifyDefaultModel?.recordID ?? 0, request: .init(contents: recordContent, title: selfView.titleTextView.text ))
        //        }
        
        // }
        
        //    private func setCreateViewinfo() {
        //        selfView.cateLabel.text = "  | \(category)"
        //        selfView.circleImageView.setImage(with: viewModel.defaultModel.imageURL)
        //        selfView.musicTitleLabel.text = viewModel.defaultModel.musicTitle
        //        selfView.subMusicInfoLabel.text = viewModel.defaultModel.subTitle
        //        // get the current date and time
        //        let currentDateTime = Date()
        //
        //        // get the user's calendar
        //        let userCalendar = Calendar.current
        //
        //        // choose which date and time components are needed
        //        let requestedComponents: Set<Calendar.Component> = [
        //            .year,
        //            .month,
        //            .day
        //        ]
        //
        //        // get the components
        //        let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
        //
        //        selfView.createdField.text = "\(dateTimeComponents.year!) \(dateTimeComponents.month!) \(dateTimeComponents.day!)"
        //    }
        //
        //    func setModifyView() {
        //        print("check")
        //        print(viewModel.modifyDefaultModel!)
        //        selfView.cateLabel.text = "  | \(category)"
        //        selfView.circleImageView.setImage(with: viewModel.modifyDefaultModel?.music.albumImageURL ?? "")
        //        selfView.musicTitleLabel.text = viewModel.modifyDefaultModel?.music.musicTitle
        //        selfView.subMusicInfoLabel.text = viewModel.modifyDefaultModel?.music.artists.map { $0.artistName }.reduce("") { $0 + " \($1)" }
        //        selfView.titleTextView.text = viewModel.modifyDefaultModel?.recordTitle
        //        selfView.mainTextView.text = viewModel.modifyDefaultModel?.recordContents
        //        selfView.mainfullTextView.text = viewModel.modifyDefaultModel?.recordContents
        //        selfView.mainTextView.textColor = .white
        //        selfView.mainfullTextView.textColor = .white
        //        selfView.titleTextView.textColor = .white
        //
        //    }
    }
    
    func setScrollView() {
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
        scrollView.showsVerticalScrollIndicator = false
    }
    
    override func configureUI() {
        super.configureUI()
        setScrollView()
        
    }
    
    private func bind() {
        selfView.imageAddButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.configureImagePicker()
            }).disposed(by: disposeBag)
        
        viewModel.state
            .subscribe(onNext: { [weak self] info in
                //info is postid
                for controller in (self?.navigationController!.viewControllers ?? [UIViewController()] )  as Array {
                    if controller.isKind(of: MyRecordViewController.self) {
                        self?.navigationController?.popToViewController(controller, animated: true)
                        UserDefaults.standard.set(1, forKey: "reload")
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



extension LyricsPasteCreateViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.text == "레코드 가사해석을 입력해주세요" {
            textView.text = nil
            textView.textColor = .white
        }
        textView.tag = textTagCount
        textTagCount+=1
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "레코드 가사해석을 입력해주세요"
            textView.textColor = .lightGray
            //selfView.remainTextCount.text = "\(0)/250"
        }
      
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let inputString = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let oldString = textView.text, let newRange = Range(range, in: oldString) else { return true }
        let newString = oldString.replacingCharacters(in: newRange, with: inputString).trimmingCharacters(in: .whitespacesAndNewlines)
        let characterCount = newString.count
        textCellsArray[textView.tag] = characterCount
        totalString = textCellsArray.reduce(0,+)
        guard totalString <= 250 else { return false }
        selfView.remainTextCount.text =  "\(totalString)/250"
        

        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let size = textView.bounds.size
        let newSize = selfView.tableView.sizeThatFits(CGSize(width: size.width,
                                                             height: CGFloat.greatestFiniteMagnitude))
        print(newSize)
        if size.height != newSize.height {
            UIView.setAnimationsEnabled(false)
            selfView.tableView.beginUpdates()
            selfView.tableView.endUpdates()
            UIView.setAnimationsEnabled(true)
        }
    }
    
}


extension LyricsPasteCreateViewController:CropViewControllerDelegate {
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




// selfView.tableView.heightAnchor.constraint(equalToConstant: selfView.tableView.contentSize.height).isActive = true
//        selfView.tableView.heightAnchor.constraint(equalToConstant:400).isActive = true
//        selfView.tableView.publisher(for: \.contentSize)
//            .receive(on: RunLoop.main)
//            .sink { [weak self] size in
////                      self.myViewsHeightConstraint.constant = size.height
////                      self.tableView.isScrollEnabled = size.height > self.tableView.frame.height
//                if size.height > 1 {
//                    print( self?.selfView.tableView.contentSize.height)
//                    self?.selfView.tableHeightConstraint!.updateOffset(amount: size.height)
//                    self?.selfView.tableView.reloadData()
//                }
//
//                  }
//                  .store(in: &cancellables)
//selfView.tableHeightConstraint!.updateOffset(amount: 200)
