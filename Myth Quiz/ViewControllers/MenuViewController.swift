//
//  ViewController.swift
//  Myth Quiz
//
//  Created by Trujillo Baez, Dylan Alfonso (ES - Barcelona) on 04/09/2019.
//  Copyright © 2019 Dylan Trujillo. All rights reserved.
//

import UIKit
import CoreData

class MenuViewController: UIViewController {

    //MARK: Properties
    
    public static let kSEGUE = "MenuSegue"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func playAction(_ sender: Any) {
        performSegue(withIdentifier: SetupViewController.kSEGUE, sender: sender)
    }
    @IBAction func scoresAction(_ sender: Any) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Score")
        var scores = [Score]()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            do {
                scores = try context.fetch(fetchRequest) as! [Score]
            }
            catch let error {
                print("Could not fetch data from the actual context: \(error)")
            }
        }
        performSegue(withIdentifier: ScoreViewController.kSEGUE, sender: scores)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier){
        case SetupViewController.kSEGUE:
            break
        case ScoreViewController.kSEGUE:
            if let destinationVC = segue.destination as? ScoreViewController, let scores = sender as? [Score] {
                destinationVC.scores = scores
            }
        default:
            break
        }
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
        
    }
}

