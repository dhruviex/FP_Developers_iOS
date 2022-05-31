//
//  TableViewCell.swift
//  FP_Developers_iOS
//
//  Created by Karthik Reddy Rondla on 2022-05-30.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    
    
    @IBOutlet weak var cell_btn: UIButton!
    @IBOutlet weak var lbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
