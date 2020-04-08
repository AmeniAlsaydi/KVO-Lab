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
            tableView.reloadData() // break here
        }
    }
    
    private var usersListObservation: NSKeyValueObservation? // remember to invalidate when view is nil
    private var balanceObserver: NSKeyValueObservation?
    
    // force view controller to load:
    // https://stackoverflow.com/questions/33261776/how-to-load-all-views-in-uitabbarcontroller
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configureUsersObservation() // if the view isnt loaded first the observer is not configured. ??
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func loadData() {
        users = Accounts.shared.users
    }
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let transactionVC = storyboard?.instantiateViewController(identifier: "TransactionViewController") as? TransactionViewController else {
                   // developer error
                   fatalError("could not downcast to TransactionViewController")
               }
        transactionVC.currentIndex = indexPath.row
        navigationController?.pushViewController(transactionVC, animated: true)
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
