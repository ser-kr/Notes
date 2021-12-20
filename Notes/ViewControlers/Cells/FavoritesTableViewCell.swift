//
//  FavoritesTableViewCell.swift
//  Notes
//
//  Created by SK on 24.12.2021.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    //@IBOutlet weak var tLabel: UILabel!
    
    
    
    var note: Note?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
       // tLabel.text = note?.headText //good?.name
        

    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
