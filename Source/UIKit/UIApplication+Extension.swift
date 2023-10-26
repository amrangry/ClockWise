//
//  UIApplication+Extension.swift
//  Restaurant
//
//  Created by Amr Elghadban on 3/30/19.
//  Copyright © 2019 ADKATech.com All rights reserved.
//

import Foundation
import UIKit

public extension UIApplication {
    
    /// you have the key window
    @objc var currentWindow: UIWindow? {
        //        connectedScenes
        //        .filter({$0.activationState == .foregroundActive})
        //        .map({$0 as? UIWindowScene})
        //        .compactMap({$0})
        //        .first?.windows
        //        .filter({$0.isKeyWindow}).first
        
        UIApplication.shared.windows.first(where: { (window) -> Bool in window.isKeyWindow})
    }
    
    @objc
    static func topVisibleViewController(controller: UIViewController? = UIApplication.shared.currentWindow?.rootViewController ) -> UIViewController? {
        //        let xyz = UIApplication.shared.windows.first?.rootViewController
        //        let xyz2 = UIApplication.shared.keyWindow?.rootViewController
        //        let xyz3 = UIApplication.shared.currentWindow
        
        //        if let windowxyz = UIApplication.shared.windows.first(where: { (window) -> Bool in window.isKeyWindow}) {
        //           //your code
        //             // you have the key window
        //            print(windowxyz)
        //        }
        /* Workaround for Objective c as the default value will not be settled from func signature */
        let root = controller ?? UIApplication.shared.keyWindow?.rootViewController
        if let navigationController = root as? UINavigationController {
            return topVisibleViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = root as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topVisibleViewController(controller: selected)
            }
        }
        if let presented = root?.presentedViewController {
            return topVisibleViewController(controller: presented)
        }
        return root
    }
    
    static func showPDFFile(fileURL: URL) {
        let documentController = UIDocumentInteractionController(url: fileURL)
        documentController.delegate = topVisibleViewController() as? UIDocumentInteractionControllerDelegate
        documentController.presentPreview(animated: true)
    }
    
}
