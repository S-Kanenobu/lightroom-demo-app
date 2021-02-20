//
//  DirectoryManager.swift
//  LightroomDemoApp
//
//  Created by softwareuser014 on 2020/11/18.
//

import UIKit
// ディレクトリ操作の関数
struct DirectoryManager {
    // ディレクトパスとファイル(ディレクトリ)名を引数に、保存先のファイル(ディレクトリ)のURLを取得
    static func getFileURL(directoryURL: URL,fileName: String) -> URL {
        return directoryURL.appendingPathComponent(fileName)
    }
    // 保存先のディレクトリURLを引数に、保存先のファイル名(撮影年月日＋時の名前をつけている)のURLを取得
    static func getFileURL(directoryURL: URL) -> URL {
        // 日付を付加したファイル名を取得
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmssSSS"
        let fileName: String? = "IMG\(formatter.string(from: Date())).jpg"
        // ディレクトリのパスにファイル名をつなげてファイルのフルパスを作成
        return directoryURL.appendingPathComponent(fileName!)
    }
    // ディレクトリの作成
    static func createDirectory(directoryURL: URL) -> Void {
        let fileManager = FileManager.default
        do {
            try fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
        } catch {
            // エラーの場合
            print(error)
        }
    }
    // Documentsディレクトリ のファイルURLを取得
    static func getDocumentsURL() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    // ディレクト内のURL群のうち条件(IMG)に当てはまるもの(URL)を取得
    static func getDirectoryURLs(directoryURL: URL) -> [URL] {
        let directoryURLs: [URL]
        var selectedDirectoryURLs: [URL] = []
        do {
            // 写真データのURL一覧を取得
            directoryURLs = try FileManager.default.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil)
            // ※特定の値が含まれているファイルのみを取得
            for directoryFile in directoryURLs {
                if directoryFile.path.range(of: "IMG") != nil {
                    selectedDirectoryURLs.append(directoryFile)
                }
            }
            return selectedDirectoryURLs
        } catch {
            return []
        }
    }
    // 指定したディレクトリ内に条件に当てはまるものが存在するかの確認
    static func exists(directoryURL: URL, key: String) -> Bool {
        let directoryURLs: [URL]
        var result: Bool = false
        do {
            // 写真データのURL一覧を取得
            directoryURLs = try FileManager.default.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil)
            // ※特定の値が含まれているファイルのみを取得(この処理が入らない場合は、下７行は不要。)
            for selectedDirectoryURL in directoryURLs {
                if selectedDirectoryURL.path.range(of: key) != nil {
                    result = true
                    break
                }
            }
            return result
        } catch {
            return result
        }
    }
    // ディレクトリ 内の selectedNumber番目のUIImageを取得
    static func getImage(directoryURL: URL, selectedNumber: Int) -> UIImage {
        let directoryURLs = getDirectoryURLs(directoryURL: directoryURL)
        return UIImage(contentsOfFile: directoryURLs[selectedNumber].path)!
    }
    // ファイルの書き込み
    static func saveImage (image: UIImage, path: URL ) -> Void {
        let jpgImageData = image.jpegData(compressionQuality:0.5)
        do {
            try jpgImageData!.write(to: path, options: .atomic)
        } catch {
            print(error)
        }
    }
    static func getFileURL(fileName: String) -> URL {
        let imageFoldersEnum = ImageFoldersEnum.self
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let allURL = documentsURL.appendingPathComponent(imageFoldersEnum.all.rawValue)
        return allURL.appendingPathComponent(fileName)
    }
}
