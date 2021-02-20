//
//  ContrastEffect.swift
//  LightroomDemoApp
//
//  Created by softwareuser014 on 2020/12/03.
//

import UIKit
// コントラストの変更
class ContrastEffect: Effect {
    // 加工の適用
    static func apply(image: UIImage) -> UIImage {
        return OpenCV.contrast(image)
    }
}
