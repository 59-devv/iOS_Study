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
    @IBOutlet weak var gameStartBtn: UIButton!
    
    // 컴퓨터의 구슬, 유저의 구슬 초기화
    var comBallsCount: Int = 20
    var userBallsCount: Int = 20
    
    enum Status {
        case start
        case refresh
    }
    
    var status: Status = .start
    
    // 초기 화면이 띄워진 후 실행될 것들
    override func viewDidLoad() {
        super.viewDidLoad()
        // 구슬의 텍스트를 직접 지정해줌
        computerBallCountLbl.text = String(comBallsCount)
        userBallCountLbl.text = String(userBallsCount)
    }

    
    // 게임시작 버튼을 눌렀을 때 실행될 것들
    @IBAction func gameStartPressed(_ sender: UIButton) {
        /*
        //way1 버튼명을 활용
        if let text = sender.titleLabel?.text {
            print(text)
            if text == "GAME START" {
                print("game start")
                self.gameStartPressed()
            }else{
                print("refresh")
                self.refreshGame()
            }
        }else{
            print("no button title")
        }
        */
        
        //way2 Enum 활용
    
        if status == .start {
            print("game start")
            self.gameStartPressed()
        }else if status == .refresh {
            print("refresh")
            self.refreshGame()
        }else{
            print("no status")
        }
        
    }
    
    func refreshGame(){
        self.comBallsCount = 20
        self.userBallsCount = 20
        
        self.resultLbl.text = "결과화면"
        self.userBallCountLbl.text = "\(userBallsCount)"
        self.computerBallCountLbl.text = "\(comBallsCount)"
    }
    

    func gameStartPressed(){
        print("게임시작!!")
        // alert 창 생성
        let alert = UIAlertController.init(title: "Game Start!", message: "홀 짝을 선택해주세요.", preferredStyle: .alert)
        // 홀 버튼
        let oddBtn = UIAlertAction.init(title: "홀", style: .default) { _ in
            print("홀 버튼을 클릭했습니다.")
            
            // 입력창에 입력한 값을 불러온다.
            // guard를 통해 없을 경우에는 아무것도 하지 않게 한다.
            // guard 문은 두 개를 동시에 쓸 수도 있다.
            // value를 Int 타입으로 변형하기 위한 guard 문을 동시에 사용했다.
            guard let input = alert.textFields?.first?.text, let value = Int(input) else {
                return
            }
            
            print("입력된 값은 \(input) 입니다.")
            self.getWinner(betBallCount: value, userChoice: "홀")
            
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
            self.getWinner(betBallCount: value, userChoice: "짝")
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
            //way1
            self.gameStartBtn.setTitle("Refresh", for: .normal)
            //way2
            self.status = .refresh
        }
    }
    
    func getWinner(betBallCount: Int, userChoice: String) -> Void {
        let comNumber = getRandom()
        let comType = comNumber % 2 == 0 ? "짝" : "홀"
        let winner = userChoice == comType ? "USER" : "COMPUTER"
        let resultMsg = "\(comType)! \(winner) win!"
        
        print("\(winner) Win!")
        
        resultLbl.text = resultMsg
        calculateBalls(winner: winner, betBallCount: betBallCount)

    }
    
    func calculateBalls(winner: String, betBallCount: Int) -> Void {
        if winner == "USER" {
            self.userBallsCount += betBallCount
            self.comBallsCount -= betBallCount
        } else {
            self.userBallsCount -= betBallCount
            self.comBallsCount += betBallCount
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

