//
//  RestauranteTableViewCell.swift
//  FoodTracker
//
//  Created by Macosx on 13/3/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import Foundation
import UIKit

class RestauranteTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var imagenRestaurante: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
