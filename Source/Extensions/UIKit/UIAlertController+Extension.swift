//
//  UIAlertController+Extension.swift
//  onNet
//
//  Created by AmrAngry on 9/13/19.
//  Copyright © 2019 ADKATech.com. All rights reserved.
//

import UIKit

public extension UIAlertController {
    // UIAlertController.alert("Login Error", message: errorObj.localizedDescription).action("OK").presentOn(self)
    static func alert(title: String, message: String, completion: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok".localized(), style: .default) { (_) in
            completion?()
        }
        alert.addAction(action)
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
    
    func alert(title: String, message: String, completion: (() -> Void)?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok".localized(), style: .default) { (_) in
            completion?()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    private func show() {
        DispatchQueue.main.async {
            if let popoverController = self.popoverPresentationController {
                popoverController.sourceView = self.view //to set the source of your alert
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
                popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
            }
            UIApplication.topViewController()?.present(self, animated: true, completion: nil)
        }
    }
    
    func show(message: String) {
        self.show(title: "", message: message)
    }
    
    func show(title: String, message: String) {
        self.title = title
        self.message = message
        let alertAction = UIAlertAction(title: "OK".localized(), style: .default, handler: { action in
            switch action.style {
            case .default:
                debugPrint("default")
            case .cancel:
                debugPrint("cancel")
            case .destructive:
                debugPrint("destructive")
            @unknown default:
                fatalError()
            }
        })
        self.addAction(alertAction)
        self.show()
    }
    
    func show(title: String, message: String, okAction okActionHanlder: ((UIAlertAction) -> Void)?, cancelAction cancelActionHanlder: ((UIAlertAction) -> Void)?) {
        self.title = title
        self.message = message
        self.addAction(UIAlertAction(title: "OK".localized(), style: .default, handler: okActionHanlder))
        self.addAction(UIAlertAction(title: "Cancel".localized(), style: .default, handler: cancelActionHanlder))
        self.show()
    }
}
