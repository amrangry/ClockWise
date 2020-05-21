//
//  RTLUICollectionViewFlowLayout.swift
//  Resturant
//
//  Created by Amr Elghadban (AmrAngry) Apple on 7/7/19.
//  Copyright © 2019 adka. All rights reserved.
//

import UIKit

public class RTLUICollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    public override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return true
    }
    
//    override var developmentLayoutDirection: UIUserInterfaceLayoutDirection {
//        return UIUserInterfaceLayoutDirection.rightToLeft
//    }
    
    // when ever the bounds change, call layoutAttributesForElementsInRect:
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        let result = englishLayout(in: rect)
//        return result
////        let appLang = LanguageManager.shared.currentAppleLanguage()
////        switch appLang {
////        case .ar:
////            let result = englishLayout(in: rect)//arabicLayout(in: rect)
////            return result
////        case .en:
////            let result = englishLayout(in: rect)
////            return result
////        }
//        
//    }

    func englishLayout(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributesForElementsInRect = super.layoutAttributesForElements(in: rect)
        var newAttributesForElementsInRect = [UICollectionViewLayoutAttributes]()
        // use a value to keep track of left margin
        var leftMargin: CGFloat = 0.0
        
        for attributes in attributesForElementsInRect! {
            
            let refAttributes = attributes
            
            guard attributes.representedElementCategory != .supplementaryView else {
                leftMargin = 0
                var newLeftAlignedFrame = refAttributes.frame
                newLeftAlignedFrame.origin.x = leftMargin
                refAttributes.frame = newLeftAlignedFrame
                newAttributesForElementsInRect.append(refAttributes)
                continue
            }
            
            let left = self.sectionInset.left
            let right = self.sectionInset.right
            let xPoint = refAttributes.frame.origin.x
            let width = refAttributes.frame.width
            print( "left: \(left) right: \(right) width: \(width) x: \(xPoint)")
            // assign value if next row
            if xPoint == left {
                leftMargin = self.sectionInset.left
            } else {
                // set x position of attributes to current margin
                var newLeftAlignedFrame = refAttributes.frame
                newLeftAlignedFrame.origin.x = leftMargin
                refAttributes.frame = newLeftAlignedFrame
            }
            // calculate new value for current margin
            leftMargin += refAttributes.frame.size.width + 0
            newAttributesForElementsInRect.append(refAttributes)
        }
        return newAttributesForElementsInRect
    }
    
}
