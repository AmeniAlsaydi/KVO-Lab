//
//  Account.swift
//  KVO-Lab
//
//  Created by Amy Alsaydi on 4/7/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import Foundation

@objc class User: NSObject {
     static var shared = User()
     @objc dynamic var accountBalance: Double = 0.0
     @objc dynamic var name: String = ""
    
}

@objc class Accounts: NSObject {
    static var shared = Accounts()
    @objc dynamic var users = [User]()

}
