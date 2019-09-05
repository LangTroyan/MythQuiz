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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                switch(UIDevice.current.orientation){
                case .landscapeLeft, .landscapeRight:
                    self.view.frame.origin.y -= keyboardSize.height * 2
                default:
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
