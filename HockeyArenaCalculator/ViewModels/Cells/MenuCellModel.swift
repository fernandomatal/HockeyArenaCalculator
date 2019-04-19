//
//  MenuCellModel.swift
//  HockeyArenaCalculator
//
//  Created by Luis Fernando Mata on 4/17/19.
//  Copyright © 2019 Fernando. All rights reserved.
//

import Foundation
import RxSwift

protocol MenuCellModelType {
    var inputs: MenuCellModelInputs { get }
    var outputs: MenuCellModelOutputs { get }
}

protocol MenuCellModelInputs {
    var select: AnyObserver<Bool> { get }
    
    var highlight: AnyObserver<Bool> { get }
}

protocol MenuCellModelOutputs {
    var selected: Observable<Bool> { get }
    
    var highlighted: Observable<Bool> { get }
    
    var updateSelection: Observable<Bool> { get }
}

class MenuCellModel: MenuCellModelType, MenuCellModelInputs, MenuCellModelOutputs {
    // Inputs
    let select: AnyObserver<Bool>
    
    let highlight: AnyObserver<Bool>
    
    // Outputs
    let selected: Observable<Bool>
    
    let highlighted: Observable<Bool>
    
    let updateSelection: Observable<Bool>
    
    // Subjects
    fileprivate let selectedSubject: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
    fileprivate let highlightedSubject: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
    
    init() {
        // Inputs
        select = selectedSubject.asObserver()
        
        highlight = highlightedSubject.asObserver()
        
        // Outputs
        selected = selectedSubject
        
        highlighted = highlightedSubject
        
        updateSelection = Observable.combineLatest(selectedSubject,
                                                   highlightedSubject)
                                    .map({ $0 || $1 })
    }
    
    var inputs: MenuCellModelInputs { return self }
    var outputs: MenuCellModelOutputs { return self }
}

