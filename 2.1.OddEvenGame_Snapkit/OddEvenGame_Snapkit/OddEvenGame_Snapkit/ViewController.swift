//
//  ViewController.swift
//  OddEvenGame_Snapkit
//
//  Created by 59 on 2022/02/20.
//

import AVFoundation
import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // MARK: Make Components
    // 상위 Stack View 생성 (컴퓨터 이미지, 하위 Stack View, 유저 이미지)
    private var mainStackView = { () -> UIStackView in
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.alignment = .fill
        mainStackView.distribution = .fillEqually
        mainStackView.spacing = 4
        return mainStackView
    }()
    
    // 하위 Stack View 생성 (결과화면, 컴퓨터 구슬 수, 유저 구슬 수)
    private var labelStackView = { () -> UIStackView in
        let labelStackView = UIStackView()
        labelStackView.axis = .vertical
        labelStackView.alignment = .fill
        labelStackView.distribution = .fillEqually
        labelStackView.spacing = 4
        return labelStackView
    }()
    
    // 컴퓨터가 가진 구슬 수 라벨
    private var computerBallCountLbl = { () -> UILabel in
        let computerBallCountLbl = UILabel()
        computerBallCountLbl.text = "남은 구슬 갯수 : 10개"
        computerBallCountLbl.textAlignment = .center
        computerBallCountLbl.font = UIFont.systemFont(ofSize: 17)
        return computerBallCountLbl
    }()
    
    // 유저가 가진 구슬 수 라벨
    private var userBallCountLbl = { () -> UILabel in
        let userBallCountLbl = UILabel()
        userBallCountLbl.text = "남은 구슬 갯수 : 10개"
        userBallCountLbl.textAlignment = .center
        userBallCountLbl.font = UIFont.systemFont(ofSize: 17)
        return userBallCountLbl
    }()
    
    // 결과 텍스트 라벨
    private var resultLbl = { () -> UILabel in
        let resultLbl = UILabel()
        resultLbl.text = "결과 화면"
        resultLbl.textColor = .black
        resultLbl.textAlignment = .center
        resultLbl.font = UIFont.systemFont(ofSize: 30)
        return resultLbl
    }()
    
    // 컴퓨터 이미지
    private var comImage = { () -> UIImageView in
        let comImage = UIImageView()
        comImage.image = UIImage(named: "comImage")
        comImage.contentMode = .scaleAspectFit
        return comImage
    }()
    
    // 유저 이미지
    private var userImage = { () -> UIImageView in
        let userImage = UIImageView()
        userImage.image = UIImage(named: "userImage")
        userImage.contentMode = .scaleAspectFit
        return userImage
    }()
    
    // 이미지컨테이너
    private var imageContainer = { () -> UIView in
        let imageContainer = UIView()
        imageContainer.backgroundColor = .white
        return imageContainer
    }()
    
    // 주먹 쥔 손 이미지
    private var fistImage = { () -> UIImageView in
        let fistImage = UIImageView()
        fistImage.image = UIImage(named: "fistImage")
        fistImage.contentMode = .scaleAspectFit
        return fistImage
    }()
    
    // 게임시작 버튼
    private var gameStartBtn = { () -> UIButton in
        let gameStartBtn = UIButton(type: .system)
        
        // NSAttributedString을 통해, Label Text를 원하는대로 만들기
        let btnString = "GAME START"
        let font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        let attributes = [NSAttributedString.Key.font: font]
        let attributedString = NSAttributedString(string: btnString, attributes: attributes)
        gameStartBtn.setAttributedTitle(attributedString, for: .normal)
        gameStartBtn.setTitleColor(.white, for: .normal)
        gameStartBtn.backgroundColor = .systemYellow
        // 게임시작 버튼 눌렀을때 Action
        gameStartBtn.addTarget(self, action: #selector(gameStartPressed(_:)), for: .touchUpInside)
        return gameStartBtn
    }()

    // 세팅 버튼
    private var settingBtn = { () -> UIButton in
        let settingBtn = UIButton(type: .system)
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
        settingBtn.semanticContentAttribute = .forceLeftToRight
        settingBtn.configuration = config
        
        return settingBtn
    }()
    
    
    // MARK: Sound
    // 사운드를 실행할 오디오 플레이어 변수 생성
    var player: AVAudioPlayer?
    
    
    // MARK: 게임 진행 요소 초기화
    // 컴퓨터의 구슬, 유저의 구슬 초기화
    var comBallsCount: Int = 20
    var userBallsCount: Int = 20
    
    // 구슬 설정 변경했을 때 저장해놓고, refresh 할 때 이용
    var settingBallCount: Int = 20
    
    // 게임이 진행중인지 끝났는지 판별해주는 enum 생성
    enum Status {
        case onGoing
        case gameOver
    }
    
    // 게임 진행 상황 변수
    var gameStatus: Status = .onGoing
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupConstraint()
        
        // 구슬의 텍스트를 직접 지정해줌
        self.computerBallCountLbl.text = String(comBallsCount)
        self.userBallCountLbl.text = String(userBallsCount)
        
        // 시작할 때는, fist image가 등장하면 안되므로 숨김처리
        self.imageContainer.isHidden = true
        // 정상적으로 파일 경로를 가져오는지 테스트
        self.soundPlay(fileName: "intro")
    }
}

