//
//  PresetEffectsViewController.swift
//  LightroomDemoApp
//
//  Created by softwareuser014 on 2020/11/26.
//

import UIKit

 /*
    PresetEffectsViewController
    エフェクト機能のうち、「モノクローム」「セピア調」機能を保有する画面。
 */
class PresetEffectsViewController: UIViewController {
    
    var selectedFileName: String!
    // 加工用UIImage
    var effectImage: UIImage!
    
    @IBOutlet weak var effectsView: UIImageView!
    // 加工ボタン
    @IBOutlet weak var grayScaleButton: UIButton!
    @IBOutlet weak var sepiaButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ImagesViewControllerから取得した写真データを出力
        if let unwrappedSelectedFileName = selectedFileName {
            let selectedURL = DirectoryManager.getFileURL(fileName: unwrappedSelectedFileName)
            effectImage = UIImage(contentsOfFile: selectedURL.path)
            effectsView.image = effectImage
        }
    }
    
    
    // グレースケール変換ボタンのイベント
    @IBAction func grayScaleAction(_ sender: UIButton) {
        //UIButtonを無効化※２回以上押下するとエラーで落ちるため。今後、方針を確定したのちに修正する。
        grayScaleButton.isEnabled = false
        sepiaButton.isEnabled = true
        // モノクロームに加工してUIImageに出力
        effectsView.image = GrayScaleEffect.apply(image: effectImage)
    }
    // セピア変換ボタンのイベント
    @IBAction func sepiaAction(_ sender: UIButton) {
        //UIButtonを無効化※２回以上押下するとエラーで落ちるため。今後、方針を確定したのちに修正する。
        sepiaButton.isEnabled = false
        grayScaleButton.isEnabled = true
        // セピアに加工してUIImageに出力
        effectsView.image = SepiaEffect.apply(image: effectImage)
        
    }
    
    //  ImagesViewControllerへ戻る
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)

    }
}
