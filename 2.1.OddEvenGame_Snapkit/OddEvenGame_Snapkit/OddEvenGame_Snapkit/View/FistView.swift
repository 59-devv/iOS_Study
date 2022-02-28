//
//  FistView.swift
//  OddEvenGame_Snapkit
//
//  Created by 59 on 2022/02/28.
//

import UIKit
import SnapKit
import Then

class FistView: UIView {
    
    // 주먹 쥔 손 이미지
    private var fistImage = UIImageView().then {
        $0.image = UIImage(named: "fistImage")
        $0.contentMode = .scaleAspectFit
    }
    
    func drawCustomUI() {
        self.backgroundColor = .white
        self.addSubview(fistImage)
        self.fistImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.isHidden = true
    }
    
    //생성자를 통해서 뷰 위치 지정
    public override init(frame:CGRect) {
        super.init(frame: frame)
        self.drawCustomUI()
    }
    
    @available(*,unavailable)
    required init?(coder decoder: NSCoder) {
        fatalError("init coder has not been implemented")
    }
    
    // Animation 이후의 Event를 CallBack으로 받을 수 있다.
    func animationEvent(completion: @escaping () -> ()){
        self.chageHiddenState()
        UIView.animate(withDuration: 1.0) {
            self.fistImage.transform = CGAffineTransform(scaleX: 5, y: 5)
            self.fistImage.transform = CGAffineTransform(scaleX: 1, y: 1)
        } completion: { _ in
            self.chageHiddenState()
            completion()
        }
    }
    
    func chageHiddenState(){
        self.isHidden = !self.isHidden
    }
}
