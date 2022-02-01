//
//  ViewController.swift
//  MusicPlayer
//
//  Created by 59 on 2022/01/30.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 버튼을 중앙에 배치하기 위해 버튼의 수평과 수직의 중앙 앵커를 뷰 컨트롤러의 뷰의 중앙에 기준을 잡아준다. 생성된 제약을 적용하기 위해서 isActive 프로퍼티 값을 true로 설정해준다.
        
        // translateAutoresizingMaskIntoConstrains : 오토레이아웃이 도입되기 전, 뷰를 유연하게 표현할 수 있도록 오토리사이징마스크를 사용했다. 오토레이아웃을 사용하게 되면 기존의 오토리사이징 마스크가 가지고있던 제약 조건이 자동으로 추가되기 때문에, 충돌할 수 있으므로 false 처리 해준다. 참고로, 인터페이스 빌더에서 오토레이아웃을 적용한 경우에는 자동으로 값이 false로 설정된다.
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var constrainX: NSLayoutConstraint
        constrainX = button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        var constrainY: NSLayoutConstraint
        constrainY = button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        
        constrainX.isActive = true
        constrainY.isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        var buttonConstrainX: NSLayoutConstraint
        buttonConstrainX = label.centerXAnchor.constraint(equalTo: button.centerXAnchor)
        
        var topConstraint: NSLayoutConstraint
        topConstraint = label.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -10)
        
        buttonConstrainX.isActive = true
        topConstraint.isActive = true
        
        
        // 레이블의 너비가 버튼의 2배가 되도록 만들어보기
        var widthConstraint: NSLayoutConstraint
        widthConstraint = label.widthAnchor.constraint(equalTo: button.widthAnchor, multiplier: 2.0)
        
        label.backgroundColor = UIColor.brown
        button.backgroundColor = UIColor.blue
        
        widthConstraint.isActive = true
        
    }
}
