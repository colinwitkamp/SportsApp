//
//  ViewController.swift
//  SportsApp
//
//  Created by Strongman on 7/13/17.
//  Copyright © 2017 Ilya. All rights reserved.
//

import UIKit

protocol PlayerTableCellDelegate {
    func onDeleteUser(index: Int)
}

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, PlayerTableCellDelegate {
    
    @IBOutlet weak var playersTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Player", style: .plain, target: self, action: #selector(newPlayer))
        playersTableView.dataSource = self;
        playersTableView.delegate = self;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        
        playersTableView.reloadData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func newPlayer(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "segue_newPlayerVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.sharedInstance.getPlayers().count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PlayerTableCell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! PlayerTableCell
        let player = DataManager.sharedInstance.getPlayers()[indexPath.row];
        cell.lblName.text = "\(player.name!), \(player.age)"
        cell.iconFlag.image = UIImage(named: DataManager.flags[player.country!]!);
        cell.index = indexPath.row
        cell.delegate = self
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segue_detailVC", sender: DataManager.sharedInstance.players[indexPath.row])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "segue_detailVC" {
            if let vc = segue.destination as? UserDetailVC {
                vc.player = sender as? Player
            }
        }
    }
    
    func onDeleteUser(index: Int) {
        DataManager.sharedInstance.removePlayerByIndex(index: index)
        playersTableView.reloadData()
    }
}

