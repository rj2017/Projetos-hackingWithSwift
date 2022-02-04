//
//  ViewController.swift
//  Project 7
//
//  Created by Raphael de Jesus on 17/01/22.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var petitionsFilter = [Petition]()
    var allPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        fetchJson()
        performSelector(onMainThread: #selector(fetchJson), with: nil, waitUntilDone: false)
    }
    
    @objc func fetchJson() {
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showAlertAbout))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(filterPostsAction))
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
            
        }
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    @objc func showAlertAbout() {
        let ac = UIAlertController(title: "About the page", message: "All feed was got from https://www.hackingwithswift.com/samples/petitions-1.json page", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    @objc func filterPostsAction() {
        let ac = UIAlertController(title: "Filter the feeds", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Filter", style: .default) { [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.filterPosts(answer: answer)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func filterPosts(answer: String) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else {
                return
            }
            if !answer.isEmpty {
                for petition in self.allPetitions {
                    if petition.body.contains(answer) || petition.title.contains(answer) {
                        self.petitionsFilter.append(petition)
                    }
                }
                self.petitions = self.petitionsFilter
                self.tableView.performSelector(onMainThread: #selector(self.tableView.reloadData), with: nil, waitUntilDone: false)
            } else {
                self.petitions = self.allPetitions
                self.tableView.performSelector(onMainThread: #selector(self.tableView.reloadData), with: nil, waitUntilDone: false)
            }
        }
        
    }
    
    @objc func showError() {
        let ac = UIAlertController(title: "Loading Error", message: "There was a problem loading the feed, please check your conection, and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            allPetitions = petitions
            tableView.performSelector(onMainThread: #selector(tableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }


}

