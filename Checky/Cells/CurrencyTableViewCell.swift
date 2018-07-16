//
//  CurrencyTableViewCell.swift
//  Checky
//
//  Created by Robert Ogiba on 16.07.2018.
//  Copyright © 2018 Robert Ogiba. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var valueView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        labelView.text = nil
        valueView.text = nil
    }
}
