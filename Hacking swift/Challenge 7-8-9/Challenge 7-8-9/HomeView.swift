//
//  HomeView.swift
//  Challenge 7-8-9
//
//  Created by Raphael de Jesus on 25/01/22.
//

import UIKit


class HomeView: UIView {
    
    var currentGuessWord = [String()]
    var correctAnser = 0
    var lines = [String()]
    var scoreNumber = 0 {
        didSet {
            score.text = "Score: \(String(describing: score))"
        }
    }
    
    let score: UILabel = {
       let score = UILabel()
        score.text = "Score: 0"
        score.textColor = .black
        score.textAlignment = .right
        score.font = .systemFont(ofSize: 14)
        score.translatesAutoresizingMaskIntoConstraints = false
        return score
    }()
    
    let guessWord: UIStackView = {
       let guessWord = UIStackView()
        guessWord.translatesAutoresizingMaskIntoConstraints = false
        guessWord.axis = .horizontal
        guessWord.spacing = 1.0
        guessWord.alignment = .fill
        guessWord.distribution = .fillEqually
        return guessWord
    }()
    
    
    let textFieldAnswer: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.placeholder = "Tap letter to guess"
        textField.textAlignment = .center
        return textField
    }()
    
    let buttonSubmit: UIButton = {
       let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SUBMIT", for: .normal)
        button.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        return button
    }()
    
    

    public init() {
        super.init(frame: .zero)
        addSubViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            score.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            score.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            guessWord.topAnchor.constraint(equalTo: score.bottomAnchor, constant: 20),
            guessWord.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
            guessWord.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            guessWord.heightAnchor.constraint(equalToConstant: 60),
            
            textFieldAnswer.topAnchor.constraint(equalTo: guessWord.bottomAnchor, constant: 10),
            textFieldAnswer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            buttonSubmit.topAnchor.constraint(equalTo: textFieldAnswer.bottomAnchor, constant: 15),
            buttonSubmit.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    @objc private func submitTapped(_ sender: UIButton) {
            let wordAttempted = textFieldAnswer.text?.uppercased() ?? ""
            if currentGuessWord.contains(wordAttempted) {
                for (index, letter) in currentGuessWord.enumerated() {
                    if letter == wordAttempted {
                        let label = guessWord.subviews[index] as! UILabel
                        label.text = wordAttempted
                        correctAnser += 1
                        validateEndGame()
                    }
                }
            } else {
                let ac = UIAlertController(title: "Alert", message: "What a pity, this letter doesn`t exist in this word!", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default)
                ac.addAction(action)
                self.window?.rootViewController?.present(ac, animated: true)
            }
        
        textFieldAnswer.text?.removeAll()
    }
    
    func validateEndGame() {
        
        if correctAnser >= currentGuessWord.count {
            scoreNumber += 1
            lines.remove(at: 0)
            guessWord.subviews.forEach({ $0.removeFromSuperview() })
            if lines.count >= 1 {
                initiateGame(lines: lines)
            }
        }
    }
    
    func initiateGame(lines: [String]) {
        DispatchQueue.main.async { [weak self] in
            self?.lines = lines
            guard let questionNumber = self?.correctAnser else {
                return
            }
            let letters = lines[questionNumber].components(separatedBy: "-")
            self?.currentGuessWord = letters
        for _ in letters {
            let label = UILabel()
            label.text = "?"
            label.textColor = .black
            label.textAlignment = .right
            label.font = .systemFont(ofSize: 18)
            self?.guessWord.addArrangedSubview(label)
        }
        }
    }
    
    
    private func addSubViews() {
        self.addSubview(score)
        self.addSubview(guessWord)
        self.addSubview(textFieldAnswer)
        self.addSubview(buttonSubmit)
    }
    
}
