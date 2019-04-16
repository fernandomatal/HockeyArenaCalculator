//
//  MenuView.swift
//  HockeyArenaCalculator
//
//  Created by Luis Fernando Mata on 4/16/19.
//  Copyright © 2019 Fernando. All rights reserved.
//

import Foundation
import Cocoa

protocol MenuView {
    init()
    
    func willAppear()
    
    func willDisappear()
    
    var view: NSView { get }
}

extension MenuView {
    var view: NSView {
        guard let view = self as? NSView else {
            fatalError("View not implemented")
        }
        
        return view
    }
}
