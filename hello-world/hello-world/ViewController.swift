//
//  ViewController.swift
//  hello-world
//
//  Created by Berk Çohadar on 9/5/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func changeButtonClick(_ sender: Any) {
        if (imageView.image == UIImage(named:"valorant")){
            imageView.image = UIImage(named: "league-of-legends")
        }
        else{
            imageView.image = UIImage(named: "valorant")
        }
    }
    

}

