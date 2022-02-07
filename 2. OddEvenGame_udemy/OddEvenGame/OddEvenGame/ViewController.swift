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

class ViewController: UIViewController {
    // IBOutlet 객체 선언
    @IBOutlet weak var computerBallCountLbl: UILabel!
    @IBOutlet weak var userBallCountLbl: UILabel!
    @IBOutlet weak var resultLbl: UILabel!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var fistImage: UIImageView!
    
    
    // 컴퓨터의 구슬, 유저의 구슬 초기화
    var comBallsCount: Int = 20
    var userBallsCount: Int = 20
    
    
    // 초기 화면이 띄워진 후 실행될 것들
    override func viewDidLoad() {
        super.viewDidLoad()
        // 구슬의 텍스트를 직접 지정해줌
        computerBallCountLbl.text = String(comBallsCount)
        userBallCountLbl.text = String(userBallsCount)
        
        // 시작할 때는, fist image가 등장하면 안되므로 숨김처리
        self.imageContainer.isHidden = true
    }
      
    // 게임시작 버튼을 눌렀을 때 실행될 것들
    @IBAction func gameStartPressed(_ sender: Any) {
        print("게임시작!!")
        
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
            self.showAlert()
        }
    }
    
    // alert을 보여주는 함수
    func showAlert() {
        // alert 생성
        let alert = UIAlertController.init(title: "Game Start!", message: "홀 짝을 선택해주세요.", preferredStyle: .alert)
        // 홀 버튼
        let oddBtn = UIAlertAction.init(title: "홀", style: .default) { _ in
            print("홀 버튼을 클릭했습니다.")
            
            // 입력창에 입력한 값을 불러온다.
            // guard를 통해 없을 경우에는 아무것도 하지 않게 한다.
            // guard 문은 두 개를 동시에 쓸 수도 있다.
            // value를 Int 타입으로 변형하기 위한 guard 문을 동시에 사용했다.
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
            print("짝 버튼을 클릭했습니다.")

            // 입력창에 입력한 값을 불러온다.
            // guard를 통해 없을 경우에는 아무것도 하지 않게 한다.
            guard let input = alert.textFields?.first?.text else {
                return
            }
            
            guard let value = Int(input) else {
                return
            }
            
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
            _ in self.showAlert()
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
        
        resultLbl.text = resultMsg
        calculateBalls(winner: winner, betBallCount: betBallCount)

    }
    
    // 주머니가 비었는지 확인하는 함수
    func checkPocketEmpty(balls: Int) -> Bool {
        return balls <= 0
    }
    
    // 매 경기마다 구슬 수를 확인하는 함수
    func calculateBalls(winner: String, betBallCount: Int) -> Void {
        if winner == "USER" {
            if checkPocketEmpty(balls: self.comBallsCount - betBallCount) {
                self.userBallsCount = 20
                self.comBallsCount = 20
                self.resultLbl.text = "유저 최종 승리!"
            } else {
                self.comBallsCount -= betBallCount
                self.userBallsCount += betBallCount
            }
            
        } else {
            if checkPocketEmpty(balls: self.userBallsCount - betBallCount) {
                self.comBallsCount = 20
                self.userBallsCount = 20
                self.resultLbl.text = "컴퓨터 최종 승리!"
            } else {
                self.userBallsCount -= betBallCount
                self.comBallsCount += betBallCount
            }
        }
        
        self.userBallCountLbl.text = String(self.userBallsCount)
        self.computerBallCountLbl.text = "\(self.comBallsCount)"
    }
    
    
        
    func getRandom() -> Int {
        /* arc4random_uniform을 통해 랜덤값을 만든다.
           arc4random_uniform은 UInt32 타입이기 때문에, Int로 형변환을 해준다.
           10을 넣으면 0~9까지를 랜덤으로 주기 때문에 +1 을 해준다.
        */
        return Int(arc4random_uniform(10)) + 1
    }
}