// MARK: View Layer 및 Constraint 관련
extension ViewController {

    // 레이어 구성
    private func setupLayout() {
        // view 배경 색상
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        // mainStackView에 추가할 요소 리스트
        let mainSubViewList: [UIView] = [comImage, labelStackView, userImage]
        // labelStackView에 추가할 요소 리스트
        let labelSubViewList: [UIView] = [computerBallCountLbl, resultLbl, userBallCountLbl]
        
        // labelStackView에 각 Label 요소들 추가
        labelSubViewList.forEach{ labelStackView.addArrangedSubview($0) }
        // mainStackView에 각 Label 요소들 추가
        mainSubViewList.forEach{ mainStackView.addArrangedSubview($0) }
        
        // imageContainer에 fistImage 추가
        imageContainer.addSubview(fistImage)
        
        // view에 각 요소들 순서대로 추가
        // 코드상으로 아래에 위치할수록, View에서는 상위에 존재함
        view.addSubview(gameStartBtn)
        view.addSubview(mainStackView)
        view.addSubview(imageContainer)
        view.addSubview(settingBtn)
    }
    
    // 제약 설정
    private func setupConstraint() {
        // GameStart Button 제약 추가
        gameStartBtn.snp.makeConstraints( { button in
            button.centerX.equalTo(self.view.safeAreaLayoutGuide.snp.centerX)
            button.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
            button.height.equalTo(50)
        } )

        // MainStackView에 제약 추가
        mainStackView.snp.makeConstraints( {stackView in
            stackView.top.equalTo(self.view.safeAreaLayoutGuide)
            stackView.bottom.equalTo(gameStartBtn.snp.top)
            stackView.leading.trailing.top.equalTo(self.view.safeAreaLayoutGuide)
            stackView.centerX.equalTo(self.view.safeAreaLayoutGuide.snp.centerX)
        } )
        
        // LabelStackView에 제약 추가
        labelStackView.snp.makeConstraints( {stackView in
            stackView.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            stackView.centerX.equalTo(self.view.safeAreaLayoutGuide.snp.centerX)
        } )
        
        // imageContainer에 제약 추가
        imageContainer.snp.makeConstraints( { container in
            container.edges.equalTo(self.view.safeAreaLayoutGuide)
        } )
        
        // FistImage에 제약 추가
        fistImage.snp.makeConstraints( { image in
            image.edges.equalTo(imageContainer)
        } )
        
        // settingBtn에 제약 추가
        settingBtn.snp.makeConstraints( { btn in
            btn.height.greaterThanOrEqualTo(5)
            btn.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-10)
            btn.top.equalToSuperview().offset(50)
        })
    }
}

