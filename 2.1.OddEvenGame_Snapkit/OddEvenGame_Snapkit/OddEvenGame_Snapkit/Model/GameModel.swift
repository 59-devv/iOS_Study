//
//  GameModel.swift
//  OddEvenGame_Snapkit
//
//  Created by 59 on 2022/02/28.
//

import UIKit

struct GameResult {
    var userCountText: String
    var comCountText: String
    var resultMessage: String
    var defaultBall: Int = 20
    var winner: Player?
    var gameStatus: GameStatus
    
    var defaultBallCount: Int {
        get {
            return self.defaultBall
        }
        set {
            self.defaultBall = newValue
        }
    }
}
