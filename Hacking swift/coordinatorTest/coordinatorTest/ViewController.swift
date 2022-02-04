//
//  ViewController.swift
//  coordinatorTest
//
//  Created by Raphael de Jesus on 18/01/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "First Screen"
        let view = UINib(nibName: "FirstScreen", bundle: .main).instantiate(withOwner: nil, options: nil).first as! UIView
        self.view.frame = view.bounds
        self.view.addSubview(view)
    }

    @IBAction func goToSecond(_ sender: Any) {
        let vc = SecondViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

