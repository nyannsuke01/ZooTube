//
//  AppDelegate.swift
//  ZooTube
//
//  Created by user on 2020/03/14.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let hours = 19
    let minute = 00

    var notificationGranted = true

    var isFirst = true


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //Firebese 使用
        FirebaseApp.configure()

        // 許可を促すアラートを出します。

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound]) { (granted, error) in
            self.notificationGranted = granted
            if let error = error{
                print("エラーです。")
            }
        }

        isFirst = false
        setNotification()


        return true
    }

    func setNotification(){
        var notificationTime = DateComponents()
        var trigger:UNNotificationTrigger

        notificationTime.hour = hours
        notificationTime.minute = minute
        trigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: true)
        let content = UNMutableNotificationContent()
        content.title = "19時になりました！"
        content.body = "ニュースが更新されました！！"
        content.sound = .default

        //通知スタイル
        let request = UNNotificationRequest(identifier: "uuid", content: content, trigger: trigger)
        //通知をセット
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        setNotification()
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

