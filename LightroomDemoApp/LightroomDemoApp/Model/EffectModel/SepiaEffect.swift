//
//  SepiaEffect.swift
//  LightroomDemoApp
//
//  Created by softwareuser014 on 2020/12/03.
//

import UIKit
// セピアに加工
class SepiaEffect: Effect {
    // 加工を適用
    static func apply(image: UIImage) -> UIImage {
        let ciImage = CIImage(image: image)
        let ciFilter = CIFilter(name: "CISepiaTone")
        ciFilter?.setValue(ciImage, forKey: kCIInputImageKey)
        ciFilter?.setValue(1.0, forKey: kCIInputIntensityKey)
        let sepiaImage: CIImage = (ciFilter?.outputImage)!
        return UIImage(ciImage: sepiaImage)
    }
}
