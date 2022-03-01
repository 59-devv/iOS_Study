//
//  SettingViewModel.swift
//  OddEvenGame_Snapkit
//
//  Created by 59 on 2022/02/28.
//

import UIKit


protocol SetDelegate {
    func setting(ballCount: Int)
}

class SettingViewModel {

    var delegate: SetDelegate?
    
    // 해당 값이 0보다 큰지 판별하는 함수
    func isBiggerThanZero(ballsStr: Int) -> Bool {
        return ballsStr > 0
    }
    
    // String -> Int 로 변환
    func stringToInt(text: String?) -> Int {
        guard let strValue = text, let intValue = Int(strValue) else {
            return 0
        }
        return intValue
    }
}
