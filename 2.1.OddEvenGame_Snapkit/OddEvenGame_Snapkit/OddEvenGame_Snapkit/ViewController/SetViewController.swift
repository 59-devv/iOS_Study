//
//  SetViewController.swift
//  OddEvenGame_Snapkit
//
//  Created by 59 on 2022/02/28.
//

import UIKit
import SnapKit
import Then

class SetViewController: UIViewController {
    
    var settingView = SettingView()

    //메모리 관리(leak 방지,  강한순환참조 방지) 목적으로 옵셔널 사용
    var settingViewModel: SettingViewModel? = SettingViewModel()
    var isKeyboardShown = false
    
//    var submitBtn = UIButton().then {
//        $0.setTitle("확인", for: .normal)
//        $0.setTitleColor(.white, for: .normal)
//        $0.backgroundColor = .lightGray
//        
//        // 버튼 눌렀을 때 동작 설정
//        $0.addTarget(self, action: #selector(submitBtnPressed(_:)), for: .touchUpInside)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setCustomUI()

        keyboardOpenCloseEvent()
        
        self.settingView.delegate = self
    
    }
}

// MARK: - 세팅완료 버튼
extension SetViewController {
//    @objc
//    func submitBtnPressed(_ sender: UIButton) {
//        // countInput을 입력하지 않았을 때, 혹은 숫자가 아닐 때 경고창
//        guard let count = self.settingView.countInput.text, let countInt = Int(count) else {
//            warningAlert()
//            return
//        }
//        // countInput이 정상적으로 입력되었을 때, delegate 메서드 실행
//        self.settingDelegate?.setting(ballCount: countInt)
//        // 모달창이 열리는 것이므로, 확인 버튼을 누른 후 자동으로 닫히도록 설정
//        self.dismiss(animated: true, completion: nil)
//    }
    
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

// MARK: - 키보드관련 설정
extension SetViewController {
    @objc
    func keyboardWillShow(_ sender: Notification) {
        
        // 키보드가 올라온 상태에서는 return 시킨다.
        if self.isKeyboardShown { return }
        
        self.isKeyboardShown = !self.isKeyboardShown
        
        // 키보드 창이 올라올 때, 확인버튼의 위치를 계산해서
        // 키보드에 가려지지 않도록 화면을 위로 올려준다.
        if let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            let btnMaxY = self.settingView.submitBtn.frame.maxY
            let btnMinY = self.settingView.submitBtn.frame.minY
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
        self.isKeyboardShown = false
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
}

// MARK: - 화면 레이아웃 및 제약
extension SetViewController {
    
    // 레이아웃 세팅
    func setupLayout() {
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.view.addSubview(settingView)
    }
    
    // 제약 세팅
    func setCustomUI() {
        settingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
//        submitBtn.snp.makeConstraints { btn in
//            btn.width.equalTo(80)
//            btn.centerX.equalTo(settingView.snp.centerX)
//            btn.top.equalTo(settingView.stackView.snp.bottom).offset(50)
//        }
    }
}

extension SetViewController: SubmitButtonDelegate {
    func buttonPressed(defaultBalls: String?) {
        guard let vm = self.settingViewModel else { return }
        if vm.isBiggerThanZero(ballsStr: vm.stringToInt(text: defaultBalls)) {
            // countInput이 정상적으로 입력되었을 때, delegate 실행
            vm.delegate?.setting(ballCount: vm.stringToInt(text: defaultBalls))
            print("2. after button Pressed, \(defaultBalls!)")
            
            // 확인 버튼을 누른 후 자동으로 닫히도록 설정
            self.dismiss(animated: true, completion: nil)
        } else {
            warningAlert()
        }
    }
}

// MARK: - SwiftUI 미리보기 만들기
enum DeviceType {
    case iPhoneSE2
    case iPhone8
    case iPhone12Pro
    case iPhone12ProMax

    func name() -> String {
        switch self {
        case .iPhoneSE2:
            return "iPhone SE"
        case .iPhone8:
            return "iPhone 8"
        case .iPhone12Pro:
            return "iPhone 12 Pro"
        case .iPhone12ProMax:
            return "iPhone 12 Pro Max"
        }
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI
extension UIViewController {

    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }

    func showPreview(_ deviceType: DeviceType = .iPhone12Pro) -> some View {
        Preview(viewController: self).previewDevice(PreviewDevice(rawValue: deviceType.name()))
    }
}

struct ViewController_Preview: PreviewProvider {
    static var previews: some View {
        SetViewController().showPreview(.iPhone12Pro)
    }
}
#endif
