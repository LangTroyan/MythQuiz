//
//  ScoreTableViewCell.swift
//  Myth Quiz
//
//  Created by Trujillo Baez, Dylan Alfonso (ES - Barcelona) on 05/09/2019.
//  Copyright © 2019 Dylan Trujillo. All rights reserved.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {
    
    public static let kIDENTIFIER = "ScoreCell"

    @IBOutlet weak var player1NameLabel: UILabel!
    @IBOutlet weak var player1ScoreLabel: UILabel!
    @IBOutlet weak var player2ScoreLabel: UILabel!
    @IBOutlet weak var player2NameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var score: Score? {
        didSet {
            player1NameLabel.text = score?.player1
            player1ScoreLabel.text = score?.score1
            player2NameLabel.text = score?.player2
            player2ScoreLabel.text = score?.score2
            if let date = score?.date as Date? {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd"
                dateLabel.text = formatter.string(from: date)
            }
            else {
                dateLabel.text = "---"
            }
            
            
        }
    }
    
}
