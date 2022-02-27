//
//  GameView.swift
//  OddEvenGame_Snapkit
//
//  Created by 59 on 2022/02/28.
//

import UIKit
import SnapKit
import Then

// MARK: - View 구성요소 생성
class GameView: UIView {
    
    // 전체 스택뷰
    var mainStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = 4
    }

    // Label을 담을 스택뷰 (구슬 수, 경기 결과)
    var labelStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = 4
    }
    
    // 컴퓨터 이미지
    var comImage = UIImageView().then {
        $0.image = UIImage(named: "comImage")
        $0.contentMode = .scaleAspectFit
    }
    
    // 유저 이미지
    var userImage = UIImageView().then {
        $0.image = UIImage(named: "userImage")
        $0.contentMode = .scaleAspectFit
    }
    
    // 컴퓨터 구슬 라벨
    var computerBallCountLbl = UILabel().then {
        $0.text = "남은 구슬 갯수 : 20개"
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 17)
    }
    
    // 유저 구슬 라벨
    var userBallCountLbl = UILabel().then {
        $0.text = "남은 구슬 갯수 : 20개"
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 17)
    }
    
    // 결과 텍스트 라벨
    var resultLbl = UILabel().then {
        $0.text = "결과 화면"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 30)
    }
    
    // 시작 버튼의, 텍스트
    func gameBtnText(text: String) -> NSAttributedString {
        let btnString = text
        let font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        let attributes = [NSAttributedString.Key.font: font]
        let attributedString = NSAttributedString(string: btnString, attributes: attributes)
        
        return attributedString
    }
    
    // 생성자를 통해서 뷰 위치 지정
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.drawCustomUI()
    }
    
    @available(*,unavailable)
    required init?(coder decoder: NSCoder) {
        fatalError("init coder has not been implemented")
    }
    
    // 레이어 구성
    private func drawCustomUI() {
        self.addSubview(mainStackView)
        
        // mainStackView에 추가할 요소 리스트
        let mainSubViewList: [UIView] = [comImage, labelStackView, userImage]
        // labelStackView에 추가할 요소 리스트
        let labelSubViewList: [UIView] = [computerBallCountLbl, resultLbl, userBallCountLbl]
        
        // labelStackView에 각 Label 요소들 추가
        labelSubViewList.forEach { self.labelStackView.addArrangedSubview($0) }
        // mainStackView에 각 Label 요소들 추가
        mainSubViewList.forEach { self.mainStackView.addArrangedSubview($0) }
        
        self.mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - View Update 메서드
extension GameView {
    // 결과에 따른 Label 업데이트
    func updateResultText(gameResult: GameResult) {
        self.userBallCountLbl.text = gameResult.userCountText
        self.computerBallCountLbl.text = gameResult.comCountText
        self.resultLbl.text = gameResult.gameStatus == .gameOver
                            ? "\(gameResult.winner!) 최종 승리!"
                            : "\(gameResult.resultMessage)"
    }
}
