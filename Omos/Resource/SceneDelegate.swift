//
//  SceneDelegate.swift
//  Omos
//
//  Created by sangheon on 2022/02/04.
//

import UIKit
import KakaoSDKAuth
import AuthenticationServices
import RxSwift
import RxRelay
import Alamofire

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }
    

    var window: UIWindow?
    let disposeBag = DisposeBag()
    let kakaoValid = PublishRelay<Bool>()
    let appleValid = PublishRelay<Bool>()
    let localValid = PublishRelay<Bool>()
    

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        self.window?.overrideUserInterfaceStyle = .dark
        let uc = LoginUseCase(authRepository:AuthRepositoryImpl(loginAPI: LoginAPI()))
        let vm = LoginViewModel(usecase: uc)

        Observable.combineLatest(kakaoValid, appleValid,localValid)
        { $0 || $1 || $2 }
        .observe(on: MainScheduler.instance)
        .subscribe(onNext: { [weak self] valid in
            print("is it valid? \(valid)")
            if valid {
                self?.window?.rootViewController = TabBarViewController()
                self?.window?.makeKeyAndVisible()
                self?.window?.backgroundColor = .mainBackGround
            } else {
                self?.window?.rootViewController = LoginViewController(viewModel: vm)
                self?.window?.makeKeyAndVisible()
                self?.window?.backgroundColor = .mainBackGround
            }
        }).disposed(by: disposeBag)

        //local 확인  -> accesstoken 필요한 API 호출해봄
        let recordAPI = RecordAPI()
        recordAPI.select { [weak self] result in
            switch result {
            case .success:
                print("local success")
                self?.localValid.accept(true)
            case .failure:
                print("local fail")
                self?.localValid.accept(false)
            }
        }


        //snsToken 확인
        LoginViewModel.hasKaKaoToken { [weak self] valid in
            if valid {
                self?.kakaoValid.accept(true)
                print("kakaoValid true")
            } else {
                self?.kakaoValid.accept(false)
                print("kakaoValid false")
            }
        }

        let appleIDProvider = ASAuthorizationAppleIDProvider()
        print(UserDefaults.standard.string(forKey: "appleUser") ?? "XX")
          appleIDProvider.getCredentialState(forUserID:UserDefaults.standard.string(forKey: "appleUser") ?? "") { [weak self] (credentialState, error) in
              print(credentialState)
              switch credentialState {
              case .authorized:
                  self?.appleValid.accept(true)
                  // The Apple ID credential is valid.
                  print("해당 ID는 연동되어있습니다.")
              case .revoked:
                  self?.appleValid.accept(false)
                  // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
                  print("해당 ID는 연동되어있지않습니다.")
              case .notFound:
                  self?.appleValid.accept(false)
                  // The Apple ID credential is either was not found, so show the sign-in UI.
                  print("해당 ID를 찾을 수 없습니다.")
              default:
                  break
              }
          }
        
//        UserDefaults.standard.set("eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJvcmlnaW5AbmF2ZXIuY29tIiwiYXV0aCI6IlJPTEVfVVNFUiIsImV4cCI6MTY3ODM2MTMyMn0.q6YbvSmVFOoU2-Rnp1a9iav1TTlbdV0aPQQ_E8OiOv34XwGfPWCRrOriMkSOpo7MkddJo5O2QyRjqZk29b7jfw",forKey:"access")
//        UserDefaults.standard.set("eyJhbGciOiJIUzUxMiJ9.eyJleHAiOjE2NDY4MDM3MDV9.ZImb_c8Q6WSl2KaIDjMGs_tKfQPbgM57qDL6LFQFFnSksh0tGLxdflBVHQ4Ll76PglZg8ez86_QfyR6Jc75Lmw",forKey: "refresh")
//        UserDefaults.standard.set(71,forKey: "user")
//
//        let vm = LyricsViewModel(usecase: RecordsUseCase(recordsRepository: RecordsRepositoryImpl(recordAPI: RecordAPI())))
        
//        self.window?.rootViewController = LaunchViewController()
        self.window?.rootViewController = TabBarViewController()
        self.window?.makeKeyAndVisible()
        self.window?.backgroundColor = .mainBackGround
       
    }
    

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

