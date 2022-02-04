//
//  ViewController.swift
//  Project2
//
//  Created by Raphael de Jesus on 30/12/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var quetionsAnswered = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased())   score: \(score)"
    }

    @IBAction func bottonTapped(_ sender: UIButton) {
        var title: String
        let message: String
        let ac: UIAlertController
        quetionsAnswered += 1
        
        if quetionsAnswered < 10 {
         
            if sender.tag == correctAnswer {
                title = "Correct"
                score += 1
                message = "Your score is \(score)"
            }else {
                title = "Wrong"
                score -= 1
                message = "The correct answer is the \(correctAnswer+1) option, Your score is \(score)"
            }
           ac  = UIAlertController(title: title, message: message, preferredStyle: .alert)
        } else {
            ac  = UIAlertController(title: "The end", message: "the game finshed, Your score is \(score)", preferredStyle: .alert)
        }
       
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: { [weak self] _ in
            self?.askQuestion()
        }))
        present(ac, animated: true)
    }
    
}

