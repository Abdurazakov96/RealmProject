//
//  Tasks.swift
//  RealmProject
//
//  Created by Магомед Абдуразаков on 11/10/2019.
//  Copyright © 2019 Магомед Абдуразаков. All rights reserved.
//

import Foundation
import RealmSwift


class Tasks: Object {
    
    
    //MARK: Public properties
    
    @objc dynamic var name = ""
    @objc dynamic var date = Date()
    var tasks = List<Task>()

}
