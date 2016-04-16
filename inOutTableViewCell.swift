//
//  inOutTableViewCell.swift
//  testTutti
//
//  Created by hugo roman on 9/20/15.
//  Copyright © 2015 hugo roman. All rights reserved.
//

import UIKit

class inOutTableViewCell: UITableViewCell {

    @IBOutlet weak var timestampInOut: UILabel!
    
    @IBOutlet weak var actionInOut: UILabel!
    
    @IBOutlet weak var deviceInOut: UILabel!
    
    @IBOutlet weak var whereInOut: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
