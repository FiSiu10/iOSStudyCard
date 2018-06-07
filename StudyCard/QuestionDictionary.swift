//
//  QuestionDictionary.swift
//  StudyCard
//
//  Created by Fiona Siu on 2018-03-01.
//  Copyright © 2018 Fiona Siu. All rights reserved.
//

import UIKit
import Foundation
import os

class PropertyKey3{
    static let questionDictionary = "questionDictionary"
}

class QuestionDictionary: NSObject, NSCoding{
    
    // MARK: - Properties
    var questionDictionary = [String: QuestionItem]()
    
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("questionList")
    
    // MARK: - Initializers
    override convenience init(){
        self.init(questionList: [QuestionItem]())
    }
    init(questionList: [QuestionItem]){
        self.questionList = questionList
    }
    
    // MARK: - Coding
    required convenience init?(coder aDecoder: NSCoder) {
        _ = aDecoder.decodeObject(forKey: PropertyKey3.questionList) as? [QuestionItem]
        self.init(questionList: [QuestionItem]())
    }
    func encode(with aCoder: NSCoder){
        aCoder.encode(questionList, forKey:PropertyKey3.questionList)
    }
}
