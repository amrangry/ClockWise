//
//  UIView+Extension.swift
//  Resturant
//
//  Created by Amr Elghadban (AmrAngry) on 7/17/19.
//  Copyright © 2019 adka. All rights reserved.
//

import UIKit

public extension UIView {
    
    func makeShadow(_ color: UIColor = UIColor.black) {
        // add the shadow to the base view
        //NOTE: must have an backgroundColor rather than defult and clear
        //NOTE: can't have clipsToBounds or masksToBounds equal true for shadow
        //NOTE: can't add border with shadow in same time as border need clipsToBounds or masksToBounds to be true
        let view = self
        view.clipsToBounds = false
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 4.0
        //        imageViewContainer?.backgroundColor = .red
        //        imageViewContainer?.clipsToBounds = false
        //        imageViewContainer?.layer.shadowColor = UIColor.black.cgColor
        //        imageViewContainer?.layer.shadowOpacity = 1
        //        imageViewContainer?.layer.shadowOffset = CGSize.zero
        //        imageViewContainer?.layer.shadowRadius = 10
        //        imageViewContainer?.layer.shadowPath = UIBezierPath(roundedRect: imageViewContainer?.bounds ?? CGRect.zero, cornerRadius: 10).cgPath
        //        imageViewContainer?.layer.cornerRadius = 45
        //        imageViewContainer?.layer.masksToBounds = true
    }
    
    static func createShadow(for view: UIView?) {
       
        view?.clipsToBounds = false
        view?.backgroundColor = .white
        view?.layer.shadowColor = UIColor.black.cgColor
        view?.layer.shadowOffset = CGSize(width: 3, height: 3)
        view?.layer.shadowOpacity = 0.7
        view?.layer.shadowRadius = 4.0
        //adding corner Radius
        view?.layer.cornerRadius = 45
    }
}
