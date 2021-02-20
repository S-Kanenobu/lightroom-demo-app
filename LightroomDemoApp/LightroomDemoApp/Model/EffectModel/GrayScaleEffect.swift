//
//  GrayScaleEffect.swift
//  LightroomDemoApp
//
//  Created by softwareuser014 on 2020/11/30.
//

import UIKit
//グレースケールに加工
class GrayScaleEffect: Effect {
    // 画像を加工
    static func apply(image: UIImage) -> UIImage {
        return OpenCV.grayScale(image)
    }
}
