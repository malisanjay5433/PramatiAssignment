//
//  CountryCell.swift
//  PramatiAssignment
//
//  Created by Sanjay Mali on 06/12/17.
//  Copyright © 2017 Sanjay Mali. All rights reserved.
//
import UIKit
class CountryCell: UITableViewCell {
    @IBOutlet weak var name_Lbl: UILabel!
    @IBOutlet weak var population_Lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
