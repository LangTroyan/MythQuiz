//
//  Score+CoreDataProperties.swift
//  Myth Quiz
//
//  Created by Trujillo Baez, Dylan Alfonso (ES - Barcelona) on 04/09/2019.
//  Copyright © 2019 Dylan Trujillo. All rights reserved.
//
//

import Foundation
import CoreData


extension Score {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Score> {
        return NSFetchRequest<Score>(entityName: "Score")
    }

    @NSManaged public var player1: String?
    @NSManaged public var score1: String?
    @NSManaged public var player2: String?
    @NSManaged public var score2: String?
    @NSManaged public var date: NSDate?

}
