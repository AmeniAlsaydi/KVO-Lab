//
//  ProfileViewController.swift
//  KVO-Lab
//
//  Created by Amy Alsaydi on 4/7/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var moneyImage: UIImageView!
    
    private var users = [User]()
    
    private var currentUser: User? {
        didSet {
            updateUI()
        }
    }
    
    private var usersListObservation: NSKeyValueObservation?
    private var currentUserBalanceObservation: NSKeyValueObservation?
    
    
    // set up profile like with an observer that observes if a new account was made and displays the most current account info

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        updateUI()
        configureUsersObservation()
        configureBalancObservation()
    }
    
    private func updateUI() {
        helloLabel.text = "Hello \(currentUser?.name ?? "")"
        balanceLabel.text = "$\(currentUser?.accountBalance ?? 0.0)"
    }
    
    private func configureUsersObservation() {
        usersListObservation = Accounts.shared.observe(\.users, options: [.new, .old], changeHandler: { [weak self] (account, change) in
            guard let users = change.newValue else {return}
            self?.users = users
            self?.currentUser = users.last // most recently made account
        })
    }
    
    private func configureBalancObservation() {
        
        currentUserBalanceObservation = Accounts.shared.users.last?.observe(\.accountBalance, options: [.new, .old], changeHandler: { (user, change) in
            guard let _ = change.newValue else { return }
            self.currentUser = user
        })
    }

    
}