// MARK: Sound 관련
extension ViewController {
    // 사운드 재생 함수
    func soundPlay(fileName: String) {
        // 파일의 경로를 지정해준다.
        // Bundle = 실행 가능한 코드와 그 코드가 사용하는 자원을 포함하고 있는 디렉토리
        // main Bundle = 현재 실행중인 코드가 들어있는 디렉토리
        // 파일이름과 확장자를 적어주고 경로를 찾는다.
    
        // 해당 경로에 파일이 있을지 없을지 모르기 때문에, 예외처리를 해줘야한다.
        guard let filePath = Bundle.main.url(forResource: fileName, withExtension: "mp3") else {
            return
        }
        print("filePath: \(filePath)")
        
        // try? Optional을 통해서 선언해줄 수도 있지만, do-catch 구문을 사용할 수도 있다.
        // self.player = try? AVAudioPlayer(contentsOf: filePath)
        do {
            self.player = try AVAudioPlayer(contentsOf: filePath)
            // 위에서 설정한 Player가 없을 경우를 대비해서 guard문을 사용해준다.
            guard let soundPlayer = self.player else {
                return
            }
            
            // prepareToPlay는 사운드를 재생할 오디오 플레이어를 미리 준비하는 것이다.
            // 호출 시 버퍼를 미리 로드하고, 재생할 오디어 하드웨어를 호출하므로
            // 플레이어를 실행시키는 시간과 플레이 하는 시간 사이의 로드를 최소화한다.
            // 하지만 prepareToPlay 함수를 사용하지 않아도, 암시적으로 자동 실행한다.
            soundPlayer.prepareToPlay()
            // 사운드가 너무 커서 줄여주었다.
            soundPlayer.setVolume(0.1, fadeDuration: 0)
            soundPlayer.play()
            
        } catch let error {
            print("\(error.localizedDescription)")
        }
    }
}

// MARK: 게임 기능 관련
extension ViewController {
    // 게임시작 버튼을 눌렀을 때 실행될 것들
    // sender를 버튼으로 설정해주고, 버튼의 이름을 활용할 예정이다.
    @objc
    func gameStartPressed(_ sender: UIButton) {
        print("게임시작!!")
        print(sender.titleLabel?.text ?? "No Title")
        
        // 게임 시작하면 세팅버튼 보이지 않게 하기
        self.settingBtn.isHidden = true
        
        // 버튼을 클릭할 때 사운드 재생
        self.soundPlay(fileName: "gamestart")
        
        // 버튼의 이름이 REFRESH라면, 재시작 함수 실행
        // if sender.titleLabel?.text == "REFRESH" {
        // 게임이 종료되었다면, refresh 함수 실행
        if self.gameStatus == .gameOver {
            // 게임 끝나면 세팅버튼 다시 나오게 하기
            self.refresh()
        // 버튼의 이름이 GAME START라면,
        // 애니메이션과 함께 게임 시작 함수 실행
        } else {
            // 애니메이션이 시작될 수 있도록 이미지를 보이게 함
            self.imageContainer.isHidden = false
            // 애니메이션
            UIView.animate(withDuration: 1.0) {
                // 다섯배 확대
                self.fistImage.transform = CGAffineTransform(scaleX: 5, y: 5)
                // 원래 배율로 돌아옴
                self.fistImage.transform = CGAffineTransform(scaleX: 1, y: 1)
                // 애니메이션이 완료됐을 때 아래 실행
            } completion: { _ in
                self.imageContainer.isHidden = true
                // Alert 띄우기
                self.gameStart()
            }
        }
    }
    
    // game start alert을 보여주는 함수
    func gameStart() {
        // alert 생성
        let alert = UIAlertController.init(title: "Game Start!", message: "홀 짝을 선택해주세요.", preferredStyle: .alert)
        
        // 홀 버튼
        let oddBtn = UIAlertAction.init(title: "홀", style: .default) { _ in
            // 클릭 시 사운드 재생
            self.soundPlay(fileName: "click")
            
            // 입력창에 입력한 값을 불러온다.
            // 해당 값이 nil일 경우, default를 0으로 한다.
            let input: String = alert.textFields?.first?.text ?? "0"
            let value: Int = Int(input) ?? 0
            
            print("입력된 값은 \(input) 입니다.")
            
            if value != 0 && self.userBallsCount >= value {
                self.getWinner(betBallCount: value, userChoice: "홀")
            } else {
                self.warningAlert(betBallCount: value,
                                  currentBallCount: self.userBallsCount)
            }
        }
        
        // 짝 버튼
        let evenBtn = UIAlertAction.init(title: "짝", style: .default) { _ in
            // 클릭 시 사운드 재생
            self.soundPlay(fileName: "click")

            // 입력창에 입력한 값을 불러온다.
            // 해당 값이 nil일 경우, default를 0으로 한다.
            let input: String = alert.textFields?.first?.text ?? "0"
            let value: Int = Int(input) ?? 0
            
            print("입력된 값은 \(input) 입니다.")
            
            if value != 0 && self.userBallsCount >= value {
                self.getWinner(betBallCount: value, userChoice: "짝")
            } else {
                self.warningAlert(betBallCount: value,
                                  currentBallCount: self.userBallsCount)
            }
        }
        
        // alert 창에 버튼 및 입력창을 추가해준다.
        alert.addAction(oddBtn)
        alert.addAction(evenBtn)
        alert.addTextField { textField in
            textField.placeholder = "배팅할 구슬의 수"
        }
        
        // alert 창을 실제로 화면에 띄운다.
        // self는 프로그램 자체를 의미한다.
        self.present(alert, animated: true) {
            print("화면이 띄워졌습니다.")
        }
    }
    
