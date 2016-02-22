//
//  JournalTableViewCell.swift
//  Thrive
//
//  Created by Jonathan Lu on 1/27/16.
//  Copyright © 2016 UCSC OpenLab. All rights reserved.
//

import UIKit

class JournalTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var emoticonImageView: UIImageView!
    
    // MARK: Initialization

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
