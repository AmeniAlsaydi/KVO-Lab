//
//  CreateViewController.swift
//  KVO-Lab
//
//  Created by Amy Alsaydi on 4/7/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var balanceTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func createPressed(_ sender: UIButton) {
        // here is where the account class is updated with a new user to the user array

        // user is created and then appened to the array in that class
        // that array is whats used to populate the table view ???
        
        let user = User()
        
        // unwrap
        guard let name = nameTextField.text else {return}
        guard let balance = balanceTextField.text, let balance2 = Double(balance) else {return}
        
        user.name = name
        user.accountBalance = balance2
        
        Accounts.shared.users.append(user) // this update should be observed by the other VCs
        
    }
    
}
