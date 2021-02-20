//
//  ImageManagerViewController.swift
//  LightroomDemoApp
//
//  Created by softwareuser014 on 2020/11/17.
//

import UIKit

 /*
    ImageManagerViewController
    前の画面(ImagesViewController)で選択した画面を表示する画面。
    以下の機能を保管。
    ・エフェクト機能の画面へ遷移する機能
    ・削除済み(delete)ディレクトリへ移動する機能
 */
 class ImageManagerViewController: UIViewController {

    // 写真データ
    @IBOutlet weak var imageView: UIImageView!
    // ImageViewControllerで設定した写真データのURL
    private var selectedImageURL : URL!
    private var selectedImage: UIImage!
    private var selectedFileName: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        // ImageViewControllerで設定した写真データのURLを編集画面へ表示
        imageView.image = UIImage(contentsOfFile: selectedImageURL.path)
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
    }
    // 前の画面へ戻る
    @IBAction func cancellButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    // 次の画面へ遷移
    @IBAction func effectsViewButton(_ sender: Any) {
        performSegue(withIdentifier: "toEffectsViewController", sender: nil)
    }
    // 次の画面へ遷移する前の準備
    internal override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEffectsViewController" {
            let EffectsVC = (segue.destination as? UITabBarController)!
            let LiteEffectsVC: LiteEffectsViewController = (EffectsVC.viewControllers?.first as? LiteEffectsViewController)!
            let SliderEffectsVC: SliderEffectsViewController = (EffectsVC.viewControllers?[1] as? SliderEffectsViewController)!
            let ColorEffectsVC: ColorEffectsViewController = (EffectsVC.viewControllers?[2] as? ColorEffectsViewController)!
            let PresetEffectsVC: PresetEffectsViewController = (EffectsVC.viewControllers?[3] as? PresetEffectsViewController)!
            LiteEffectsVC.selectedFileName = selectedImageURL.lastPathComponent
            SliderEffectsVC.selectedFileName = selectedImageURL.lastPathComponent
            ColorEffectsVC.selectedFileName = selectedImageURL.lastPathComponent
            PresetEffectsVC.selectedFileName = selectedImageURL.lastPathComponent
        }
    }
}
