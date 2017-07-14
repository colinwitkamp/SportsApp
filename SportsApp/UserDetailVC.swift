//
//  UserDetailVC.swift
//  SportsApp
//
//  Created by Strongman on 7/13/17.
//  Copyright © 2017 Ilya. All rights reserved.
//

import UIKit

class UserDetailVC: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var imgCountry: UIImageView!
    
    var player: Player? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (player != nil) {
            lblName.text = player?.name;
            lblAge.text = String(format:"%d", (player?.age)!)
            lblWeight.text = String(format:"%f", (player?.weight)!)
            lblHeight.text = String(format:"%f", (player?.height)!)
            imgCountry.image = UIImage(named: DataManager.flags[(player?.country)!]!)
        }
    }
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
