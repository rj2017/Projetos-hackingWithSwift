//
//  SecondViewController.swift
//  coordinatorTest
//
//  Created by Raphael de Jesus on 19/01/22.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Second Screen"
        let view = UINib(nibName: "SecondScreen", bundle: .main).instantiate(withOwner: nil, options: nil).first as! UIView
        self.view.frame = view.bounds
        self.view.addSubview(view)
    }
    

}
