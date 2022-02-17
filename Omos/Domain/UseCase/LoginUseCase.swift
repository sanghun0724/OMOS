//
//  LoginUseCase.swift
//  Omos
//
//  Created by sangheon on 2022/02/17.
//

import Foundation

class LoginUseCase {
    
    private let musicRepository:MusicRepository
    
    func signIn(_ email:String,_ password:String) -> Void {
        musicRepository.signIn(email, password)
    }
    
    init(musicRepository:MusicRepository) {
        self.musicRepository = musicRepository
    }
    
}
