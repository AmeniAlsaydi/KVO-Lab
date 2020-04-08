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
    
    private var transactionType = TransactionType.deposit
    public var currentIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        
    }
    
    @IBAction func completeTransactionPressed(_ sender: UIButton) {
        
        let amount = Double(amountTextField.text ?? "0.0") ?? 0.0
        
        guard let index = currentIndex else { fatalError("no index passed") }
        // change the user array using the passed indexpath.row
        if transactionType == .deposit {
            Accounts.shared.users[index].accountBalance += amount //1.0 // this change should trigger the observer
            // increase account balance amount for selected user
            
        }
        else {
            print("ok")
            // decrease account balance amount for selected user
            // and maybe decrease balance from the last created user account
            
        }
        
        
        
        
    }
    

}
