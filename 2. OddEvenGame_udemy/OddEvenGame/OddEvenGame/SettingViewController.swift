//
//  SettingViewController.swift
//  OddEvenGame
//
//  Created by 59 on 2022/02/13.
//

import UIKit

protocol SettingDelegate {
    func setting(ballCount: Int)
}

class SettingViewController: UIViewController {

    var delegate: SettingDelegate?
    
    @IBOutlet weak var countInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submitBtnPressed(_ sender: UIButton) {
        guard let ballCount = self.countInput?.text else {
            print("값을 입력해라")
            return
        }
        
        self.delegate?.setting(ballCount: Int(ballCount) ?? 0)
        
        // 내비게이션 컨트롤러를 사용했을 경우, 설정 완료 시 뒤로가기가 됨
//        navigationController?.popViewController(animated: true)
        
        // 모달창을 전체화면으로 했을 경우 뒤로가기 버튼이 없으므로,
        // 세팅완료 버튼을 누르면 이전으로 돌아가도록 만들어야 함
        self.dismiss(animated: true, completion: nil)
    }
    
    

}
