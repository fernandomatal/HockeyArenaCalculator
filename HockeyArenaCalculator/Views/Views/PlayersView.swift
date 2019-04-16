//
//  PlayersViewController.swift
//  HockeyArenaCalculator
//
//  Created by Luis Fernando Mata on 4/16/19.
//  Copyright © 2019 Fernando. All rights reserved.
//

import Cocoa

class PlayersView: NSView, MenuView {
    
    required init() {
        super.init(frame: NSRect.zero)
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        NSColor.white.setFill()
        dirtyRect.fill()
    }
    
    func willAppear() {
        
    }
    
    func willDisappear() {
        
    }
}
