//
//  MusicRepository.swift
//  Omos
//
//  Created by sangheon on 2022/02/09.
//

import RxSwift

protocol MusicRepository {
    func fetchMusicList(keyword:String) -> Single<StockResult>
    func signIn(_ email:String,_ password:String) -> Single<LoginResponse>
    func localSignUp(_ email:String,_ password:String,_ nickname:String) -> Single<SignUpRespone>
    //func socialSignUp(_ token:Stirng,nickName:String) -> Void //더 뭐필요한지 서버랑 talk 
}
