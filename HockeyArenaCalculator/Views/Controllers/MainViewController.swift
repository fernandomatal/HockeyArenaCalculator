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
import SnapKit

class MainViewController: NSViewController {
    
    @IBOutlet weak var tableView: MenuTableView!
    @IBOutlet weak var viewContainer: NSView!
    
    fileprivate var mainMenu: [MainMenu] = []
    
    fileprivate var views: [MainMenu : MenuView] = [:]
    fileprivate var currentView: MenuView?
    
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
        tableView.selectionHighlightStyle = .none
    }
    
    private func bindViewModel() {
        viewModel.outputs.mainMenu.subscribe(onNext: { [unowned self] (mainMenu) in
            self.mainMenu = mainMenu
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel.outputs.currentMenu
        .withLatestFrom(viewModel.outputs.mainMenu, resultSelector: { ($0, $1.firstIndex(of: $0)) })
        .subscribe(onNext: { [unowned self] (menu, selectionIndex) in
            guard let selectionIndex = selectionIndex else {
                return
            }
            
            self.tableView.selectRowIndexes([selectionIndex], byExtendingSelection: false)
            self.renderView(selectedMenu: menu)
        }).disposed(by: disposeBag)
        
        viewModel.outputs.previousSelectedRow
            .subscribe(onNext: { [unowned self] (deselectedRow) in
                if let menuCell = self.tableView.view(atColumn: 0, row: deselectedRow, makeIfNecessary: true) as? MenuCell {
                    menuCell.selected = false
                }
        }).disposed(by: disposeBag)
    }
    
    private func renderView(selectedMenu: MainMenu) {
        if views[selectedMenu] == nil {
            // If view doesn't exit create a new one
            guard let newView = selectedMenu.viewClass?.init() else {
                // Clean everything if view can't be created
                currentView?.willDisappear()
                currentView?.view.removeFromSuperview()
                currentView = nil
                return
            }
            
            views[selectedMenu] = newView
        }
        
        // Clean old view
        currentView?.willDisappear()
        currentView?.view.removeFromSuperview()
        
        // Configure new views
        let menuView = views[selectedMenu]!
        viewContainer.addSubview(menuView.view)
        menuView.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        menuView.willAppear()
        currentView = menuView
    }
}

extension MainViewController: NSTableViewDataSource, NSTableViewDelegate {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return mainMenu.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        return tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: mainMenu[row].cellIdentifier), owner: self)
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        // Send selection to view model and disable UI action
        viewModel.inputs.didSelectRow.onNext(row)
        return false
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        if let menuCell = tableView.view(atColumn: 0, row: tableView.selectedRow, makeIfNecessary: true) as? MenuCell {
            menuCell.selected = true
        }
    }
}
