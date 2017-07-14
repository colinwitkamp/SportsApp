//
//  DataManager.swift
//  SportsApp
//
//  Created by Strongman on 7/13/17.
//  Copyright © 2017 Ilya. All rights reserved.
//

import Foundation

class DataManager {
    static let sharedInstance = DataManager();
    static let countries: [String] = ["France", "Germany", "USA", "Spain", "Australia"];
    static let flags: [String : String] = ["France" : "flag_fra", "Germany" : "flag_ger", "USA" : "flag_usa", "Spain" : "flag_esp", "Australia" : "flag_aus"];
    
    var players = [Player]()
    
    func newPlayer(player: Player) {
        players.append(player)
    }
    
    func getPlayers() -> [Player] {
        return players
    }
    
    func removePlayer(player: Player) {
        for i in 0 ..< players.count {
            if (players[i].name == player.name && players[i].country == player.country && players[i].age == player.age) {
                players.remove(at: i)
                return
            }
        }
    }
    
    func removePlayerByIndex(index: Int) {
        players.remove(at: index)
    }
}
