//
//  UIView+Semantic.swift
//  Resturant
//
//  Created by Amr Elghadban on 4/21/19.
//  Copyright © 2019 adka. All rights reserved.
//

import UIKit

//extension UICollectionViewFlowLayout {
//
//    open override var flipsHorizontallyInOppositeLayoutDirection: Bool {
//        return true
//    }
//
//}

extension UIView {
    
    func alignLanguage() {
        let langDirection = LanguageHandler.shared.currentDirection
        changeToDirection(langDirection)
    }
    //swiftlint:disable:next cyclomatic_complexity
    func changeToDirection(_ direction: Direction) {
        
        if direction == .rtl {
            self.semanticContentAttribute = .forceRightToLeft
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            self.semanticContentAttribute = .forceLeftToRight
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        
        for view in subviews {
            //            if let view = self as? BaseUIView, view.shouldFlip() == false {
            //                break
            //            }
            print("Localize for \(view.classForCoder)")
            if view.semanticContentAttribute == .unspecified || view.semanticContentAttribute == .spatial || view.semanticContentAttribute == .playback {
                continue
            }
            
            if view.semanticContentAttribute == .forceLeftToRight || view.semanticContentAttribute == .forceRightToLeft {
                
            }
            
            checkSubViews(view: view)
            if direction == .rtl {
                view.semanticContentAttribute = .forceRightToLeft
            } else {
                view.semanticContentAttribute = .forceLeftToRight
            }
            switch view {
            case let label as UILabel:
                print(label.semanticContentAttribute)
                handleUILabelDirection(direction, label: label)
            case let textField as UITextField:
                handleUITextFieldDirection(direction, textField: textField)
            case let textView as UITextView:
                handleUITextViewDirection(direction, textView: textView)
            case let button as UIButton:
                handleUIButtonDirection(direction, button: button)
            case let searchBar as UISearchBar:
                handleUISearchBarDirection(direction, searchBar: searchBar)
            case let tableViewCell as UITableViewCell:
                let langDirection = LanguageHandler.shared.currentDirection
                tableViewCell.changeToDirection(langDirection)
            case let image as UIImageView:
                if image.tag == 200 {
                    print("image.tag : \(image.tag)")
                    handleUIImageViewRTL(image: image)
                }
            default: break
            }
        }
    }
    
    private func handleUISearchBarDirection(_ direction: Direction, searchBar: UISearchBar) {
        if let searchTextField: UITextField = searchBar.value(forKey: "_searchField") as? UITextField {
            if direction == .rtl {
                searchTextField.textAlignment = .right
            } else {
                searchTextField.textAlignment = .left
            }
        } 
    }
    
    private func handleUILabelDirection(_ direction: Direction, label: UILabel) {
        if label.textAlignment == .center { return }
        if direction == .rtl {
            label.textAlignment = .right
        } else {
            label.textAlignment = .left
        }
    }
    
    private func handleUITextFieldDirection(_ direction: Direction, textField: UITextField) {
        if textField.textAlignment == .center { return }
        if direction == .rtl {
            textField.textAlignment = .right
        } else {
            textField.textAlignment = .left
        }
    }
    
    private func handleUITextViewDirection(_ direction: Direction, textView: UITextView) {
        if textView.textAlignment == .center { return }
        if direction == .rtl {
            textView.textAlignment = .right
        } else {
            textView.textAlignment = .left
        }
    }
    
    private func handleUIButtonDirection(_ direction: Direction, button: UIButton) {
        if button.contentHorizontalAlignment == .center { return }
        let titleInsets = button.titleEdgeInsets
        let imageInsets = button.imageEdgeInsets
        let contentInsets = button.contentEdgeInsets
        guard button.imageView != nil else { return }
        guard let title = button.titleLabel, title.textAlignment != .center else { return }
        if direction == .rtl {
            button.contentHorizontalAlignment = .right
            button.titleEdgeInsets = UIEdgeInsets(top: titleInsets.top, left: titleInsets.right, bottom: titleInsets.bottom, right: titleInsets.left)
            button.imageEdgeInsets = UIEdgeInsets(top: imageInsets.top, left: imageInsets.right, bottom: imageInsets.bottom, right: imageInsets.left)
            button.contentEdgeInsets = UIEdgeInsets(top: contentInsets.top, left: contentInsets.right, bottom: contentInsets.bottom, right: contentInsets.left)
        } else {
            button.contentHorizontalAlignment = .left
            button.titleEdgeInsets = UIEdgeInsets(top: titleInsets.top, left: titleInsets.right, bottom: titleInsets.bottom, right: titleInsets.left)
            button.imageEdgeInsets = UIEdgeInsets(top: imageInsets.top, left: imageInsets.right, bottom: imageInsets.bottom, right: imageInsets.left)
            button.contentEdgeInsets = UIEdgeInsets(top: contentInsets.top, left: contentInsets.right, bottom: contentInsets.bottom, right: contentInsets.left)
        }
    }
    
    private func handleUIImageViewRTL(image: UIImageView) {
        image.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        //let flipped = originalImage.imageFlippedForRightToLeftLayoutDirection()
    }
    
    func resetRTLIfNeeded(imageView: UIImageView) {
        if imageView.tag != 200 {
            imageView.transform = CGAffineTransform(rotationAngle: 0)
        }
    }
    
    func checkSubViews(view: UIView) {
        if !view.subviews.isEmpty {
            view.changeToDirection(LanguageHandler.shared.currentDirection)
        }
    }
}
