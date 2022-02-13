//
//  ViewController.swift
//  ViewControllerLifeCycleTest
//
//  Created by 59 on 2022/02/13.
//

import UIKit

class ViewController: UIViewController {

    // 1. loadView가 실행되고 자동으로 실행되는 함수
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View가 로드되었습니다.")
    }
    
    // 2. View Controller 화면이 뜨
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("View가 나타날 것입니다.")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("View가 나타났습니다.")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("View가 사라질 것입니다.")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("View가 사라졌습니다.")
    }
    
    @IBAction func btnPressed(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "SecondController") as SecondController
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    
}

