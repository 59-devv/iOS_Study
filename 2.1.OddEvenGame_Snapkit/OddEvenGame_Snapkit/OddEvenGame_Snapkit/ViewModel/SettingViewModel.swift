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
    
}
