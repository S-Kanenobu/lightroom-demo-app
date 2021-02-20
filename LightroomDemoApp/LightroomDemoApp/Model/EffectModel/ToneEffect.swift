//
//  ToneEffect.swift
//  LightroomDemoApp
//
//  Created by softwareuser014 on 2020/12/03.
//
import UIKit

// 階調の変更
class ToneEffect: Effect {
    // 加工の適用
    static func apply(image: UIImage) -> UIImage {
        return OpenCV.tone(image)
    }
}
