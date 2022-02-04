//
//  ViewController.swift
//  Challenge 7-8-9
//
//  Created by Raphael de Jesus on 25/01/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var homeView: HomeView!
    
    override func loadView() {
        super.loadView()
        homeView = HomeView()
        homeView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(homeView)
        homeView.textFieldAnswer.delegate = self
        addConstraints()
        loadGame()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // get the current text, or use an empty string if that failed
        let currentText = textField.text ?? ""

        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }

        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= 1
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            homeView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    private func loadGame() {
        
        DispatchQueue.main.async {
          
            if let levelFileURL = Bundle.main.url(forResource: "level1", withExtension: ".txt") {
                if let levelContents = try? String(contentsOf: levelFileURL) {
                    var lines = levelContents.components(separatedBy: "\n")
                    lines.shuffle()
                    self.homeView.initiateGame(lines: lines)
                }
            }
        
        }
    }
}

