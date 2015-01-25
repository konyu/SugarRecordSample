//
//  ViewController.swift
//  SugarRecordSample
//
//  Created by Yusuke KON on 2015/01/25.
//  Copyright (c) 2015年 Yusuke KON. All rights reserved.
//

import UIKit

//import lib CoreData　and SuparRecord
import CoreData
import SugarRecord


class ViewController: UIViewController {
    
    // get NSManagedObjectModel to use SugarRecord with CoreData
    let model: NSManagedObjectModel = {
        let modelPath: NSString = NSBundle.mainBundle().pathForResource("SugarRecordSample", ofType: "momd")!
        let model: NSManagedObjectModel = NSManagedObjectModel(contentsOfURL: NSURL(fileURLWithPath: modelPath)!)!
        return model
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init SugarRecord with CoreData
        let stack = DefaultCDStack(databaseName: "SugarRecordSample.sqlite", model: self.model, automigrating: true)
        // persistence　setting
        (stack as DefaultCDStack).autoSaving = true
        SugarRecord.addStack(stack)
        
        
        // write record 5 times
        for i in 1...5 {
            writeRecord(i)
        }
        
        // read datas
        readRecords()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // write record method
    func writeRecord(i : Int) {
        let user = User.create() as User
        user.name = "test" + i.description
        user.age = 1 + i
        user.email = "test@test.com"
        user.save()
    }
    
    
    // read records method
    func readRecords() {
        var names : [String] = []
        var emails : [String] = []
        var ages : [NSNumber] = []
        
        // get records with SugarRecord
        // ascending : true is ASC, false is DESC
        let results : SugarRecordResults = User.all().sorted(by: "age", ascending: true).find()
        
        
        let firstObj : User = results.firstObject() as User
        let lastObj : User = results.lastObject() as User
        
        // get date with iterator
        let iterator = results.generate()
        while let record: AnyObject = iterator.next() {
            let data = record as User
            names.append(data.name)
            emails.append(data.email)
            ages.append(data.age)
        }
        
//        // get date with for-loop
//        for ( var i = 0; i < results.count; i++ ){
//            let data = results[i] as User
//            names.append(data.name)
//            emails.append(data.email)
//            ages.append(data.age)
//        }
        
        
        // show result
        println("-----------")
        println(names)
        println(emails)
        println(ages)
    }

}

