//
//  User.swift
//  SugarRecordSample
//
//  Created by Yusuke KON on 2015/01/25.
//  Copyright (c) 2015年 Yusuke KON. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var email: String
    @NSManaged var age: NSNumber

}
