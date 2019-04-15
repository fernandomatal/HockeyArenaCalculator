//
//  Menu.swift
//  HockeyArenaCalculator
//
//  Created by Luis Fernando Mata on 4/12/19.
//  Copyright © 2019 Fernando. All rights reserved.
//

import Foundation

enum MainMenu {
    case players
    case youths
    case lines
    
    var cellIdentifier: String {
        switch self {
        case .players:
            return "PlayersCell"
        case .youths:
            return "YouthsCell"
        case .lines:
            return "LinesCell"
        }
    }
    
    static let menuOrdered: [MainMenu] = [.players, .youths, .lines]
}
