//
//  AppDelegate.swift
//  Todoey
//
//  Created by Nisa Aydin on 17.02.2024.
//

import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
    
        return true
    }

    // MARK: UISceneSession Lifecycle

    func applicationWillResignActive(_ application: UIApplication) {
        // örneğin uygulama açıkken telefona bir şey olduğunda tetiklenme eğilimindedir. Diyelim ki kullanıcı bir çağrı alırsa, kullanıcının veri kaybetmemesi için bir şeyler yapılacak yöntem buradır.
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Uygulamanız ekrandan kaybolduğunda örneğin ana ekran düğmesine bastığınızda veya farklı bir uygulamayı açtığınızda gerçekleşir. Uygulama arka plana geçtiğinde yani.
        print("applicationDidEnterBackground")
    }
    func applicationWillTerminate(_ application: UIApplication) {
        // Butemelde uygulamanızın sonlandırılacağı noktadır.Bu kullanıcı tarafından tetiklenebilir veya sistem tarafından tetiklenebilir.
        print("applicationWillTerminate")
       
    }
 
}
    
