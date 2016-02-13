//
//  TableViewCell.swift
//  Instagram
//
//  Created by Gary Ghayrat on 2/4/16.
//  Copyright © 2016 Gary Ghayrat. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var viewImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
