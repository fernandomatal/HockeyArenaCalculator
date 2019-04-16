//
//  ViewController.swift
//  HockeyArenaCalculator
//
//  Created by Luis Fernando Mata on 4/10/19.
//  Copyright © 2019 Fernando. All rights reserved.
//

import Cocoa
import RxSwift
import RxCocoa

class MainViewController: NSViewController {
    
    @IBOutlet weak var tableView: MenuTableView!
    
    fileprivate var mainMenu: [MainMenu] = []
    
    fileprivate let viewModel: MainViewModelType = MainViewModel()
    fileprivate var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        bindViewModel()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    private func configureTable() {
        tableView.rowSizeStyle = .custom
    }
    
    private func bindViewModel() {
        viewModel.outputs.mainMenu.subscribe(onNext: { [unowned self] (mainMenu) in
            self.mainMenu = mainMenu
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    private func bindGestures() {
        
    }
}

extension MainViewController: NSTableViewDataSource, NSTableViewDelegate {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        return tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: mainMenu[row].cellIdentifier), owner: self)
    }
}

