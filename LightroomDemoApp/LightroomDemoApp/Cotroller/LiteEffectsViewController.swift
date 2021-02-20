//
//  LiteEffectsViewController.swift
//  LightroomDemoApp
//
//  Created by softwareuser014 on 2020/11/26.
//

import UIKit

/*
    LiteEffectsViewController
    エフェクト機能のうち、「露光量」「コントラスト」機能を保有する画面。
 */
class LiteEffectsViewController: UIViewController {
    
    var selectedFileName: String!
    // 加工用UIImage
    var effectImage: UIImage!
    @IBOutlet weak var effectsView: UIImageView!
    // 「露光量」の加工を適用するボタン
    @IBOutlet weak var exposureButton: UIButton!
    @IBOutlet weak var contrastButton: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ImagesViewControllerから取得した写真データを出力
        if let unwrappedSelectedFileName = selectedFileName {
            let selectedURL = DirectoryManager.getFileURL(fileName: unwrappedSelectedFileName)
            effectImage = UIImage(contentsOfFile: selectedURL.path)
            effectsView.image = effectImage
        }
    }
    // 露光量変換ボタンのイベント
    @IBAction func exposureAction(_ sender: UIButton) {
        //UIButtonを無効化※２回以上押下するとエラーで落ちるため。今後、方針を確定したのちに修正する。
        exposureButton.isEnabled = false
        exposureButton.setTitleColor(UIColor.gray, for: .normal)
        // 露光量を変更
        effectsView.image = ExposureEffect.apply(image: effectsView.image!)
    }
    // コントラストを変更
    @IBAction func contrastAction(_ sender: UIButton) {
        //UIButtonを無効化
        contrastButton.isEnabled = false
        contrastButton.setTitleColor(UIColor.gray, for: .normal)
        // コントラストを変更
        effectsView.image = ContrastEffect.apply(image: effectsView.image!)
    }
    
    // ImagesViewControllerに戻る
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
