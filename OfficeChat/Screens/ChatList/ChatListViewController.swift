//
//  ChatListViewController.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 09/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import UIKit

class ChatListViewController: UIViewController {
    @IBOutlet weak var chatListTableView: UITableView!
    let searchBar =  UISearchBar()
    
    var showSearchBar = false
    
    var currentAlertController: UIAlertController?
    
    var viewModel: ChatListViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    override func viewDidLoad() {
        chatListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "channelCell")
        chatListTableView.delegate = self
        chatListTableView.dataSource = self
        
        searchBar.delegate = self
        
        setUpNavBar()
    }
    
    func setUpNavBar() {
        title = "Chats"
        navigationItem.titleView = nil
        navigationItem.leftBarButtonItem = leftBarButtonItem()
        navigationItem.rightBarButtonItem = rightBarButtonItem()
    }
    
    func rightBarButtonItem() -> UIBarButtonItem {
        let rightBar = UIBarButtonItem(barButtonSystemItem: .search,
                                       target: self,
                                       action: #selector(searchButtonPressed))
        return rightBar
    }
    
    func leftBarButtonItem() -> UIBarButtonItem {
        let leftBar = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        return leftBar
    }
    
    func rightCancelBarButtonItem() -> UIBarButtonItem {
        let cancelButton = UIBarButtonItem(title: "Cancel",
                                           style: .plain,
                                           target: self,
                                           action: #selector(cancelButtonPressed))
        return cancelButton
    }
    
    func bindViewModel() {
    
    }
    
    @objc func cancelButtonPressed() {
        showSearchBar = !showSearchBar
        viewModel?.search(text: "")
        setUpNavBar()
    }
    
    @objc func searchButtonPressed() {
        showSearchBar = !showSearchBar
        if showSearchBar {
            navigationItem.leftBarButtonItem = nil
            navigationItem.rightBarButtonItem = rightCancelBarButtonItem()
            navigationItem.titleView = searchBar
        } else {
            setUpNavBar()
        }
    }
    
    @objc func addButtonPressed() {
        let ac = UIAlertController(title: "Create a new Channel", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.addTextField { field in
            field.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
            field.enablesReturnKeyAutomatically = true
            field.autocapitalizationType = .words
            field.clearButtonMode = .whileEditing
            field.placeholder = "Channel name"
            field.returnKeyType = .done
            field.tintColor = .primary
        }
        
        let createAction = UIAlertAction(title: "Create", style: .default, handler: { _ in
            self.createChannel()
        })
        createAction.isEnabled = false
        ac.addAction(createAction)
        ac.preferredAction = createAction
        
        present(ac, animated: true) {
            ac.textFields?.first?.becomeFirstResponder()
        }
        currentAlertController = ac
    }
    
    @objc private func textFieldDidChange(_ field: UITextField) {
        guard let ac = currentAlertController else {
            return
        }
        
        ac.preferredAction?.isEnabled = field.hasText
    }
    
    func createChannel() {
        guard
            let vm = viewModel,
            let ac = currentAlertController,
            let channelName = ac.textFields?.first?.text
        else { return }
        let channel = Channel(name: channelName)
        vm.createChannel(channel)
    }
}

extension ChatListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vm = viewModel else { return 0 }
        return vm.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let vm = viewModel
        else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath)
        cell.textLabel?.text = vm.channels[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let vm = viewModel,
            let chatViewModel = ChatViewModel(user: vm.currentUser, channel: vm.channels[indexPath.row])
        else { return }
        
        let chatViewController = ChatViewController()
        chatViewModel.delegate = chatViewController
        chatViewController.viewModel = chatViewModel
        self.navigationController?.pushViewController(chatViewController, animated: true)
    }
}

extension ChatListViewController: ChatListDelegate {
    func added(channel: Channel) {
        guard let vm = viewModel,
              let index = vm.channels.index(of: channel)
        else { return }
        chatListTableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    func modified(channel: Channel) {
        guard let vm = viewModel,
            let index = vm.channels.index(of: channel)
            else { return }
        chatListTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    func removed(channel: Channel) {
        guard let vm = viewModel,
            let index = vm.channels.index(of: channel)
            else { return }
        chatListTableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
}
extension ChatListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.search(text: searchText)
        chatListTableView.reloadData()
    }
}
