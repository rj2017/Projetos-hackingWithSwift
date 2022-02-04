//
//  DetailViewController.swift
//  Project 1
//
//  Created by Raphael de Jesus on 28/12/21.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var selectedImage: String?
    var selectedImageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = selectedImage
        navigationItem.largeTitleDisplayMode = .never
        DispatchQueue.main.async { [weak self] in
            if let imageToLoad = self?.selectedImageName {
                self?.imageView.image = UIImage(named: imageToLoad)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }


}
