//
//  QuestionItem.swift
//  StudyCard
//
//  Created by Fiona Siu on 2018-03-01.
//  Copyright © 2018 Fiona Siu. All rights reserved.
//

import UIKit
import Foundation
import os

class QuestionItem: NSObject, NSCoding{
    
    var questionName: String
    var question: String
    var answer: String
    var correctValue: Int
    var incorrectValue: Int
    
    class PropertyKey{
        static let questionName = "questionName"
        static let question = "question"
        static let answer = "answer"
        static let correctValue = "correctValue"
        static let incorrectValue = "incorrectValue"
    }
    
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("questionItems")
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let questionName = aDecoder.decodeObject(forKey: PropertyKey.questionName) as? String else {
            os_log("Missing questionName", log: OSLog.default, type: .debug)
            return nil
        }
        guard let question = aDecoder.decodeObject(forKey: PropertyKey.question) as? String else {
            os_log("Missing question", log: OSLog.default, type: .debug)
            return nil
        }
        guard let answer = aDecoder.decodeObject(forKey: PropertyKey.answer) as? String else {
            os_log("Missing answer", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let correctValue = aDecoder.decodeInteger(forKey: PropertyKey.correctValue) as? Int else {
            os_log("Missing correct value", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let incorrectValue = aDecoder.decodeInteger(forKey: PropertyKey.incorrectValue) as? Int else {
            os_log("Missing incorrect value", log: OSLog.default, type: .debug)
            return nil
        }

        self.init(questionName: questionName, question: question, answer: answer, correctValue: correctValue, incorrectValue: incorrectValue)
        //self.init(questionName: questionName, question: question, answer: answer, correctValue: correctValue)
        
    }
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(questionName, forKey:PropertyKey.questionName)
        aCoder.encode(question, forKey:PropertyKey.question)
        aCoder.encode(answer, forKey:PropertyKey.answer)
        aCoder.encode(correctValue, forKey:PropertyKey.correctValue)
        aCoder.encode(incorrectValue, forKey:PropertyKey.incorrectValue)
    }
    
    override convenience init(){
        self.init(questionName: "Question Name", question: "Question", answer: "Answer", correctValue: 0, incorrectValue: 0)
    }
    
    init(questionName: String, question: String, answer: String, correctValue: Int, incorrectValue: Int){
        self.questionName = questionName
        self.question = question
        self.answer = answer
        self.correctValue = correctValue
        self.incorrectValue = incorrectValue
        
    }
}
