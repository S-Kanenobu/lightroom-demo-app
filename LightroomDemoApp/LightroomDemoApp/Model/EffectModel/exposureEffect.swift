//
//  ExposureEffect.swift
//  LightroomDemoApp
//
//  Created by softwareuser014 on 2020/12/03.
//

import UIKit
// 露光量の変更
class ExposureEffect: Effect {
    // 加工の適用
    static func apply(image: UIImage) -> UIImage {
        return OpenCV.exposure(image)
    }
}
