//
//  SettingViewController.swift
//  OddEvenGame_Snapkit
//
//  Created by 59 on 2022/02/21.
//

import UIKit
import SnapKit

protocol SettingDelegate {
    func setting(ballCount: Int)
}

class SettingViewController: UIViewController {

    // MARK: Make Components
    
    // delegate 생성
    var delegate: SettingDelegate?
    
    // 텍스트 라벨
    private var textLabel = { () -> UILabel in
        let textLabel = UILabel()
        textLabel.text = "구슬 수를 입력하세요."
        textLabel.font = .systemFont(ofSize: 25.0, weight: .medium)
        return textLabel
    }()
    
    // Input
    private var countInput = { ()-> UITextField in
        let input = UITextField()
        // input 영역 테두리 설정
        input.borderStyle = .line
        // 설정창이 열리면 input 영역에 자동으로 첫번째 포커스가 맞춰지도록 설정하기
        input.becomeFirstResponder()
        return input
    }()
    
    // Submit Button
    private var submitBtn = { () -> UIButton in
        let button = UIButton(type: .system)
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .lightGray
        
        // 버튼 눌렀을 때 동작 설정
        button.addTarget(self, action: #selector(submitBtnPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    // Stack
    private var stackView = { () -> UIStackView in
        let labelStackView = UIStackView()
        labelStackView.axis = .vertical
        labelStackView.alignment = .center
        labelStackView.distribution = .fill
        labelStackView.spacing = 34
        return labelStackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        constraint()

        // Do any additional setup after loading the view.
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
