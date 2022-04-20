//
//  ViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/04.
import RxSwift
import UIKit

class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()

    private var scrollView: UIScrollView?

    func enableScrollWhenKeyboardAppeared(scrollView: UIScrollView) {
        self.scrollView = scrollView
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func removeListeners() {
        NotificationCenter.default.removeObserver(self)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = .mainBackGround
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.view.backgroundColor = .mainBackGround
        setBarButtonItems()
        dismissKeyboardWhenTappedAround()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func setBarButtonItems() {
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "arrow-left")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "arrow-left")

        let label = UILabel()
        for titleValue in TabBarViewController.titles {
            if String(describing: type(of: self)) == titleValue.1 {
                label.text = titleValue.0
            }
        }

        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.tintColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        self.navigationItem.leftItemsSupplementBackButton = true // backbutton 안숨기기
        self.navigationItem.backButtonTitle = ""
    }

    @objc
    func didTapNotification() {
        print("noti")
    }

    func configureUI() {
        view.backgroundColor = .mainBackGround
    }

    @objc
    private func keyboardWillShow(notification: NSNotification) {
        guard let scrollView = scrollView else { return }
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil) // 주석처리하고 돌려보기

        var contentInset: UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
    }

    @objc
    private func keyboardWillHide(notification: NSNotification) {
        guard let scrollView = scrollView else { return }
        let contentInset: UIEdgeInsets = .zero
        scrollView.contentInset = contentInset
    }
}
