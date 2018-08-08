//
//  AppDelegate.swift
//  PFD
//
//  Created by Ahmed Durrani on 11/06/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var arrayOFSelectedItem : [RestaurantMenu]?

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.sharedManager().enable = true
            arrayOFSelectedItem = []
//        application.applicationIconBadgeNumber = 0
        _ =  Location.getLocation(withAccuracy:.block, frequency: .oneShot, onSuccess: { location in
            //            print("loc \(location.coordinate.longitude)\(location.coordinate.latitude)")
            DEVICE_LAT = location.coordinate.latitude
            DEVICE_LONG = location.coordinate.longitude
            
            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude: DEVICE_LAT, longitude: DEVICE_LONG)
            
            geoCoder.reverseGeocodeLocation(location, completionHandler: { placemarks, error in
                guard let addressDict = placemarks?[0].addressDictionary else {
                    return
                }
                
                // Print each key-value pair in a new row
                addressDict.forEach { print($0) }
                
                // Print fully formatted address
                if let formattedAddress = addressDict["FormattedAddressLines"] as? [String] {
                    //                    print(formattedAddress.joined(separator: ", "))
                    DEVICE_ADDRESS = formattedAddress.joined(separator: ", ")
                }
                
                // Access each element manually
                //                if let locationName = addressDict["Name"] as? String {
                //                }
                //                if let street = addressDict["Thoroughfare"] as? String {
                //                }
                //                if let city = addressDict["City"] as? String {
                //                }
                //                if let zip = addressDict["ZIP"] as? String {
                //                }
                //                if let country = addressDict["Country"] as? String {
                //                }
            })
            
        }, onError: { (last, error) in
            print("Something bad has occurred \(error)")
        })
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

