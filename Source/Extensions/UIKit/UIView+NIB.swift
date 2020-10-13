//
//  UIView+NIB.swift
//  ClockWise
//
//  Created by Amr Elghadban (AmrAngry) on 8/3/20.
//  Copyright © 2020 adka. All rights reserved.
//

import UIKit

public extension UIView {
    
    //    static func nib() -> UINib {
    //        UINib(nibName: self.reusableIdentifier, bundle: Bundle.main)
    //    }
    
    class func nib() -> UINib {
       func instanceNIB() -> UINib {
          let nib = UINib(nibName: reusableIdentifier, bundle: nil)
          return nib
       }
       return instanceNIB()
    }
    
    class func initFromNib() -> Self {
       func instanceFromNib<T: UIView>() -> T {
          let view = nib().instantiate(withOwner: nil, options: nil).first as! T //swiftlint:disable:this force_cast
          return view
       }
       return instanceFromNib()
    }

}
