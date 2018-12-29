//
//  ContactsViewController.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 23/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import UIKit

class ContactsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let contactCellIdentifier = "contactCell"
    var viewModel: ContactsViewModel?
    
    let searchBar =  UISearchBar()
    
    var showSearchBar = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: contactCellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        title = "Contacts"
        setUpNavBar()
    }
    
    func setUpNavBar() {
        navigationItem.rightBarButtonItem = rightBarButtonItem()
    }
    
    func rightBarButtonItem() -> UIBarButtonItem {
        let rightBar = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: nil)
        return rightBar
    }
    
    @objc func searchButtonPressed() {
        showSearchBar = !showSearchBar
        if showSearchBar {
            navigationItem.rightBarButtonItem = rightCancelBarButtonItem()
            navigationItem.titleView = searchBar
        } else {
            setUpNavBar()
        }
    }
    
    func rightCancelBarButtonItem() -> UIBarButtonItem {
        let cancelButton = UIBarButtonItem(title: "Cancel",
                                           style: .plain,
                                           target: self,
                                           action: #selector(cancelButtonPressed))
        return cancelButton
    }
    
    @objc func cancelButtonPressed() {
        showSearchBar = !showSearchBar
        viewModel?.search(text: "")
        setUpNavBar()
    }
}

extension ContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vm = viewModel else { return 0 }
        return vm.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let vm = viewModel
            else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: contactCellIdentifier, for: indexPath)
        cell.textLabel?.text = vm.contacts[indexPath.row].name
        return cell
    }
}

extension ContactsViewController: ContactViewModelDelegate {
    func added(channel: Contact) {
        
    }
    
    func modified(channel: Contact) {
        
    }
    
    func removed(channel: Contact) {
        
    }
}
