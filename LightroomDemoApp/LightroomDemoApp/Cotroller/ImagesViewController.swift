//
//  ImagesViewController.swift
//  LightroomDemoApp
//
//  Created by softwareuser014 on 2020/11/17.
//

import UIKit

// ImagesViewController(選択したフォルダ内の写真一覧の画面)
class ImagesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    // CameraViewControllerから受け取った値を設定
    private var imageFolders: ImageFolder!
    // ImageManagerViewControllerに渡すための選択した写真データ変数を宣言
    private var selectedImageURL : URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // collectionView に写真データを表示
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Cell はストーリーボードで設定したセルのID
        let imageCell =
                    collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        // Tag番号を使ってImageViewのインスタンス生成
        let imageView = imageCell.contentView.viewWithTag(1) as! UIImageView
        // 写真データをimageViewへ格納
        imageView.image = DirectoryManager.getImage(directoryURL: imageFolders.imageDirURL, selectedNumber: indexPath.row)
        return imageCell
    }
    // サイズをスクリーン合わせたCellのサイズを出力する。※UICollectionViewDelegateFlowLayoutの設定が必要※
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 横のスペース調整
        let horizontalSpace: CGFloat = 2
        let cellSize: CGFloat = self.view.bounds.width/2 - horizontalSpace
        // 正方形に返すためにwidth, heightを同じにする
        return CGSize(width: cellSize, height: cellSize)
    }
    // section数は１つ
    internal func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
    }
    // 要素数を入れる、要素以上の数字を入れると表示エラー。
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DirectoryManager.getDirectoryURLs(directoryURL: imageFolders.imageDirURL).count
    }
    
    // 選択した写真データをImageManagerViewControllerへ送る
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedImageURL = DirectoryManager.getDirectoryURLs(directoryURL: imageFolders.imageDirURL)[indexPath.row]
        if selectedImageURL != nil {
            performSegue(withIdentifier: "toImageManagerViewController", sender: nil)
        }
    }
    internal override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toImageManagerViewController") {
            let ImageManagerVC: ImageManagerViewController = (segue.destination as? ImageManagerViewController)!
            ImageManagerVC.selectedImageURL = selectedImageURL
        }
    }
}
