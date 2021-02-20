//
//  ImageFolder.swift
//  LightroomDemoApp
//
//  Created by softwareuser014 on 2020/11/19.
//

import UIKit
// 画像　フォルダを定義
struct ImageFolder {
    
    // 写真フォルダのイメージ名
    private(set) public var imageFileImageName: String
    // 写真フォルダ名
    private(set) public var imageFileName: String
    // 写真ファイルのディレクトリURL
    private(set) public var imageDirURL: URL
    // 初期化
    init(imageFileImageName: String, imageFileName: String, imageDirURL: URL) {
        self.imageFileImageName = imageFileImageName
        self.imageFileName = imageFileName
        self.imageDirURL = imageDirURL
    }
}
