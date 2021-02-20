//
//  CameraViewController.swift
//  LightroomDemoApp
//
//  Created by softwareuser014 on 2020/11/11.
//

import UIKit

// CameraViewController(ライブラリ、カメラ機能を持った画面)
class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    // 写真フォルダの情報
    public var imageFolders: [ImageFolder] = []
    // 写真フォルダテーブル
    @IBOutlet weak var imageFilesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //CameraViewControllerクラスでimageFilesTableViewのデータソースを指定
        imageFilesTableView.dataSource = self
        imageFilesTableView.delegate = self
        // 初期画面で設定する情報
        loadData()
    }
    // 初期画面で設定する情報
    private func loadData() {
        // all,deleteディレクトリのURLを取得
        let imageAllDirURL = DirectoryManager.getFileURL(directoryURL: DirectoryManager.getDocumentsURL(), fileName: ImageFoldersEnum.all.rawValue)
        let imageDeleteDirURL = DirectoryManager.getFileURL(directoryURL: DirectoryManager.getDocumentsURL(), fileName: ImageFoldersEnum.delete.rawValue)
        // allディレクトリ(全ての写真を保存するディレクトリ)が存在するかの確認
        if (!DirectoryManager.exists(directoryURL: DirectoryManager.getDocumentsURL(), key: ImageFoldersEnum.all.rawValue)) {
            // 存在していない場合、allディレクトリを取得
            DirectoryManager.createDirectory(directoryURL: imageAllDirURL)
        }
        // deleteディレクトリ(削除済みの写真を保存するディレクトリ)が存在するかの確認
        if (!DirectoryManager.exists(directoryURL: DirectoryManager.getDocumentsURL(), key: ImageFoldersEnum.delete.rawValue)) {
            // 存在していない場合、deleteディレクトリを取得
            DirectoryManager.createDirectory(directoryURL: imageDeleteDirURL)
        }
        // all delete のimageFoldersが存在するかの確認
        if (imageFolders.count <= 0) {
            // 存在しない場合、all,deleteディレクトリ を作成
            imageFolders.append(ImageFolder(imageFileImageName: ImageFoldersEnum.all.rawValue, imageFileName: "すべての写真", imageDirURL: imageAllDirURL))
            imageFolders.append(ImageFolder(imageFileImageName: ImageFoldersEnum.delete.rawValue, imageFileName: "削除済み", imageDirURL: imageDeleteDirURL))
        }
    }
    // 写真フォルダテーブルの設定
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 写真フォルダのフォルダ数
        return imageFolders.count
    }
    // Table Viewのcellにデータを設定
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = imageFilesTableView.dequeueReusableCell(withIdentifier: "ImageFilesTableViewCell", for: indexPath) as! ImageFilesTableViewCell
        let imageFolder = imageFolders[indexPath.row]
        // ImageFilesTableViewCellの各項目に値を設定
        cell.imageFolderImageView.image = UIImage(named:imageFolder.imageFileImageName)
        cell.imageFolderNameLabel.text = imageFolder.imageFileName
        return cell
    }
    
    // カメラを起動する
    @IBAction func startCameraPickerController(_ sender: Any) {
        // UIImagePickerController(画像を取得するクラス)をインスタンス化
        let sourceType: UIImagePickerController.SourceType = UIImagePickerController.SourceType.camera
        // アプリが起動する端末にカメラがあるかどうかの確認
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker, animated: true)
        } else {
            print("Error: This device doesn't have a camera.")
        }
    }
    // シャッターボタンを押下した時の動作(確認画面に切り替わる)
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]){
        // 写真データ(image)
        let image = info[.originalImage] as! UIImage
        // Documentsディレクトリ のURLを取得
        let imageDirectoryName = DirectoryManager.getDocumentsURL().appendingPathComponent(ImageFoldersEnum.all.rawValue)
        // 写真データの名前を付けて、そのURLを取得
        let fileURL = DirectoryManager.getFileURL(directoryURL:imageDirectoryName)
        // 写真データ(image)をdocumentsへ保存
        DirectoryManager.saveImage(image: image, path: fileURL)
        // 写真データ(image)を写真アプリに保存する
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        // UIImagePickerController １枚おきにカメラ機能を閉じる
        self.dismiss(animated: true)
    }
    // imageFoldersをImagesViewControllerへ渡す。
    internal override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toImagesViewController" {
            if let indexPath = imageFilesTableView.indexPathForSelectedRow {
                if let destination = segue.destination as? ImagesViewController {
                    destination.imageFolders = imageFolders[indexPath.row]
                } else {
                    print("Error: Failed to prepare ImagesViewController.")
                }
            }
        }
    }
}
