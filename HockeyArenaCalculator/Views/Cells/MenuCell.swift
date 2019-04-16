//
//  MenuCell.swift
//  HockeyArenaCalculator
//
//  Created by Luis Fernando Mata on 4/16/19.
//  Copyright © 2019 Fernando. All rights reserved.
//

import Cocoa

class MenuCell: NSTableCellView {
    
    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        
        addTrackingArea(NSTrackingArea(rect: self.frame, options: [NSTrackingArea.Options.mouseEnteredAndExited, .activeInActiveApp], owner: self, userInfo: nil))
    }
    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        NSCursor.pointingHand.set()
    }
    
    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        NSCursor.arrow.set()
    }
}
