//
//  Notification.swift
//  Omos
//
//  Created by sangheon on 2022/05/23.
//

import UIKit

class LocalNotification {
    
    let userNotiCenter = UNUserNotificationCenter.current()
    
    // 사용자에게 알림 권한 요청
    func requestAuthNoti() {
        let notiAuthOptions = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])
        userNotiCenter.requestAuthorization(options: notiAuthOptions) { (success, error) in
            if let error = error {
                print(#function, error)
            }
        }
    }
    
    func requestSendNoti(seconds: Double) {
        let notiContent = UNMutableNotificationContent()
        notiContent.title = "알림 title"
        notiContent.body = "알림 body"
        notiContent.userInfo = ["targetScene": "splash"] // 푸시 받을때 오는 데이터
        
        // 알림이 trigger되는 시간 설정
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: notiContent,
            trigger: trigger
        )
        
        userNotiCenter.add(request) { (error) in
            print(#function, error)
        }
        
    }
}

// 추가
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // deep link처리 시 아래 url값 가지고 처리
        let url = response.notification.request.content.userInfo
        
        completionHandler()
    }
}
