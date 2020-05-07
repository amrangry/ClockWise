//
//  UIImageView+Extension.swift
//  ADKATech.com
//
//  Created by AmrAngry on 4/14/19.
//  Copyright © 2020 ADKA Tech. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with urlString: String, _ placeHolder: UIImage? ) {
        guard let url = URL(string: urlString) else { return }
        setImage(url, placeHolder)
    }
    
    func setImage(_ url: URL?, _ placeHolderImage: Image?) {
        setImage(url, placeHolderImage, completionHandler: nil)
    }
    
    func setImage(_ url: URL?, _ placeHolderImage: Image?, completionHandler: ((Image?) -> Void)? ) {
        self.kf.indicatorType = .activity
        
        let modifier = AnyModifier { request in
            var modifiedRequest = request
            // replace "Access-Token" with the field name you need, it's just an example
            //r.setValue("sd", forHTTPHeaderField: "Access-Token")
            let headers = CommonHttpHeaders().default
            headers?.forEach { (arg) in
                let (key, value) = arg
                modifiedRequest.setValue(value, forHTTPHeaderField: key)
            }
            return modifiedRequest
        }
        //[.forceRefresh]
        let options: KingfisherOptionsInfo = [.requestModifier(modifier),
                                              .transition(ImageTransition.fade(1.0))]
        self.kf.setImage(with: url, placeholder: placeHolderImage, options: options, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                completionHandler?(value.image)
            case .failure(let error):
                print(error)
                completionHandler?(nil)
            }
        }
    }
}

////  KingfisherManager.shared.defaultOptions = [.requestModifier(TokenPlugin(token:"abcdef123456"))]
//class TokenPlugin: ImageDownloadRequestModifier {
//    let token: String
//
//    init(token: String) {
//        self.token = token
//    }
//
//    func modified(for request: URLRequest) -> URLRequest? {
//        var request = request
//        request.addValue(token, forHTTPHeaderField: "token")
//        return request
//    }
//}
