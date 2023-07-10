//
//  TableViewCell.swift
//  WorldNews
//
//  Created by Tawanda Chandiwana on 2023/07/10.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var tableViewCellContentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
