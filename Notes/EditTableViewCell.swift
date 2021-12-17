//
//  EditTableViewCell.swift
//  Notes
//
//  Created by SK on 16.12.2021.
//

import UIKit

class EditTableViewCell: UITableViewCell {
    @IBOutlet weak var editTitleTextField: UITextField!
    @IBOutlet weak var editDetailTextField: UITextView!
    @IBOutlet weak var editImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
