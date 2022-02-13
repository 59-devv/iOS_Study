//
//  ViewController.swift
//  DelegatePatternPractice
//
//  Created by 59 on 2022/02/13.
//

import UIKit

class ViewController: UIViewController, UserInfoDelegate {

    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userAgeLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnPressed(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "inputViewController") as inputViewController
        
        // 이녀석이 호출한 것이라고 지정해줘야한다.
        viewController.delegate = self
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    // inputViewController에서 생성한 Protocol의 메서드를 구현
    func getInfo(name: String, age: String) {
        self.userNameLbl.text = name
        self.userAgeLbl.text = age
    }
    
}

