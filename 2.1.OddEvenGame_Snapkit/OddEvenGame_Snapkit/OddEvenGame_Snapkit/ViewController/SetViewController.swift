//
//  SetViewController.swift
//  OddEvenGame_Snapkit
//
//  Created by 59 on 2022/02/28.
//

import UIKit

protocol SetDelegate {
    func setting(ballCount: Int)
}

class SetViewController: UIViewController {

    var delegate: SetDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
