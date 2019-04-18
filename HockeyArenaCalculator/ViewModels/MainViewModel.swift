//
//  MainViewModel.swift
//  HockeyArenaCalculator
//
//  Created by Luis Fernando Mata on 4/15/19.
//  Copyright © 2019 Fernando. All rights reserved.
//

import Foundation
import RxSwift

protocol MainViewModelType {
    var inputs: MainViewModelInputs { get }
    var outputs: MainViewModelOutputs { get }
}

protocol MainViewModelInputs {
    /// Selected menu option
    var didSelectRow: AnyObserver<Int> { get }
}

protocol MainViewModelOutputs {
    /// Returns an ordered array of main menu options
    var mainMenu: Observable<[MainMenu]> { get }
    
    /// Returns the selected value
    var currentMenu: Observable<MainMenu> { get }
    
    /// Get previous valie
    var previousSelectedRow: Observable<Int> { get }
}

class MainViewModel: MainViewModelType, MainViewModelInputs, MainViewModelOutputs {
    // Inputs
    let didSelectRow: AnyObserver<Int>
    
    // Outputs
    let mainMenu: Observable<[MainMenu]>
    
    let currentMenu: Observable<MainMenu>
    
    let previousSelectedRow: Observable<Int>
    
    // Subjects
    private let mainMenuSubject: BehaviorSubject<[MainMenu]> = BehaviorSubject<[MainMenu]>(value: MainMenu.menuOrdered)
    private let selectedRowSubject: BehaviorSubject<Int> = BehaviorSubject<Int>(value: 0)
    init() {    
        // Inputs
        didSelectRow = selectedRowSubject.asObserver()
        
        // Outputs
        mainMenu = mainMenuSubject
        
        currentMenu = selectedRowSubject.withLatestFrom(mainMenuSubject, resultSelector: { $1[$0] })
        
        previousSelectedRow = selectedRowSubject.scan([Int](), accumulator: { (seed, newValue) -> [Int] in
            return seed.count > 1 ? [seed[1]] + [newValue] : seed + [newValue]
        }).map({ $0[0] }).skip(1)
    }
    
    var inputs: MainViewModelInputs { return self }
    var outputs: MainViewModelOutputs { return self }
}

