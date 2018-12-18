//
//  UIImage+Extension.swift
//  Sparrow
//
//  Created by Joey on 20/11/2017.
//

import Foundation
import UIKit
import Kingfisher

public extension UIImageView {
    public func setImageURL(_ string: String, placeholder: Image?, completionHandler: CompletionHandler? = nil) {
        let resource = URL(string: string)
        kf.setImage(with: resource, placeholder: placeholder, options: nil, progressBlock: nil, completionHandler: completionHandler)
    }
}

public extension UIImage {
    public static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    public static func generateQRImage(qrString: String, centerImageName: String) -> UIImage? {
        let stringData = qrString.data(using: String.Encoding.utf8, allowLossyConversion: false)
        //创建一个二维码的滤镜
        let qrFilter = CIFilter(name: "CIQRCodeGenerator")
        qrFilter?.setValue(stringData, forKey: "inputMessage")
        qrFilter?.setValue("H", forKey: "inputCorrectionLevel")
        let qrCIImage = qrFilter?.outputImage
        // 创建一个颜色滤镜,黑白色
        let colorFilter = CIFilter(name: "CIFalseColor")!
        colorFilter.setDefaults()
        colorFilter.setValue(qrCIImage, forKey: "inputImage")
        colorFilter.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
        colorFilter.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1")
        // 返回二维码image
        let codeImage = UIImage(ciImage: (colorFilter.outputImage!.transformed(by: CGAffineTransform(scaleX: 5, y: 5))))
        // 中间一般放logo
        if let iconImage = UIImage(named: centerImageName) {
            let rect = CGRect(x: 0, y: 0, width: codeImage.size.width, height: codeImage.size.height)
            UIGraphicsBeginImageContext(rect.size)
            codeImage.draw(in: rect)
            let avatarSize = CGSize(width: rect.size.width*0.3, height: rect.size.height*0.3)
            let x = (rect.width - avatarSize.width) * 0.5
            let y = (rect.height - avatarSize.height) * 0.5
            iconImage.draw(in: CGRect(x: x, y: y, width: avatarSize.width, height: avatarSize.height))
            let resultImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return resultImage
        }
        return codeImage
    }
    
    /// 保存到 Temporary Directory
    public func saveToTempDir(filename: String) -> String? {
        let tempDir = NSTemporaryDirectory()
        let filePath = "\(tempDir)\(filename.replacingOccurrences(of: "/", with: "")).jpeg"
        
        
        guard let image = self.jpegData(compressionQuality: 0.7) else { return nil }
        do {
            let url = URL(fileURLWithPath: filePath)
            try image.write(to: url)
        } catch let error {
            debugPrint(error.localizedDescription)
        }
        return filePath
    }
    
    /// 解决拍照出现 ext 丢失后图片方向错误的问题
    public func fixRotation() -> UIImage {
        guard imageOrientation != .up else { return self }
        
        UIGraphicsBeginImageContext(size)
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard image != nil else { return self }
        return image!
    }
}
