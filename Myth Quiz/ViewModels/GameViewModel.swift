//
//  GameViewModel.swift
//  Myth Quiz
//
//  Created by Trujillo Baez, Dylan Alfonso (ES - Barcelona) on 04/09/2019.
//  Copyright © 2019 Dylan Trujillo. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class GameViewModel {
    
    //MARK: Properties
    var questions: [Question]?
    var player1: Player
    var player2: Player
    let context: NSManagedObjectContext?
    
    //MARK: Inits
    init(player1: Player, player2: Player){
        self.player1 = player1
        self.player2 = player2
        context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    }
    
    //MARK: Method
    public func loadQuestions(successHandler: @escaping () -> Void, errorHandler: @escaping (String) -> Void){
        let service = APIService()
        service.getData { (result) in
            switch result {
            case .Success(let data):
                self.questions = [Question]()
                for dictionary in data {
                    self.questions?.append(Question(with: dictionary))
                }
                successHandler()
            case .Error(let message):
                errorHandler(message)
            }
        }
    }
    
    func saveScore(){
        saveInCoreDataWith()
    }
    
    private func saveInCoreDataWith(){
        guard let context = context else { return }
        
        if let scoreEntity = NSEntityDescription.insertNewObject(forEntityName: "Score", into: context) as? Score {
            scoreEntity.player1 = player1.name
            scoreEntity.score1 = "\(player1.score)"
            scoreEntity.player2 = player2.name
            scoreEntity.score2 = "\(player2.score)"
            scoreEntity.date = NSDate()
        }
        
        do {
            try context.save()
        }
        catch let error {
            print(error)
        }
    }
}
