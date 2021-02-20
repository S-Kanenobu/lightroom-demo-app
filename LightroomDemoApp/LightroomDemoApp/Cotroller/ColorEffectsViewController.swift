//
//  ColorEffectsViewController.swift
//  LightroomDemoApp
//
//  Created by softwareuser014 on 2020/11/26.
//

import UIKit

/*
    ColorEffectsViewController
    エフェクト機能のうち、「色相」「彩度」機能を保有する画面。
 */
class ColorEffectsViewController: UIViewController {
    private var selectedFileName: String!
    // 加工用UIImage
    var effectImage: UIImage!
    @IBOutlet weak var effectsView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 前の画面(ImageManagerViewController)から値を取得
        if let unwrappedSelectedFileName = selectedFileName {
            let selectedURL = DirectoryManager.getFileURL(fileName: unwrappedSelectedFileName)
            effectImage = UIImage(contentsOfFile: selectedURL.path)
            effectsView.image = effectImage
        }
    }
    // 前の画面(ImageManagerViewController)へ戻る
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)

    }
}
