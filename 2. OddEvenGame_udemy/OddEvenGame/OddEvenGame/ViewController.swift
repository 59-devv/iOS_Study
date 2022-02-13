//
//  ViewController.swift
//  OddEvenGame
//
//  Created by 59 on 2022/02/01.
//
/*
    1. 게임시작 버튼을 누른다.
    2. 사용자는 초기 시작 구슬 개수를 입력한다.
    3. 컴퓨터가 1~10까지의 숫자 중 하나를 랜덤선택한다.
    4. 사용자가 홀/짝을 선택한다.
    5. 결과에 따라 컴퓨터와 사용자의 구슬 수를 업데이트 한다.
 */


import UIKit
import AVFoundation

class ViewController: UIViewController {
    // IBOutlet 객체 선언
    @IBOutlet weak var computerBallCountLbl: UILabel!
    @IBOutlet weak var userBallCountLbl: UILabel!
    @IBOutlet weak var resultLbl: UILabel!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var fistImage: UIImageView!
    @IBOutlet weak var gameStartBtn: UIButton!
    
    
    // 사운드를 실행할 오디오 플레이어 변수 생성
    var player: AVAudioPlayer?
    
    // 컴퓨터의 구슬, 유저의 구슬 초기화
    var comBallsCount: Int = 20
    var userBallsCount: Int = 20
    
    // 게임이 진행중인지 끝났는지 판별해주는 enum 생성
    enum Status {
        case onGoing
        case gameOver
    }
    
    // 게임 진행 상황 변수
    var gameStatus: Status = .onGoing
    
    // 초기 화면이 띄워진 후 실행될 것들
    override func viewDidLoad() {
        super.viewDidLoad()
        // 구슬의 텍스트를 직접 지정해줌
        self.computerBallCountLbl.text = String(comBallsCount)
        self.userBallCountLbl.text = String(userBallsCount)
        
        // 시작할 때는, fist image가 등장하면 안되므로 숨김처리
        self.imageContainer.isHidden = true
        // 정상적으로 파일 경로를 가져오는지 테스트
        self.soundPlay(fileName: "intro")
    }
    
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
    
    // 게임시작 버튼을 눌렀을 때 실행될 것들
    // sender를 버튼으로 설정해주고, 버튼의 이름을 활용할 예정이다.
    @IBAction func gameStartPressed(_ sender: UIButton) {
        print("게임시작!!")
        print(sender.titleLabel?.text ?? "No Title")
        
        // 버튼을 클릭할 때 사운드 재생
        self.soundPlay(fileName: "gamestart")
        
        // 버튼의 이름이 REFRESH라면, 재시작 함수 실행
        // if sender.titleLabel?.text == "REFRESH" {
        // 게임이 종료되었다면, refresh 함수 실행
        if self.gameStatus == .gameOver {
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
        self.comBallsCount = 20
        self.userBallsCount = 20
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

