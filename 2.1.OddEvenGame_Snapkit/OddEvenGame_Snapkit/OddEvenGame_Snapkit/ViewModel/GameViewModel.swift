//
//  GameViewModel.swift
//  OddEvenGame_Snapkit
//
//  Created by 59 on 2022/02/28.
//

import UIKit
import AVFAudio

// MARK: - Setting Enums
// 현재 게임이 진행중인지, 끝났는지
enum GameStatus {
    case onGoing
    case gameOver
}

// 유저와 컴퓨터
enum Player: String {
    case com = "Computer"
    case user = "User"
    
    // 출력 시, 원시값("홀", "짝")을 출력하도록 메서드 생성
    func toString() -> String {
        return self.rawValue
    }
}

// 홀, 짝
enum SelectOption: String {
    case odd = "홀"
    case even = "짝"
    
    // 출력 시, 원시값("홀", "짝")을 출력하도록 메서드 생성
    func toString() -> String {
        return self.rawValue
    }
}

// 게임버튼의 텍스트
enum StartBtnText: String {
    case gameStart = "GAME START"
    case refresh = "REFRESH"
    
    // 출력 시, 원시값을 출력하도록 메서드 생성
    func toString() -> String {
        return self.rawValue
    }
}

// MARK: - ViewModel
// 게임 진행의 로직과 관련한 코드를 담을 Game View Model 생성
class GameViewModel {
    
    // MARK: -- 주요 Property 생성 및 초기화 함수 구현
    
    // 오디오 재생 플레이어
    var audioPlayer: AVAudioPlayer?
    
    // 컴퓨터와 유저의 구슬
    var comBallsCount: Int
    var userBallsCount: Int
    var settingBallCount: Int = 20
    var gameStatus: GameStatus = .onGoing
    
    init(defaultBalls: Int) {
        self.userBallsCount = defaultBalls
        self.comBallsCount = defaultBalls
    }
}

extension GameViewModel {
    
    //  MARK: -- 게임 진행 관련 메서드 구현
    
    func refresh() -> GameResult {
        // 공 숫자 및 Lbl 초기화
        let defaultBalls = settingBallCount
        self.userBallsCount = defaultBalls
        self.comBallsCount = defaultBalls
        return GameResult(
            userCountText: "남은 구슬 갯수 : \(self.userBallsCount)개",
            comCountText: "남은 구슬 갯수 : \(self.comBallsCount)개",
            resultMessage: "결과 화면",
            winner: nil,
            gameStatus: self.gameStatus)
    }
    
    // 매 경기마다의 승자 판별하는 함수
    func getWinner(betBallCount: Int, userChoice: SelectOption) -> GameResult {
        let comNumber = getRandom()
        let comType = comNumber % 2 == 0
                                    ? SelectOption.even
                                    : SelectOption.odd
        let winner = userChoice == comType
                                ? Player.user
                                : Player.com
        
        let statusResult = self.calculateBalls(winner: winner, betBallCount: betBallCount)
        
        return GameResult(userCountText: "남은 구슬 갯수 : \(self.userBallsCount)개",
                          comCountText: "남은 구슬 갯수 : \(self.comBallsCount)개",
                          resultMessage: "\(comType.toString())! \(winner.toString()) win!",
                          winner: winner,
                          gameStatus: statusResult)
    }
    
    func calculateBalls(winner: Player, betBallCount: Int) -> GameStatus {
        if winner == Player.user {
            if checkPocketEmpty(balls: self.comBallsCount - betBallCount) {
                self.userBallsCount += self.comBallsCount
                self.comBallsCount = 0
                self.gameStatus = .gameOver
                return self.gameStatus
            } else {
                self.comBallsCount -= betBallCount
                self.userBallsCount += betBallCount
                self.gameStatus = .onGoing
                return self.gameStatus
            }
            
        } else {
            if checkPocketEmpty(balls: self.userBallsCount - betBallCount) {
                self.comBallsCount = self.comBallsCount + betBallCount
                self.userBallsCount = 0
                self.gameStatus = .gameOver
                return self.gameStatus
            } else {
                self.userBallsCount -= betBallCount
                self.comBallsCount += betBallCount
                self.gameStatus = .onGoing
                return self.gameStatus
            }
        }
    }
    
    // 주머니가 비었는지 확인하는 함수
    func checkPocketEmpty(balls: Int) -> Bool {
        return balls <= 0
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
    
    // Betting Ball Count가 현재 구슬보다 많은지 확인
    func isAvailableToGameStart(betBallCount: Int, currentBallCount: Int) -> Bool {
        return (betBallCount != 0 && currentBallCount >= betBallCount)
    }
}

// MARK: - Sound 관련
extension GameViewModel {
    // 사운드
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
            self.audioPlayer = try AVAudioPlayer(contentsOf: filePath)
            // 위에서 설정한 Player가 없을 경우를 대비해서 guard문을 사용해준다.
            guard let soundPlayer = self.audioPlayer else {
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
