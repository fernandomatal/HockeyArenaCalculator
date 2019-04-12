//
//  Player.swift
//  HockeyArenaCalculator
//
//  Created by Luis Fernando Mata on 4/11/19.
//  Copyright © 2019 Fernando. All rights reserved.
//

import Foundation
import Realm

class Player: RLMObject {
    // Basic data
    var name: String
    var age: Int
    var quality: Int
    var potential: Int
    
    // Attributes
    var goalie: Int = 0
    var defense: Int = 0
    var offense: Int = 0
    var shooting: Int = 0
    var passing: Int = 0
    var speed: Int = 0
    var strength: Int = 0
    
    var preferredPosition: PlayerPosition?
    
    init(name: String, age: Int, quality: Int, potential: Int, preferredPosition: PlayerPosition? = nil) {
        self.name = name
        self.age = age
        self.quality = quality
        self.potential = potential
        super.init()
    }
    
    /// Set player attributes, default values are 0
    func setAttributes(goalie: Int = 0,
    defense: Int = 0,
    offense: Int = 0,
    shooting: Int = 0,
    passing: Int = 0,
    speed: Int = 0,
    strength: Int = 0) {
        self.goalie = goalie
        self.defense = defense
        self.offense = offense
    }
}

enum PlayerPosition {
    case goalie
    case defender
    case center
    case wing
    case dynamic
    case none
}
