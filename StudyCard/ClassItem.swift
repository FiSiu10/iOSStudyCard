//
//  ClassItem.swift
//  StudyCard
//
//  Created by Fiona Siu on 2018-03-01.
//  Copyright © 2018 Fiona Siu. All rights reserved.
//

import UIKit
import Foundation
import os

class ClassItem: NSObject, NSCoding{
    
    var classItem: String
    
    class PropertyKey{
        static let classItem = "classItem"
    }
    
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("classItems")
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let classItem = aDecoder.decodeObject(forKey: PropertyKey.classItem) as? String else {
            os_log("Missing text", log: OSLog.default, type: .debug)
            return nil
        }
        self.init(classItem: classItem)
    }
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(classItem, forKey:PropertyKey.classItem)
    }
    
    override convenience init(){
        self.init(classItem: "default")
    }
    
    init(classItem: String){
        self.classItem = classItem
    }
}
