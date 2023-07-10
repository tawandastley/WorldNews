//
//  NewsCell.swift
//  WorldNews
//
//  Created by Tawanda Chandiwana on 2023/07/02.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleDescription: UILabel!
    @IBOutlet weak var articleDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellContentView.layoutMargins.bottom = 8.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
