//
//  SetupViewController.swift
//  Myth Quiz
//
//  Created by Trujillo Baez, Dylan Alfonso (ES - Barcelona) on 04/09/2019.
//  Copyright © 2019 Dylan Trujillo. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {

    public static let kSEGUE = "SetupSegue"
    
    @IBOutlet weak var playerField1: UITextField!
    @IBOutlet weak var playerField2: UITextField!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchOutsideOfKeyboard)))
    }
    
    @IBAction func startAction(_ sender: Any) {
        let player1 = Player(name: playerField1.text!.isEmpty ? "Player 1" : playerField1.text!)
        let player2 = Player(name: playerField2.text!.isEmpty ? "Player 2" : playerField2.text!)
        let gameViewModel = GameViewModel(player1: player1,
                                                player2: player2)
        showSpinner(onView: view)
        gameViewModel.loadQuestions(successHandler: {
            self.removeSpinner()
            self.performSegue(withIdentifier: GameViewController.kSEGUE, sender: gameViewModel)
        }, errorHandler: { (error) in
            self.removeSpinner()
            self.showAlertWith(title: "Error", message: error)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier){
        case GameViewController.kSEGUE:
            if let destinationVC = segue.destination as? GameViewController {
                destinationVC.viewModel = (sender as! GameViewModel)
            }
        default:
            break
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        self.topConstraint.constant = 10
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.topConstraint.constant = 180
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func touchOutsideOfKeyboard(sender: UITapGestureRecognizer){
        view.endEditing(true)
    }

}
