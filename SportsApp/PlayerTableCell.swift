//
//  PlayerTableCell.swift
//  SportsApp
//
//  Created by Strongman on 7/13/17.
//  Copyright © 2017 Ilya. All rights reserved.
//

import UIKit

class PlayerTableCell: UITableViewCell
{
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var iconFlag: UIImageView!
    @IBAction func onTapDelete(_ sender: Any) {
        if (delegate != nil) {
            delegate?.onDeleteUser(index: index)
        }
    }
    
    var index: Int = 0
    var delegate: PlayerTableCellDelegate?;
}
