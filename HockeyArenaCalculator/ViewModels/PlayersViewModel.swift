//
//  PlayersViewModel.swift
//  HockeyArenaCalculator
//
//  Created by Luis Fernando Mata on 4/16/19.
//  Copyright © 2019 Fernando. All rights reserved.
//

import Foundation

protocol PlayersViewModelType {
    var inputs: PlayersViewModelInputs { get }
    var outputs: PlayersViewModelOutputs { get }
}

protocol PlayersViewModelInputs {
    
}

protocol PlayersViewModelOutputs {
    
}

class PlayersViewModel: PlayersViewModelType, PlayersViewModelInputs, PlayersViewModelOutputs {
    
    init() {
        
    }
    
    var inputs: PlayersViewModelInputs { return self }
    var outputs: PlayersViewModelOutputs { return self }
}

