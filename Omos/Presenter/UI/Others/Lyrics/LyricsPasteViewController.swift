//
//  LyricsPastViewController.swift
//  Omos
//
//  Created by sangheon on 2022/03/14.
//

import Foundation
import UIKit

class LyricsPasteViewController: BaseViewController {
    let selfView = LyricsPastView()
    let scrollView = UIScrollView()
    let defaultModel: RecordSaveDefaultModel
    var barHeight: CGFloat = 44

    init(defaultModel: RecordSaveDefaultModel) {
        self.defaultModel = defaultModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        selfView.mainLyricsTextView.delegate = self
        selfView.circleImageView.setImage(with: self.defaultModel.imageURL)
        selfView.musicTitleLabel.text = self.defaultModel.musicTitle
        selfView.subMusicInfoLabel.text = self.defaultModel.subTitle
        setSelfView()
        barHeight = self.navigationController?.navigationBar.height ?? 44
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.rightBarButtonItems?.removeAll()
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(didTapDone))
        doneButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = doneButton
        registerNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeNotifications()
    }
    
    private func removeNotifications() {
        removeListeners()
        NotificationCenter.default.removeObserver(self, name: .keyBoardShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .keyBoardHide, object: nil)
    }
    
    @objc
    func KeyboardHideNoti(_ notification: Notification) {
        selfView.addSubview(selfView.lastView)
        selfView.lastView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(Constant.mainHeight * 0.13)
        }
    }

    @objc
    func KeyboardShowNoti(_ notification: Notification) {
        guard let keyboardHeight = notification.userInfo?["keyboardHeight"] as? CGFloat else { return }
        selfView.lastView.removeFromSuperview()
        self.view.addSubview(selfView.lastView)
        self.view.bringSubviewToFront(selfView.lastView)
        selfView.lastView.snp.remakeConstraints { make in
            make.height.equalTo(selfView.inputAccessoryViewContentHeightSum_mx + 20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-keyboardHeight)
        }
    }

    @objc
    func didTapDone() {
        if selfView.mainLyricsTextView.text == "해석하고 싶은 가사를 복사해 붙여놓고,\n줄바꿈을 통해 마디구분을 해주세요." || selfView.mainLyricsTextView.text.isEmpty {
            print("비어이")
            return
        }
        var lyricsArr: [String] = []

        guard let text = selfView.mainLyricsTextView.text else { return }

        text.enumerateSubstrings(in: text.startIndex..., options: .byParagraphs) { substring, _, _, _ in
            if  let substring = substring,
                !substring.isEmpty {
                    lyricsArr.append(substring)
            }
        }

        let rp = RecordsRepositoryImpl(recordAPI: RecordAPI())
        let uc = RecordsUseCase(recordsRepository: rp)
        let vm = LyricsViewModel(usecase: uc)
        vm.lyricsStringArray = lyricsArr
        vm.defaultModel = self.defaultModel
        let vc = LyricsPasteCreateViewController(viewModel: vm, type: .create)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func configureUI() {
        super.configureUI()
     
    }
    
    private func setSelfView() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(selfView)

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
       
        selfView.circleImageView.layoutIfNeeded()
        selfView.circleImageView.layer.cornerRadius = selfView.circleImageView.height / 2
        selfView.circleImageView.layer.masksToBounds = true
        selfView.mainLyricsTextView.translatesAutoresizingMaskIntoConstraints = false
        selfView.mainLyricsTextView.heightAnchor.constraint(equalToConstant: selfView.top_bottomHeightSum - barHeight - 20).isActive = true
        scrollView.showsVerticalScrollIndicator = false
    }
    
    private func registerNotifications() {
        enableScrollWhenKeyboardAppeared(scrollView: scrollView)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardShowNoti(_:)), name: .keyBoardShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardHideNoti(_:)), name: .keyBoardHide, object: nil)
    }
}

extension LyricsPasteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if selfView.mainLyricsTextView.text == "해석하고 싶은 가사를 복사해 붙여놓고,\n줄바꿈을 통해 마디구분을 해주세요." {
            selfView.mainLyricsTextView.text = nil
            selfView.mainLyricsTextView.textColor = .white
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if selfView.mainLyricsTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            selfView.mainLyricsTextView.text = "해석하고 싶은 가사를 복사해 붙여놓고,\n줄바꿈을 통해 마디구분을 해주세요."
            selfView.mainLyricsTextView.textColor = .mainGrey7
            selfView.remainTextCount.text = "\(0)/250"
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let inputString = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let oldString = textView.text, let newRange = Range(range, in: oldString) else { return true }
        let newString = oldString.replacingCharacters(in: newRange, with: inputString).trimmingCharacters(in: .whitespacesAndNewlines)
        let characterCount = newString.count

        guard characterCount <= 250 else {
            let action = UIAlertAction(title: "확인", style: .default) { _ in
            }
            action.setValue(UIColor.mainOrange, forKey: "titleTextColor")
            self.presentAlert(title: "", with: action, message: "글자 제한수를 초과하였습니다. 글자 제한수를 확인해 주세요.", isCancelActionIncluded: false, preferredStyle: .alert)
            return false
        }
        selfView.remainTextCount.text = "\(characterCount)/250"

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
                if estimatedSize.height < selfView.top_bottomHeightSum - barHeight - 20 {
                    constraint.constant = selfView.top_bottomHeightSum - barHeight - 20
                } else {
                    constraint.constant = estimatedSize.height
                    // scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentSize.height-scrollView.bounds.height), animated: true)

                }
            }
        }
    }
}
