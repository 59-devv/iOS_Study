//
//  SettingModel.swift
//  OddEvenGame_Snapkit
//
//  Created by 59 on 2022/02/28.
//

import UIKit

struct SettingModel {
    var balls: Int
    
    var countBalls: Int {
        get {
            return self.balls
        }
        set {
            self.balls = newValue
        }
    }
}
