//
//  ScoreViewController.swift
//  Myth Quiz
//
//  Created by Trujillo Baez, Dylan Alfonso (ES - Barcelona) on 04/09/2019.
//  Copyright © 2019 Dylan Trujillo. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {

    public static let kSEGUE = "ScoreSegue"
    
    @IBOutlet weak var scoresTableView: UITableView!
    
    var scores: [Score]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scoresTableView.reloadData()
    }
    


}

extension ScoreViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
}

extension ScoreViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ScoreTableViewCell.kIDENTIFIER) as? ScoreTableViewCell {
            cell.score = scores![indexPath.row]
            return cell
        }
        return tableView.dequeueReusableCell(withIdentifier: ScoreTableViewCell.kIDENTIFIER)!
    }
    
    
}
