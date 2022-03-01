//
//  GameViewController.swift
//  OddEvenGame_Snapkit
//
//  Created by 59 on 2022/02/28.
//

import UIKit
import SnapKit
import Then

extension String {
    func toAttributeString() -> NSAttributedString{
        return NSAttributedString(string: self)
    }
}

class GameViewController: UIViewController {
    
    var gameView = GameView()
    var fistView = FistView()
    var settingView = SettingView()
    //메모리 관리(leak 방지,  강한순환참조 방지) 목적으로 옵셔널 사용
    var gameViewModel: GameViewModel? = GameViewModel(defaultBalls: 20)
    var settingViewModel: SettingViewModel? = SettingViewModel()
    
    // 게임시작 버튼
    var gameStartBtn = UIButton(type: .system).then {
        //way 1 초기값 설정
//       let btnText: NSAttributedString = NSAttributedString(string: "GAME START")
        //way2 extension 활용.
        let btnText: NSAttributedString = "GAME Start".toAttributeString()
        // NSAttributedString을 통해, Label Text를 원하는대로 만들기
        $0.setAttributedTitle(btnText, for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemYellow
        // 게임시작 버튼 눌렀을때 Action
        $0.addTarget(self, action: #selector(gameStartPressed(_:)), for: .touchUpInside)
    }

    // 세팅 버튼
    private var settingBtn = UIButton(type: .system).then {
        let btnImg = UIImage(systemName: "command")
        
        // 이미지 버튼 설정
        var config = UIButton.Configuration.filled()
        config.title = "설정"
        config.image = UIImage(systemName: "command")
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .black
        config.background.strokeWidth = 0.5
        config.background.strokeColor = .black
        config.imagePadding = 3
        config.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 10, bottom: 10, trailing: 10)
        config.buttonSize = .mini
        
        // 이미지를 좌측, 글자를 우측으로 고정
        $0.semanticContentAttribute = .forceLeftToRight
        $0.configuration = config
        
        // 세팅 버튼을 눌렀을 때 Action
        $0.addTarget(self, action: #selector(settingBtnPressed(_:)), for: .touchUpInside)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fistView.isHidden = true
        setupLayout()
        setCustomUI()
        
        guard let gameViewModel = gameViewModel else { return }
        gameViewModel.soundPlay(fileName: "intro")
    }
}

// MARK: - 버튼 클릭 관련
extension GameViewController {
    
    @objc
    func gameStartPressed(_ sender: UIButton) {
        guard let viewModel = self.gameViewModel else {
            return
        }

        // 게임 시작하면 세팅버튼 보이지 않게 하기
        self.settingBtn.isHidden = true
        
//        // 버튼을 클릭할 때 사운드 재생
//        // 단, Refresh 버튼을 눌렀을때는 재생하지 않음
//        if viewModel.gameStatus == .onGoing {
//
//        }
        
        // 버튼의 이름이 REFRESH라면, 재시작 함수 실행
        // if sender.titleLabel?.text == "REFRESH" {
        // 게임이 종료되었다면, refresh 함수 실행
        if viewModel.gameStatus == .gameOver {
            self.initLabels()
            // 게임 상태 바꾸기
            guard let viewModel = self.gameViewModel else { return }
            viewModel.gameStatus = .onGoing
            
        // 버튼의 이름이 GAME START라면,
        // 애니메이션과 함께 게임 시작 함수 실행
        } else {
            viewModel.soundPlay(fileName: "gamestart")
            //애니메이션 이벤트가 종료되면 호출이되도록 클로저를 활용
            //메모리 관리(leak 방지,  강한순환참조 방지) 목적으로 [weak self] 선언하고 self를 사용.
            self.fistView.animationEvent { [weak self] in
                guard let self = self else { return }
                self.showPopup()
            }
        }
    }
}

// MARK: - 세팅화면 관련
extension GameViewController: SetDelegate {
    
    @objc
    func settingBtnPressed(_ sender: UIButton) {
        let settingView = SetViewController()
        settingView.settingDelegate = self
        settingView.modalPresentationStyle = .currentContext
        self.present(settingView, animated: true, completion: nil)
    }
    
    func setting (ballCount: Int) {
        guard let gameModel = self.gameViewModel else { return }
        gameModel.userBallsCount = ballCount
        gameModel.comBallsCount = ballCount
        gameModel.settingBallCount = ballCount
        
        updateScreenByResult(result: ballCountUpdateAfterSetting(ballCount: ballCount))
    }
}

// MARK: - 화면이 바뀌는 메서드
extension GameViewController {
    // 게임버튼의 텍스트 바꾸기
    func startBtnText(text: String) -> NSAttributedString {
        let btnString = text
        let font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        let attributes = [NSAttributedString.Key.font: font]
        let attributedString = NSAttributedString(string: btnString, attributes: attributes)
        
        return attributedString
    }
    
    // 게임이 종료되면, 버튼 라벨을 REFRESH로 바꾸기
    func updateScreenByResult(result: GameResult) {
        gameView.updateResultText(gameResult: result)
        if result.gameStatus == .gameOver {
            let btnText: NSAttributedString = startBtnText(text: StartBtnText.refresh.toString())
            self.gameStartBtn.setAttributedTitle(btnText,
                                                 for: .normal)
            // 세팅버튼 보이게 하기
            self.settingBtn.isHidden = false
        }
        
    }
    
    // 세팅 후, 구슬 수 Label Text 바꾸기
    func ballCountUpdateAfterSetting (ballCount: Int) -> GameResult {
        return GameResult (userCountText: "남은 구슬 갯수 : \(ballCount)개",
                           comCountText: "남은 구슬 갯수 : \(ballCount)개",
                           resultMessage: "결과 화면",
                           winner: nil,
                           gameStatus: .onGoing)
    }
    
    // 게임 종료 후, Refresh 버튼을 누르면 Label 초기화 하기
    func initLabels() {
        // REFRESH -> GAMESTART
        let btnText: NSAttributedString = startBtnText(text: StartBtnText.gameStart.toString())
        self.gameStartBtn.setAttributedTitle(btnText,
                                             for: .normal)
        
        // 구슬 초기화
        guard let viewModel = self.gameViewModel else { return }
        viewModel.userBallsCount = viewModel.settingBallCount
        viewModel.comBallsCount = viewModel.settingBallCount
        // LABEL 초기화
        let gameResult = GameResult(userCountText: "남은 구슬 갯수 : \(viewModel.settingBallCount)개",
                                    comCountText: "남은 구슬 갯수 : \(viewModel.settingBallCount)개",
                                    resultMessage: "결과 화면",
                                    winner: nil,
                                    gameStatus: .onGoing)
        updateScreenByResult(result: gameResult)
    }
}

// MARK: - 로직
extension GameViewController {
    func getWhoisWinner(betBallCount: Int,currentBallCount: Int, userChoice: SelectOption){
        guard let gameViewModel = self.gameViewModel else { return }
        
        if gameViewModel.isAvailableToGameStart(betBallCount: betBallCount, currentBallCount: gameViewModel.userBallsCount) {
            self.updateScreenByResult(result: gameViewModel.getWinner(betBallCount: betBallCount, userChoice: userChoice))
        } else {
            self.warningAlert(betBallCount: betBallCount, currentBallCount: gameViewModel.userBallsCount)
        }
    }
}

// MARK: - Alert창 관련
extension GameViewController {
    func showPopup() {
        // alert 생성
        let alert = UIAlertController.init(title: "Game Start!", message: "홀 짝을 선택해주세요.", preferredStyle: .alert)
        // 홀 버튼
        let oddBtn = UIAlertAction.init(title: SelectOption.odd.toString(), style: .default) { [weak self] _ in
            guard let self = self, let gameViewModel = self.gameViewModel else { return }
            // 클릭 시 사운드 재생
            gameViewModel.soundPlay(fileName: "click")
            
            // 입력창에 입력한 값을 불러온다.
            // 해당 값이 nil일 경우, default를 0으로 한다.
            let input: String = alert.textFields?.first?.text ?? "0"
            let value: Int = Int(input) ?? 0
            
            self.getWhoisWinner(betBallCount: value, currentBallCount: gameViewModel.userBallsCount, userChoice: .odd)
        }
        
        // 짝 버튼
        let evenBtn = UIAlertAction.init(title: SelectOption.even.toString(), style: .default) { [weak self] _ in
            guard let self = self, let gameViewModel = self.gameViewModel else { return }
            // 클릭 시 사운드 재생
            gameViewModel.soundPlay(fileName: "click")

            // 입력창에 입력한 값을 불러온다.
            // 해당 값이 nil일 경우, default를 0으로 한다.
            let input: String = alert.textFields?.first?.text ?? "0"
            let value: Int = Int(input) ?? 0
            
            self.getWhoisWinner(betBallCount: value, currentBallCount: gameViewModel.userBallsCount, userChoice: .even)
        }
        
        // alert 창에 버튼 및 입력창을 추가해준다.
        alert.addAction(oddBtn)
        alert.addAction(evenBtn)
        alert.addTextField { textField in
            textField.resignFirstResponder()
            textField.placeholder = "배팅할 구슬의 수"
            textField.textAlignment = .center
            textField.keyboardType = UIKeyboardType.numberPad
            textField.returnKeyType = .done
        }
        
        // alert 창을 실제로 화면에 띄운다.
        self.present(alert, animated: true)
    }
    
    func warningAlert(betBallCount: Int, currentBallCount: Int) {
        var warningMsg: String = ""
        if betBallCount == 0 {
            warningMsg = "1개 이상 배팅해주세요."
        } else if currentBallCount < betBallCount {
            warningMsg = "구슬이 부족합니다."
        }
        let warningAlert = UIAlertController.init(title: "앗!", message: warningMsg, preferredStyle: .alert)
        
        let confirmBtn = UIAlertAction.init(title: "다시 배팅하기", style: .default) {
            _ in self.showPopup()
        }
        
        warningAlert.addAction(confirmBtn)
    
        self.present(warningAlert, animated: true)
    }
}

// MARK: - 화면 레이아웃 및 제약
extension GameViewController {
    
    // 레이아웃 세팅
    func setupLayout() {
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.view.addSubview(self.gameStartBtn)
        self.view.addSubview(self.gameView)
        self.view.addSubview(self.fistView)
        self.view.addSubview(self.settingBtn)
    }
    
    // 제약 세팅
    func setCustomUI() {
        // 게임버튼 제약 추가
        gameStartBtn.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        // MainStackView에 제약 추가
        gameView.mainStackView.snp.makeConstraints {
            $0.bottom.equalTo(gameStartBtn.snp.top)
            $0.leading.trailing.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        // FistView에 제약 추가
        fistView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
            
        }
        
        // settingBtn에 제약 추가
        settingBtn.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(5)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-10)
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
        }
    }
}
