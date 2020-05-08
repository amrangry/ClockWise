//
//  UIViewController+Extension.swift
//  Resturant
//
//  Created by Amr Elghadban on 4/8/19.
//  Copyright © 2019 ADKATech.com All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {
    /// load view controller FromNib
    ///
    /// - Returns: instance object of viewcontroller
    class func loadFromNib<T: UIViewController>() -> T {
        return T(nibName: reusableIdentifier, bundle: nil)
    }

    static func initFromNib() -> Self {
        func instanceFromNib<T: UIViewController>() -> T {
            return T(nibName: String(describing: self), bundle: nil)
        }
        return instanceFromNib()
    }
    
    static func initFrom<T: UIViewController>(storyBoard: UIStoryboard) -> T? {
        var viewController = storyBoard.instantiateViewController(withIdentifier: reusableIdentifier)
        if let container = viewController as? UINavigationController {
            viewController = container.viewControllers.first ?? UIViewController()
        }
        return viewController as? T
    }
}