    // 게임 재시작
    func refresh() {
        // 공 숫자 및 Lbl 초기화
        self.comBallsCount = self.settingBallCount
        self.userBallsCount = self.settingBallCount
        self.userBallCountLbl.text = String(self.userBallsCount)
        self.computerBallCountLbl.text = String(self.comBallsCount)
        self.resultLbl.text = "결과 화면"
        // 재기작 하였으므로, 버튼이름을 다시 GAME START로 바꾸어줌
        self.gameStartBtn.setTitle("GAME START", for: .normal)
        self.gameStatus = .onGoing
    }
    
    // 현재 가진 구슬보다 많이 배팅할 수 없고
    // 0개를 배팅할 수 없도록 alert 생성
    func warningAlert(betBallCount: Int, currentBallCount: Int) {
        var warningMsg: String = ""
        if betBallCount == 0 {
            warningMsg = "1개 이상 배팅해주세요."
        } else if currentBallCount < betBallCount {
            warningMsg = "구슬이 부족합니다."
        }
        let warningAlert = UIAlertController.init(title: "앗!", message: warningMsg, preferredStyle: .alert)
        
        let confirmBtn = UIAlertAction.init(title: "다시 배팅하기", style: .default) {
            _ in self.gameStart()
        }
        
        warningAlert.addAction(confirmBtn)
    
        self.present(warningAlert, animated: true)
    }

    // 매 경기마다의 승자 판별하는 함수
    func getWinner(betBallCount: Int, userChoice: String) -> Void {
        let comNumber = getRandom()
        let comType = comNumber % 2 == 0 ? "짝" : "홀"
        let winner = userChoice == comType ? "USER" : "COMPUTER"
        let resultMsg = "\(comType)! \(winner) win!"
        
        print("\(winner) Win!")
        
        self.resultLbl.text = resultMsg
        self.calculateBalls(winner: winner, betBallCount: betBallCount)

    }
    
    // 주머니가 비었는지 확인하는 함수
    func checkPocketEmpty(balls: Int) -> Bool {
        return balls <= 0
    }
    
    // 매 경기마다 구슬 수를 확인하는 함수
    func calculateBalls(winner: String, betBallCount: Int) -> Void {
        if winner == "USER" {
            if checkPocketEmpty(balls: self.comBallsCount - betBallCount) {
                self.userBallsCount += self.comBallsCount
                self.comBallsCount = 0
                self.resultLbl.text = "유저 최종 승리!"
                self.gameStartBtn.setTitle("REFRESH", for: .normal)
                self.gameStatus = .gameOver
                self.settingBtn.isHidden = false
            } else {
                self.comBallsCount -= betBallCount
                self.userBallsCount += betBallCount
            }
            
        } else {
            if checkPocketEmpty(balls: self.userBallsCount - betBallCount) {
                self.comBallsCount = self.comBallsCount + betBallCount
                self.userBallsCount = 0
                self.resultLbl.text = "컴퓨터 최종 승리!"
                self.gameStartBtn.setTitle("REFRESH", for: .normal)
                self.gameStatus = .gameOver
                self.settingBtn.isHidden = false
            } else {
                self.userBallsCount -= betBallCount
                self.comBallsCount += betBallCount
            }
        }
        
        self.userBallCountLbl.text = String(self.userBallsCount)
        self.computerBallCountLbl.text = "\(self.comBallsCount)"
    }
    
    // 컴퓨터가 1~10까지 랜덤 수를 생성하도록 하는 함수
    // 결국 이 숫자의 홀, 짝을 맞추는 게임이다.
    func getRandom() -> Int {
        /* arc4random_uniform을 통해 랜덤값을 만든다.
           arc4random_uniform은 UInt32 타입이기 때문에, Int로 형변환을 해준다.
           10을 넣으면 0~9까지를 랜덤으로 주기 때문에 +1 을 해준다.
        */
        return Int(arc4random_uniform(10)) + 1
    }
}
