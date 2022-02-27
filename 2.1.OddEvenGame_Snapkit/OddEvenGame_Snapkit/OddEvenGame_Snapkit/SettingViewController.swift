//
//  SettingViewController.swift
//  OddEvenGame_Snapkit
//
//  Created by 59 on 2022/02/21.
//

import UIKit
import SnapKit
import Then

protocol SettingDelegate {
    func setting(ballCount: Int)
}

class SettingViewController: UIViewController {

    // delegate 생성
    var delegate: SettingDelegate?
    
    // MARK: - Make Components
    // MARK: -- before Then Library
//    // 텍스트 라벨
//    private var textLabel = { () -> UILabel in
//        let textLabel = UILabel()
//        textLabel.text = "구슬 수를 입력하세요."
//        textLabel.font = .systemFont(ofSize: 25.0, weight: .medium)
//        return textLabel
//    }()
//
//    // Input
//    private var countInput = { ()-> UITextField in
//        let input = UITextField()
//        // input 영역 테두리 설정
//        input.borderStyle = .line
//        let string = "초기 구슬 수를 입력해주세요."
//        let placeHolderText = NSAttributedString(string: string, attributes: [
//            .foregroundColor: UIColor.lightGray,
//            .font: UIFont.systemFont(ofSize: 14)
//        ])
//        input.resignFirstResponder()
//        input.attributedPlaceholder = placeHolderText
//        input.textAlignment = .center
//        input.keyboardType = UIKeyboardType.numberPad
//        return input
//    }()
//
//    // Submit Button
//    private var submitBtn = { () -> UIButton in
//        let button = UIButton(type: .system)
//        button.setTitle("확인", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = .lightGray
//
//        // 버튼 눌렀을 때 동작 설정
//        button.addTarget(self, action: #selector(submitBtnPressed(_:)), for: .touchUpInside)
//        return button
//    }()
//
//    // Stack
//    private var stackView = { () -> UIStackView in
//        let labelStackView = UIStackView()
//        labelStackView.axis = .vertical
//        labelStackView.alignment = .center
//        labelStackView.distribution = .fill
//        labelStackView.spacing = 34
//        return labelStackView
//    }()
//
    
    // MARK: -- after Then Library
    // 텍스트 라벨
    private var textLabel = UILabel().then {
        $0.text = "구슬 수를 입력하세요."
        $0.font = .systemFont(ofSize: 25.0, weight: .medium)
    }
    
    // Input
    private var countInput = UITextField().then {
        // input 영역 테두리 설정
        $0.borderStyle = .line
        let string = "초기 구슬 수를 입력해주세요."
        let placeHolderText = NSAttributedString(string: string, attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.systemFont(ofSize: 14)
        ])
        
        $0.resignFirstResponder()
        $0.attributedPlaceholder = placeHolderText
        $0.textAlignment = .center
        $0.keyboardType = UIKeyboardType.numberPad
    }
    
    // Submit Button
    private var submitBtn = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .lightGray
        
        // 버튼 눌렀을 때 동작 설정
        $0.addTarget(self, action: #selector(submitBtnPressed(_:)), for: .touchUpInside)
    }
    
    // Stack
    private var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fill
        $0.spacing = 34
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        constraint()
        
        // 키보드가 올라가면서, 화면이 같이 올라가도록 한다.
        keyboardOpenCloseEvent()
    }
}


// MARK: - 기능
extension SettingViewController {
    @objc
    func submitBtnPressed(_ sender: UIButton) {
        // countInput을 입력하지 않았을 때, 혹은 숫자가 아닐 때 경고창
        guard let count = self.countInput.text, let countInt = Int(count) else {
            warningAlert()
            return
        }
        // countInput이 정상적으로 입력되었을 때, delegate 메서드 실행
        self.delegate?.setting(ballCount: countInt)
        // 모달창이 열리는 것이므로, 확인 버튼을 누른 후 자동으로 닫히도록 설정
        self.dismiss(animated: true, completion: nil)
    }
        
    
    // 입력하지 않을 시 Alert 창
    func warningAlert() {
        let warningMsg = "초기 구슬 갯수를 입력해주세요."
        let warningAlert = UIAlertController.init(title: "앗!", message: warningMsg, preferredStyle: .alert)
        let confirmBtn = UIAlertAction.init(title: "확인", style: .default) { _ in
            // 안에 아무것도 입력하지 않으므로,
            // 확인 버튼을 눌렀을 때 아무 동작도 하지 않고 닫힌다.
        }
        warningAlert.addAction(confirmBtn)
        self.present(warningAlert, animated: true)
    }
}

// MARK: - View Layer 및 Constraint 관련
extension SettingViewController {
    
    private func setupLayout() {
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        // view에 요소들 추가
        self.view.addSubview(stackView)
        stackView.addArrangedSubview(textLabel)
        stackView.addArrangedSubview(countInput)
        self.view.addSubview(submitBtn)
    }
    
    private func constraint() {
        
        stackView.snp.makeConstraints { view in
            view.center.equalToSuperview()
        }
        
        submitBtn.snp.makeConstraints { btn in
            btn.width.equalTo(80)
            btn.centerX.equalToSuperview()
            btn.top.equalTo(stackView.snp.bottom).offset(50)
        }
        
        countInput.snp.makeConstraints { input in
            input.width.equalTo(200)
        }
    }

}

// MARK: - 키보드관련 설정
extension SettingViewController {
    @objc
    func keyboardWillShow(_ sender: Notification) {
        
        // 키보드 창이 올라올 때, 확인버튼의 위치를 계산해서
        // 키보드에 가려지지 않도록 화면을 위로 올려준다.
        if let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            let btnMaxY = submitBtn.frame.maxY
            let btnMinY = submitBtn.frame.minY
            let btnHeight = btnMaxY - btnMinY
            let frameY = view.frame.maxY
            let emptySpace = frameY - btnMaxY
            if emptySpace < keyboardHeight {
                self.view.frame.origin.y -= keyboardHeight - emptySpace + btnHeight
            } else {
                self.view.frame.origin.y -= btnHeight
            }
        }
    }
    
    @objc
    func keyboardWillHide(_ sender: Notification) {
        // 키보드 창이 내려갈 때, 화면을 원래 위치로 돌려준다.
        self.view.frame.origin.y = 0
    }
    
    // 키보드 열고 닫힐 때를 감지하여 메서드 실행
    func keyboardOpenCloseEvent() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // 여백을 터치할 경우, 키보드가 아래로 내려가도록 설정
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }

//
//    // 내일 추가로 공부해볼 것
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        countInput.resignFirstResponder()
//        return true
//    }
}
