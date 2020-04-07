//
//  UsersViewController.swift
//  KVO-Lab
//
//  Created by Amy Alsaydi on 4/7/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
  
    private var users = [User]() { // starts off as an empty table view
        didSet {
            tableView.reloadData()
        }
    }
    
    private var usersListObservation: NSKeyValueObservation? // remember to invalidate when off screen
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUsersObservation()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
    }

//    override func viewDidDisappear(_ animated: Bool) {
//
//        usersListObservation?.invalidate()
//    }
    
    private func configureUsersObservation() {
        usersListObservation = Accounts.shared.observe(\.users, options: [.new, .old], changeHandler: { [weak self] (account, change) in
            guard let users = change.newValue else {return}
            self?.users = users
        })
    }
    
    deinit {
       usersListObservation?.invalidate()
    }
}

extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = "$\(user.accountBalance)"
        return cell
    }
    
    
}

extension UsersViewController: UITableViewDelegate {
    // for height ?
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    
}



// this tab is an observer
// the next tab will have to update the array too
// use the most recent account made (.new) to add the amount to if the amount is requested
// decrease amount requested and add it to the most recent account made (.new)
