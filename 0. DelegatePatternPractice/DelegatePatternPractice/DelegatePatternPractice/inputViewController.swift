//
//  inputViewController.swift
//  DelegatePatternPractice
//
//  Created by 59 on 2022/02/13.
//

import UIKit

// Protocol 만들기
protocol UserInfoDelegate {
    func getInfo(name: String, age: String)
}


class inputViewController: UIViewController {
    
    var delegate: UserInfoDelegate?
    
    @IBOutlet weak var userNameInput: UITextField!
    @IBOutlet weak var userAgeInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnPressed(_ sender: UIButton) {
        
        guard let userName = self.userNameInput?.text, let userAge = self.userAgeInput.text
        else {
            print("값을 입력해주세요!")
            return
        }
        self.delegate?.getInfo(name: userName, age: userAge)
        // navigationController의 popViewController를 통해서 이전 화면으로 갈 수 있다.
        self.navigationController?.popViewController(animated: true)
    }
    
}
