//
//  ViewController.swift
//  Cinemetrage
//
//  Created by Fernando Pérez Ruiz on 02/12/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(Bundle.main.readAndDecodeJSON(file: "genre_list") as Any)
        
    }


}

