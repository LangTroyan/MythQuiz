//
//  Question.swift
//  Myth Quiz
//
//  Created by Trujillo Baez, Dylan Alfonso (ES - Barcelona) on 04/09/2019.
//  Copyright © 2019 Dylan Trujillo. All rights reserved.
//

import Foundation

class Question: NSObject, NSCoding {
    let question: String?
    let correctAnswer: String?
    let incorrectAnswers: [String]?
    
    public required init?(coder aDecoder: NSCoder) {
        question = aDecoder.decodeObject(forKey: "question") as? String
        correctAnswer = aDecoder.decodeObject(forKey: "correct_answer") as? String
        incorrectAnswers = aDecoder.decodeObject(forKey: "incorrect_answers") as? [String]
    }
    
    public required init(with dictionary: [String : AnyObject]) {
        question = dictionary["question"] as? String
        correctAnswer = dictionary["correct_answer"] as? String
        incorrectAnswers = dictionary["incorrect_answers"] as? [String]
    }
    
    public func encode(with aCoder: NSCoder){
        aCoder.encode(question, forKey:"question")
        aCoder.encode(correctAnswer, forKey:"correct_answer")
        aCoder.encode(incorrectAnswers, forKey:"incorrect_answers")
    }
}
