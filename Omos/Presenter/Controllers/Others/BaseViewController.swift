//
//  ViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/04.
import UIKit
import RxSwift

class BaseViewController:UIViewController {
    
    let disposeBag = DisposeBag()
    
    private var scrollView:UIScrollView?
    
    func enableScrollWhenKeyboardAppeared(scrollView:UIScrollView) {
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
        configureUI()
        setBarButtonItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setBarButtonItems() {
        //rigthBarButtonItems
        let notiButton = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: #selector(didTapNotification))
        notiButton.tintColor = .white
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(didTapSearchButton))
        searchButton.tintColor = .white
        let createButton = UIBarButtonItem(image: UIImage(systemName: "pencil"), style: .plain, target: self, action: #selector(didTapCreateButton))
        createButton.tintColor = .white
        self.navigationItem.rightBarButtonItems = [notiButton,searchButton,createButton]
        
        
        let label = UILabel()
        for titleValue in TabBarViewController.titles {
            if String(describing: type(of: self)) == titleValue.1  {
                print(titleValue)
                label.text = titleValue.0
            }
        }
        
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.tintColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
    }
    
    @objc func didTapCreateButton() {
        
        print("create")
    }
    
    @objc func didTapSearchButton() {
        let vc = SearchViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        print("search")
    }
    
    @objc func didTapNotification() {
        print("noti")
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
    }
    
    @objc private func keyboardWillShow(notification:NSNotification) {
        guard let scrollView = scrollView else { return }
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil) //주석처리하고 돌려보기
        
        var contentInset:UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
    }
    
    @objc private func keyboardWillHide(notification:NSNotification) {
        guard let scrollView = scrollView else { return }
        let contentInset:UIEdgeInsets = .zero
        scrollView.contentInset = contentInset
    }
    
    
    
}
