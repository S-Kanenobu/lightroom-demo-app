//
//  ImageFilesTableViewCell.swift
//  LightroomDemoApp
//
//  Created by softwareuser014 on 2020/11/19.
//

import UIKit

// フォルダ情報を格納する　UITableViewCell
class ImageFilesTableViewCell: UITableViewCell {

    @IBOutlet weak var imageFolderImageView: UIImageView!
    @IBOutlet weak var imageFolderNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    internal override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
