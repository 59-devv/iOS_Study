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
    
    // 컴포넌트 객체 생성
    private var computerBallCountLbl: UILabel = UILabel()
    private var userBallCountLbl: UILabel = UILabel()
    private var resultLbl: UILabel = UILabel()
    private var imageContainer: UIView = UIView()
    private var fistImage: UIImageView = UIImageView()
    private var gameStartBtn: UIButton = UIButton()
    private var settingBtn: UIButton = UIButton()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        // view 배경 색상
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        // 위에서 만들어준 객체 리스트
        let subViewList: [UIView] = [computerBallCountLbl, userBallCountLbl, resultLbl
                           , imageContainer, fistImage, gameStartBtn, settingBtn]
        // 리스트를 돌면서, 모두 subView에 띄우기
        for subView in subViewList {
            view.addSubview(subView)
        }
        
        // 각 객체의 레이아웃 설정
        /* 1. computerBallCountLbl, userBallCountLbl : 공 갯수 라벨
         * 텍스트 폰트, 크기, 색상 설정
         */
        // 텍스트 내용
        computerBallCountLbl.text = "남은 구슬 갯수 : 10개"
        userBallCountLbl.text = "남은 구슬 갯수 : 10개"
        // 텍스트 정렬(중앙정렬)
        computerBallCountLbl.textAlignment = .center
        userBallCountLbl.textAlignment = .center
        // 텍스트 폰트와 사이즈
        computerBallCountLbl.font = UIFont.systemFont(ofSize: 17)
        userBallCountLbl.font = UIFont.systemFont(ofSize: 17)
        
        /* 2. resultLbl : 결과 표시 라벨
         * 텍스트 폰트, 크기, 색상 설정
         */
        resultLbl.text = "결과 화면"
        resultLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        resultLbl.textAlignment = .center
        resultLbl.font = UIFont.systemFont(ofSize: 30)
        
        /* 3. 세 개의 라벨을 정렬시키기
         * (1) 결과 화면 라벨을 화면 중앙으로 위치
         * (2) 결과 화면 라벨의 위로 컴퓨터의 남은 구슬 갯수
         * (3) 결과 화면 라벨의 아래로 유저의 남은 구슬 갯수
         */
        resultLbl.snp.makeConstraints( { label in
            label.centerX.equalTo(self.view.safeAreaLayoutGuide.snp.centerX)
            label.centerY.equalTo(self.view.safeAreaLayoutGuide.snp.centerY)
        })
        
        computerBallCountLbl.snp.makeConstraints( { label in
            label.bottom.equalTo(resultLbl.snp.top).offset(-20)
            label.centerX.equalTo(self.view.safeAreaLayoutGuide.snp.centerX)
        })
        
        userBallCountLbl.snp.makeConstraints( { label in
            label.top.equalTo(resultLbl.snp.bottom).offset(20)
            label.centerX.equalTo(self.view.safeAreaLayoutGuide.snp.centerX)
        })
    }
}

