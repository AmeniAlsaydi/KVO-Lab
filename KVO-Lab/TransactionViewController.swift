//
//  TransactionViewController.swift
//  KVO-Lab
//
//  Created by Amy Alsaydi on 4/7/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

enum TransactionType {
    case request
    case deposit
}

import UIKit

class TransactionViewController: UIViewController {
    
    @IBOutlet weak var amountTextField: UITextField!
    
    private var transactionType = TransactionType.request
    public var currentIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            transactionType = .request
            
        } else if sender.selectedSegmentIndex == 1 {
            transactionType = .deposit
        }
    }
    
    @IBAction func completeTransactionPressed(_ sender: UIButton) {
        
        let amount = Double(amountTextField.text ?? "0.0") ?? 0.0
        
        guard let index = currentIndex else { fatalError("no index passed") }
        // change the user array using the passed indexpath.row
        if transactionType == .deposit {
             print("deposit")
            // increase balance amount for selected user
            Accounts.shared.users[index].accountBalance += amount //1.0 // this change should trigger the observer
            // decrease balance amount for last created user
            //Accounts.shared.users.last?.accountBalance -= amount
            
        }
        else {
            print("request")
            // decrease balance amount for selected user
            Accounts.shared.users[index].accountBalance -= amount //1.0 // this change should trigger the observer
            // increase balance amount for last created user (aka requesting user)
            // Accounts.shared.users.last?.accountBalance += amount
            
        }
        
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }

        
    }
    

}
