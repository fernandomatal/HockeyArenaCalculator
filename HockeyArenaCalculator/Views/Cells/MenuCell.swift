//
//  MenuCell.swift
//  HockeyArenaCalculator
//
//  Created by Luis Fernando Mata on 4/16/19.
//  Copyright © 2019 Fernando. All rights reserved.
//

import Cocoa
import RxSwift

class MenuCell: NSTableCellView {
    
    private var internalHighlighted: Bool = false
    var highlighted: Bool {
        set {
            viewModel.inputs.highlight.onNext(newValue)
        }
        get {
            return internalHighlighted
        }
    }
    
    private var internalSelected: Bool = false
    var selected: Bool {
        set {
            viewModel.inputs.select.onNext(newValue)
        }
        get {
            return internalSelected
        }
    }
    
    private var colorSet: NSColor = NSColor.clear
    
    private let viewModel: MenuCellModelType = MenuCellModel()
    private var disposeBag: DisposeBag = DisposeBag()
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        colorSet.setFill()
        dirtyRect.fill()
    }
    
    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        
        addTrackingArea(NSTrackingArea(rect: self.frame, options: [NSTrackingArea.Options.mouseEnteredAndExited, .activeInActiveApp], owner: self, userInfo: nil))
        bindViewModel()
    }
    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        NSCursor.pointingHand.set()
        viewModel.inputs.highlight.onNext(true)
    }
    
    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        NSCursor.arrow.set()
        viewModel.inputs.highlight.onNext(false)
    }
    
    func setSelected(_ selected: Bool) {
        viewModel.inputs.select.onNext(selected)
    }
    
    private func bindViewModel() {
        viewModel.outputs.selected.bind { [unowned self] (selected) in
            self.internalSelected = selected
        }.disposed(by: disposeBag)
        
        viewModel.outputs.highlighted.bind { (highlighted) in
            self.internalHighlighted = highlighted
        }.disposed(by: disposeBag)
        
        viewModel.outputs.updateSelection.bind { [unowned self] (selected) in
            self.colorSet = selected ? NSColor.flatGray : NSColor.clear
            self.setNeedsDisplay(self.frame)
        }.disposed(by: disposeBag)
    }
}
