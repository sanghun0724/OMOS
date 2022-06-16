//
//  ProfileChangeViewController.swift
//  Omos
//
//  Created by sangheon on 2022/03/18.
//

import Kingfisher
import RxCocoa
import RxSwift
import UIKit
import YPImagePicker

class ProfileChangeViewController: BaseViewController {
    let selfView = ProfileChangView()
    let viewModel: ProfileViewModel
    lazy var awss3Helper = AWSS3Helper()

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        selfView.nickNameField.text = viewModel.currentMyProfile?.profile.nickname
        guard let image = viewModel.currentMyProfile?.profile.profileURL else {
            return
        }
        selfView.profileImageView.setImage(with: image)
    }

    override func configureUI() {
        super.configureUI()
        self.view.addSubview(selfView)

        selfView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    override func bind() {
        selfView.cameraView.rx.tap
            .subscribe(onNext: { [weak self] _ in
                let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)

                alert.view.tintColor = .white
                    alert.addAction(UIAlertAction(title: "앨범에서 선택", style: .default, handler: { _ in
                        self?.configCamera()
                    }))

                    alert.addAction(UIAlertAction(title: "프로필 사진 삭제", style: .default, handler: { _ in
                        self?.selfView.profileImageView.image = UIImage(named: "defaultprofile")
                    }))

                    alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { _ in
                        print("User click Dismiss button")
                    }))

                    self?.present(alert, animated: true, completion: {
                        print("completion block")
                    })
            }).disposed(by: disposeBag)

        selfView.buttonView.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let text = self?.selfView.nickNameField.text else {
                    // alert nickname입력해주세요
                    print("alert")
                    return
                }
                let imageUrl = "https://omos-image.s3.ap-northeast-2.amazonaws.com/profile/\(Account.currentUser).png"
                let request = ProfileUpdateRequest(nickname: text, profileUrl: imageUrl, userId: Account.currentUser)
                self?.viewModel.updateProfile(request: request)

                if ImageCache.default.isCached(forKey: imageUrl) {
                              print("Image is cached")
                              ImageCache.default.removeImage(forKey: imageUrl)
                     }
                NotificationCenter.default.post(name: NSNotification.Name.profileReload, object: nil, userInfo: nil)
                       }).disposed(by: disposeBag)

        viewModel.updateProfileState
            .subscribe(onNext: { [weak self] state in
                if state {
                    self?.navigationController?.popViewController(animated: true)
                } else {
                    self?.selfView.nickNameField.layer.borderWidth = 1
                    self?.selfView.nickNameField.layer.borderColor = .some(UIColor.mainOrange.cgColor)
                    self?.selfView.warningLabel.text = "닉네임이 중복되었습니다."
                    self?.selfView.warningLabel.isHidden = false
                }
            }).disposed(by: disposeBag)
    }

    func configCamera() {
        var config = YPImagePickerConfiguration()
        config.wordings.libraryTitle = "보관함"
        config.wordings.cameraTitle = "카메라"
        config.wordings.next = "다음"
        config.colors.tintColor = .white
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, cancelled in
            if let photo = items.singlePhoto {
                print(photo.image) // Final image selected by the user
                self.selfView.profileImageView.image = photo.image
                self.awss3Helper.uploadImage(photo.image, sender: self, imageName: "profile/\(Account.currentUser)", type: .profile) { _ in
                    DispatchQueue.main.async {
                        self.selfView.loadingView.isHidden = true
                    }
                }
                self.selfView.loadingView.isHidden = false
                picker.dismiss(animated: true, completion: nil)
            }
            if cancelled {
                print("Picker was canceled")
                picker.dismiss(animated: true, completion: nil)
//                self.tabBarController?.tabBar.isHidden = true
            }
        }

        present(picker, animated: true, completion: nil)
    }
}

class ProfileChangView: BaseView {
    let profileImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "defaultprofile"))
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()

    let cameraView: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.backgroundColor = .mainGrey6
        button.tintColor = .white
        return button
    }()

    let mentionLabel: UILabel = {
        let label = UILabel()
        label.text = "프로필 사진과 닉네임을 입력해주세요."
        label.textColor = .white
        return label
    }()

    let nickNameField: UITextField = {
        let field = UITextField()
        field.placeholder = "닉네임을 입력해주세요"
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.layer.cornerRadius = Constant.loginCorner
        field.layer.masksToBounds = true
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.textColor = .white
        field.backgroundColor = .black
        field.layer.borderColor = .some(UIColor.mainOrange.cgColor)
        return field
    }()

    let buttonView: UIButton = {
       let button = UIButton()
        button.backgroundColor = .mainGrey4
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.mainGrey7, for: .normal)
        return button
    }()

    let warningLabel: UILabel = {
       let label = UILabel()
        label.text = "닉네임이 중복 되었습니다"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .mainOrange
        label.textAlignment = .left
        return label
    }()

    let loadingView = LoadingView()

    override func layoutSubviews() {
        super.layoutSubviews()

        layoutIfNeeded()
        cameraView.layer.cornerRadius = cameraView.height / 2
        cameraView.layer.masksToBounds = true

        profileImageView.layer.cornerRadius = profileImageView.height / 2
        profileImageView.layer.masksToBounds = true
    }

    override func configureUI() {
        super.configureUI()
        self.addSubview(profileImageView)
        self.addSubview(cameraView)
        self.addSubview(mentionLabel)
        self.addSubview(nickNameField)
        self.addSubview(buttonView)
        self.addSubview(warningLabel)
        self.addSubview(loadingView)

        profileImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.256)
            make.height.equalTo(profileImageView.snp.width)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(24)
        }

        cameraView.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(profileImageView)
            make.height.width.equalTo(profileImageView).multipliedBy(0.34)
        }

        mentionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(profileImageView.snp.bottom).offset(34)
          //  make.top.equalToSuperview().offset(34)
            mentionLabel.sizeToFit()
        }

        nickNameField.snp.makeConstraints { make in
            make.top.equalTo(mentionLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalToSuperview().multipliedBy(0.06)
        }

        warningLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameField.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(16)
            warningLabel.sizeToFit()
        }
        warningLabel.isHidden = true

        buttonView.snp.makeConstraints { make in
            make.leading.trailing.height.equalTo(nickNameField)
            make.bottom.equalToSuperview().offset(-34)
        }

        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        loadingView.isHidden = true
    }
}
