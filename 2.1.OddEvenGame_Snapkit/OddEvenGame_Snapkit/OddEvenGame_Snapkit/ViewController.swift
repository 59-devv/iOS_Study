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
         * (1) 텍스트 폰트, 크기, 색상 설정
         * (2) 제약 설정
         */
        
        
        
        
    }
}

