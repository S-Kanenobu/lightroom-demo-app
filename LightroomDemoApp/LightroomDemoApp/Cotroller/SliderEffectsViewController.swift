//
//  SliderEffectsViewController.swift
//  LightroomDemoApp
//
//  Created by softwareuser014 on 2020/11/26.
//

import UIKit

/*
    SliderEffectsViewController
    エフェクト機能のうち、「周辺露光量」「階調」「モザイク」機能を保有する画面。
 */
class SliderEffectsViewController: UIViewController {
    var selectedFileName: String!
    // 加工用UIImage
    var effectImage: UIImage!
    @IBOutlet weak var effectsView: UIImageView!
    // 加工ボタン
    @IBOutlet weak var toneButton: UIButton!
    
    override func viewDidLoad() {
        // ImagesViewControllerから取得した写真データを出力
        super.viewDidLoad()
        // 前の画面(ImageManagerViewController)から値を取得
        if let unwrappedSelectedFileName = selectedFileName {
            let selectedURL = DirectoryManager.getFileURL(fileName: unwrappedSelectedFileName)
            effectImage = UIImage(contentsOfFile: selectedURL.path)
            effectsView.image = effectImage
        }
    }
    // 階調を変更
    @IBAction func toneAction(_ sender: UIButton) {
        //UIButtonを無効化
        toneButton.isEnabled = false
        toneButton.setTitleColor(UIColor.gray, for: .normal)
        // 階調に加工してUIImageに出力// 修正中
        //effectsView.image = ToneEffect.apply(image: effectsView.image!)
    }
    //
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)

    }
}
