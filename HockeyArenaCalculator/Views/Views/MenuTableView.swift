//
//  MenuView.swift
//  HockeyArenaCalculator
//
//  Created by Luis Fernando Mata on 4/15/19.
//  Copyright © 2019 Fernando. All rights reserved.
//

import Cocoa
import RxSwift
import RxCocoa

class MenuTableView: NSTableView {
    private let pointingCursor = NSCursor.pointingHand
    
    override func mouseDown(with event: NSEvent) {
        let globalLocation = event.locationInWindow
        let localLocation = convert(globalLocation, from: nil)
        let clickedRow = row(at: localLocation)
        
        if clickedRow != -1 {
            super.mouseDown(with: event)
        }
    }
}
