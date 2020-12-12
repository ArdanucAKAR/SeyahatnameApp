//
//  PostsCell.swift
//  Seyahatname
//
//  Created by Ardanuc AKAR on 10.12.2020.
//

import UIKit

class PostsCell: UITableViewCell {
    @IBOutlet var lblUsername: UILabel!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var lblLikeCount: UILabel!
    @IBOutlet var imgPlace: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func btnLikeClick(_ sender: Any) {}
}
