//
//  UserListTableViewCell.swift
//  TestApplication
//
//  Created by Андрей Илалов on 10.11.2017.
//  Copyright © 2017 Андрей Илалов. All rights reserved.
//

import UIKit

class UserListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
