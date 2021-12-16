//
//  MainTableViewCell.swift
//  Notes
//
//  Created by SK on 16.12.2021.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var notesMainLabel: UILabel!
    
    var note: Note?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        notesMainLabel.text = note?.headText //good?.name
//        qtyLabel.text = "\(good?.quantity ?? 0)"
//        descriptionLabel.text = good?.description
    }

    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
