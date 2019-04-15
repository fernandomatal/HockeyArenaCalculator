//
//  ViewController.swift
//  HockeyArenaCalculator
//
//  Created by Luis Fernando Mata on 4/10/19.
//  Copyright © 2019 Fernando. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    fileprivate let mainMenu = MainMenu.menuOrdered
    
    @IBOutlet weak var tableView: NSTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    private func configureTable() {
        tableView.rowSizeStyle = .custom
    }
}

extension ViewController: NSTableViewDataSource, NSTableViewDelegate {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        return tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: mainMenu[row].cellIdentifier), owner: self)
    }
}

