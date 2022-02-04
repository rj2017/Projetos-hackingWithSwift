//
//  ViewController.swift
//  Project 5
//
//  Created by Raphael de Jesus on 08/01/22.
//

import UIKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        navigationController?.isToolbarHidden = false
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["Silkworm"]
        }
        startGame()
    }
    
    @objc func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func promptForAnswer(){
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = title!.lowercased()

        for letter in word {
            if let pos = tempWord.range(of: String(letter)) {
                tempWord.remove(at: pos.lowerBound)
            } else {
                return false
            }
        }

        return true
    }
    
    func submit(_ answer: String) {
        if answer.count < 3 || usedWords.contains(answer) {
            let ac = UIAlertController(title: "Alerta", message: "A resposta tem que ter mais de 3 caracteres e não pode já ter sido utilizada", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
        } else if isPossible(word: answer.lowercased()){
            usedWords.append(answer)
            tableView.reloadData()
        } else {
            let ac = UIAlertController(title: "Alerta", message: "Nao existe \(answer) na palava \(String(describing: title?.lowercased() ?? "ERROR"))", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }


}

