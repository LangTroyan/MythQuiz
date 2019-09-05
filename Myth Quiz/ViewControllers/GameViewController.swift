//
//  GameViewController.swift
//  Myth Quiz
//
//  Created by Trujillo Baez, Dylan Alfonso (ES - Barcelona) on 04/09/2019.
//  Copyright © 2019 Dylan Trujillo. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    public static let kSEGUE = "GameSegue"
    
    @IBOutlet weak var player1NameLabel: UILabel!
    @IBOutlet weak var player1ScoreLabel: UILabel!
    @IBOutlet weak var player2NameLabel: UILabel!
    @IBOutlet weak var player2ScoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option4Button: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var currentPlayerLabel: UILabel!
    
    var viewModel: GameViewModel?
    var questionNumber: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard viewModel != nil else { return }
        
        option1Button.titleLabel?.numberOfLines = 0
        option2Button.titleLabel?.numberOfLines = 0
        option3Button.titleLabel?.numberOfLines = 0
        option4Button.titleLabel?.numberOfLines = 0
        
        player1NameLabel.text = viewModel!.player1.name
        player1ScoreLabel.text = "0"
        player2NameLabel.text = viewModel!.player2.name
        player2ScoreLabel.text = "0"
        
        prepareQuestion(questionNumber)
    }
    
    func prepareQuestion(_ number: Int){
        questionLabel.text = String(htmlEncodedString: viewModel!.questions![number].question!)
        
        if self.questionNumber % 2 == 0 {
            backgroundView.backgroundColor = UIColor.appBlueTransparent
            currentPlayerLabel.shadowColor = UIColor.appBlue
            currentPlayerLabel.text = "It's \(viewModel!.player1.name)'s turn"
        }
        else{
            backgroundView.backgroundColor = UIColor.appRedTransparent
            currentPlayerLabel.shadowColor = UIColor.appRed
            currentPlayerLabel.text = "It's \(viewModel!.player2.name)'s turn"
        }
        option1Button.setAttributedTitle(NSAttributedString(string: String(htmlEncodedString: viewModel!.questions![number].correctAnswer!)!), for: .normal)
        option2Button.setAttributedTitle(NSAttributedString(string: String(htmlEncodedString: viewModel!.questions![number].incorrectAnswers![0])!), for: .normal)
        option3Button.setAttributedTitle(NSAttributedString(string: String(htmlEncodedString: viewModel!.questions![number].incorrectAnswers![1])!), for: .normal)
        option4Button.setAttributedTitle(NSAttributedString(string: String(htmlEncodedString: viewModel!.questions![number].incorrectAnswers![2])!), for: .normal)
        
        suffleOptions()
    }
    
    func suffleOptions(){
        let number = Int.random(in: 1...4)
        let correctAnswer = option1Button.titleLabel?.attributedText
        switch(number){
        case 2:
            option1Button.setAttributedTitle(option2Button.titleLabel?.attributedText, for: .normal)
            option2Button.setAttributedTitle(correctAnswer, for: .normal)
        case 3:
            option1Button.setAttributedTitle(option3Button.titleLabel?.attributedText, for: .normal)
            option3Button.setAttributedTitle(correctAnswer, for: .normal)
        case 4:
            option1Button.setAttributedTitle(option4Button.titleLabel?.attributedText, for: .normal)
            option4Button.setAttributedTitle(correctAnswer, for: .normal)
        default:
            break
        }
    }
    
    func nextQuestion(previousResult wasCorrect: Bool){
        if wasCorrect {
            if self.questionNumber % 2 == 0 {
                viewModel?.player1.score += 1
                self.player1ScoreLabel.text = "\(viewModel?.player1.score ?? 0)"
            }
            else {
                viewModel?.player2.score += 1
                self.player2ScoreLabel.text = "\(viewModel?.player2.score ?? 0)"
            }
        }
        self.questionNumber += 1
        if(self.questionNumber >= viewModel!.questions!.count){
            self.showWinner()
        }
        else {
            self.prepareQuestion(self.questionNumber)
        }
    }
    
    func checkAnswer(pressed: UIButton){
        if pressed.titleLabel?.text == viewModel!.questions![questionNumber].correctAnswer {
            
            self.showAlertWith(title: "Correct", message: "You got it right! Congratulations (+1)"){
                self.nextQuestion(previousResult: true)
            }
            
            
        }
        else {
            self.showAlertWith(title: "Wrong", message: "The correct answer was \"\(String(describing: viewModel!.questions![questionNumber].correctAnswer!))\""){
                self.nextQuestion(previousResult: false)
            }
        }
    }
    
    func showWinner(){
        if Int(player1ScoreLabel.text!)! == Int(player2ScoreLabel.text!)! {
            self.showAlertWith(title: "Draw", message: "The game finished in a draw. You both are winners"){
                self.finishGame()
            }
        }
        else {
            let winner = Int(player1ScoreLabel.text!)! > Int(player2ScoreLabel.text!)! ? player1NameLabel.text! : player2NameLabel.text!
            self.showAlertWith(title: "Winner", message: "The game finished and \(String(winner)) came out victorious"){
                self.finishGame()
            }
        }
    }
    
    func finishGame(){
        viewModel!.saveScore()
        performSegue(withIdentifier: MenuViewController.kSEGUE, sender: self)
    }

    @IBAction func button1Action(_ sender: Any) {
        if let button = sender as? UIButton {
            checkAnswer(pressed: button)
        }
    }
    @IBAction func button2Action(_ sender: Any) {
        if let button = sender as? UIButton {
            checkAnswer(pressed: button)
        }
    }
    @IBAction func button3Action(_ sender: Any) {
        if let button = sender as? UIButton {
            checkAnswer(pressed: button)
        }
    }
    @IBAction func button4Action(_ sender: Any) {
        if let button = sender as? UIButton {
            checkAnswer(pressed: button)
        }
    }
}
