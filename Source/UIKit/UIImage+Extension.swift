//
//  UIImage+Extension.swift
//  ClockWise
//
//  Created by AmrAngry on 5/18/20.
//

import UIKit

public extension UIImage {
    
    // MARK: - UIImage+Resize
    
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ quality: JPEGQuality) -> Data? {
        // return UIImageJPEGRepresentation(self, quality.rawValue)
        //  UIImagePNGRepresentation
        self.jpegData(compressionQuality: quality.rawValue)
    }

    /// Not recommended to use
    /// - Parameter expectedSizeInMb: expectedSizeInMb description
    /// - Returns: UIImage
    func compressTo(_ expectedSizeInMb: Int) -> UIImage? {
        let sizeInBytes = expectedSizeInMb * 1024 * 1024
        var needCompress: Bool = true
        var imgData: Data?
        var compressingValue: CGFloat = 1.0
        while (needCompress && compressingValue > 0.0) {
            if let data: Data = self.jpegData(compressionQuality: compressingValue) {
                if data.count < sizeInBytes {
                    needCompress = false
                    imgData = data
                } else {
                    compressingValue -= 0.1
                }
            }
        }
        
        if let data = imgData {
            if (data.count < sizeInBytes) {
                return UIImage(data: data)
            }
        }
        return nil
    }
    
    func compress(maxSizeInKB: Int) -> Data? {
        // Compress the image to reduce the file size
        guard var resizedData = self.jpegData(compressionQuality: 1.0) else {
            return nil
        }
        
        // Check if the compressed image size is within the specified limit
        let maxSizeInBytes = maxSizeInKB * 1024
        var compressionQuality: CGFloat = 1.0
        while resizedData.count > maxSizeInBytes && compressionQuality > 0.0 {
            compressionQuality -= 0.1
            if let newResizedData = self.jpegData(compressionQuality: compressionQuality) {
                resizedData = newResizedData
            }
        }
        
        // Create a new UIImage from the compressed data
        //UIImage(data: resizedData)
        return resizedData
    }
    
    func resizeImage(targetSize: CGSize) -> UIImage? {
        // Resize the image to the target size
        UIGraphicsBeginImageContextWithOptions(targetSize, false, 1.0)
        self.draw(in: CGRect(origin: CGPoint.zero, size: targetSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
    
    //image compression
    func resizeImage() -> UIImage {
        var actualHeight: Float = Float(self.size.height)
        var actualWidth: Float = Float(self.size.width)
        let maxHeight: Float = 841 //A4 default size I'm thinking about a document
        let maxWidth: Float = 594
        var imgRatio: Float = actualWidth / actualHeight
        let maxRatio: Float = maxWidth / maxHeight
        let compressionQuality: Float = 0.5
        //50 percent compression
        
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }
            else if imgRatio > maxRatio {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            }
            else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }
        
        let rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        self.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        let imageData = img!.jpegData(compressionQuality: CGFloat(compressionQuality))
        UIGraphicsEndImageContext()
        return UIImage(data: imageData!)!
    }
    
}

/// 'Image size quality compression, very close to WeChat picture compression strategy'
/*
 *
 ## Usage
 ```swift
 import WXImageCompress
 ```
 ```swift
 let image = UIImage(named: "imageName")!
 ```
 ```swift
 let thumbImage = image.wxCompress()
 ```


 ## Effect comparison
 | original | wechat | this |
 | --------   | -----   | ---- |
 | 1500 * 4000,  2.5MB | 800 * 2134, 325KB | 800 * 2134, 306KB |
 | 960 * 600,    210KB | 960 * 600, 147KB | 960 * 600, 147KB |
 | 800 * 1280,   595KB | 800 * 1280, 140KB | 800 * 1280, 142KB |
 | 1080 * 1920,  1.8MB | 720 * 1280, 139KB | 720 * 1280, 140KB |
 | 640 * 1136,   505KB | 640 * 1136, 68KB | 640 * 1136 69KB |
 | 4000 * 3000,  497KB | 1280 * 960, 140KB | 1280 * 960, 139KB |
 | 2560 * 1600,  232KB | 1280 * 800 112KB | 1280 * 800, 112KB |
 | 800 * 2138,   307KB | 800 * 2134, 649KB | 800 * 2138, 599KB |
 | 3351 * 1430,  386KB | 1874 * 800, 296KB | 1875 * 800, 286KB |
 | 3000 * 1300,   458KB | 1846 * 800 322KB | 1847 * 800, 307KB |
 | 8323 * 5793,  19.67MB | 1280 * 890, 428KB | 1280 * 891, 465KB |
 
 */
public extension UIImage {
    
    enum WechatCompressType {
        case session
        case timeline
    }
    
    /**
     wechat image compress
     
     - parameter type: session image boundary is 800, timeline is 1280
     
     - returns: thumb image
     */
    func wxCompress(type: WechatCompressType = .timeline) -> UIImage {
        let size = self.wxImageSize(type: type)
        let reImage = resizedImage(size: size)
        let data = reImage.jpegData(compressionQuality: 0.5)!
        return UIImage(data: data)!
    }
    
    /**
     get wechat compress image size
     
     - parameter type: session  / timeline
     
     - returns: size
     */
    private func wxImageSize(type: WechatCompressType) -> CGSize {
        var width = self.size.width
        var height = self.size.height
        
        var boundary: CGFloat = 1280
        
        // width, height <= 1280, Size remains the same
        guard width > boundary || height > boundary else {
            return CGSize(width: width, height: height)
        }
        
        // aspect ratio
        let s = max(width, height) / min(width, height)
        if s <= 2 {
            // Set the larger value to the boundary, the smaller the value of the compression
            let x = max(width, height) / boundary
            if width > height {
                width = boundary
                height = height / x
            } else {
                height = boundary
                width = width / x
            }
        } else {
            // width, height > 1280
            if min(width, height) >= boundary {
                boundary = type == .session ? 800 : 1280
                // Set the smaller value to the boundary, and the larger value is compressed
                let x = min(width, height) / boundary
                if width < height {
                    width = boundary
                    height = height / x
                } else {
                    height = boundary
                    width = width / x
                }
            }
        }
        return CGSize(width: width, height: height)
    }
    
    /**
     Zoom the picture to the specified size
     
     - parameter newSize: image size
     
     - returns: new image
     */
    private func resizedImage(size: CGSize) -> UIImage {
        let newRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        var newImage: UIImage!
        UIGraphicsBeginImageContext(newRect.size)
        newImage = UIImage(cgImage: self.cgImage!, scale: 1, orientation: self.imageOrientation)
        newImage.draw(in: newRect)
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
}
