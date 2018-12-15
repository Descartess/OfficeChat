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
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var chatListTableView: UITableView!
    
    var viewModel: ChatListViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    override func viewDidLoad() {
        chatListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "channelCell")
        chatListTableView.delegate = self
        chatListTableView.dataSource = self
    }
    
    func bindViewModel() {
        
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
        self.present(chatViewController, animated: true, completion: nil)
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
