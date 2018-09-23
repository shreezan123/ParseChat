//
//  ChatCell.swift
//  ParseChat
//
//  Created by Shrijan Aryal on 9/23/18.
//  Copyright © 2018 Shrijan Aryal. All rights reserved.
//

import UIKit
import Parse

class ChatCell: UITableViewCell {
    

    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    
    var chatsObj:PFObject!{
        didSet{
            messageLbl.text = chatsObj.object(forKey: "text") as? String
            let user = chatsObj.object(forKey:"user") as? PFUser
            let userName = user?.username
            self.usernameLbl.text = userName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
