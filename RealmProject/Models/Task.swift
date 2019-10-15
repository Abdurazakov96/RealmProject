//
//  Task.swift
//  RealmProject
//
//  Created by Магомед Абдуразаков on 13/10/2019.
//  Copyright © 2019 Магомед Абдуразаков. All rights reserved.
//

import Foundation
import RealmSwift


class Task: Object {
    
    
    //MARK: Public properties
    
    @objc dynamic var name = ""
    @objc dynamic var completed = false
}
