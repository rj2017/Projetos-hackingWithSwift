//
//  ViewController.swift
//  Project15
//
//  Created by Raphael de Jesus on 09/02/22.
//

import UIKit

class ViewController: UIViewController {
    
    var image: UIImageView!
    var curretAnimation = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        image = UIImageView(image: UIImage(named: "penguin"))
        image.center = CGPoint(x: 512, y: 384)
        image.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image)
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor)
        ])
        
    }

    @IBAction func Tapped(_ sender: UIButton) {
        
        sender.isHidden = true
        
//        UIView.animate(withDuration: 1, delay: 0, options: []) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: []) {
            switch self.curretAnimation {
            case 0:
                self.image.transform = CGAffineTransform(scaleX: 2, y: 2)
                break
            case 1:
                self.image.transform = .identity
            case 2:
                self.image.transform = CGAffineTransform(translationX: -256, y: -256)
            case 3:
                self.image.transform = .identity
            case 4:
                self.image.transform = CGAffineTransform(rotationAngle: .pi)
            case 5:
                self.image.transform = .identity
            case 6:
                self.image.alpha = 0.1
                self.image.backgroundColor = .green
            case 7:
                self.image.alpha = 1
                self.image.backgroundColor = .clear
            default:
                break
            }
        } completion: { finished in
            sender.isHidden = false
        }

        
        curretAnimation += 1
        
        if curretAnimation > 7 {
            curretAnimation = 0
        }
    }
    
}

