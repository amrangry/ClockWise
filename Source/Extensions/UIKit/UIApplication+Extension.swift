//
//  UIApplication+Extension.swift
//  Resturant
//
//  Created by Amr Elghadban on 3/30/19.
//  Copyright © 2019 ADKATech.com All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    
    /// you have the key window
    var currentWindow: UIWindow? {
//        connectedScenes
//        .filter({$0.activationState == .foregroundActive})
//        .map({$0 as? UIWindowScene})
//        .compactMap({$0})
//        .first?.windows
//        .filter({$0.isKeyWindow}).first
        
        UIApplication.shared.windows.first(where: { (window) -> Bool in window.isKeyWindow})
    }

    static func topViewController(controller: UIViewController? = UIApplication.shared.currentWindow?.rootViewController ) -> UIViewController? {
//        let xyz = UIApplication.shared.windows.first?.rootViewController
//        let xyz2 = UIApplication.shared.keyWindow?.rootViewController
//        let xyz3 = UIApplication.shared.currentWindow
        
//        if let windowxyz = UIApplication.shared.windows.first(where: { (window) -> Bool in window.isKeyWindow}) {
//           //your code
//             // you have the key window
//            print(windowxyz)
//        }
        
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
    static func showPDFFile(fileURL: URL) {
        let documentController = UIDocumentInteractionController(url: fileURL)
        documentController.delegate = topViewController() as? UIDocumentInteractionControllerDelegate
        documentController.presentPreview(animated: true)
    }
    
}
