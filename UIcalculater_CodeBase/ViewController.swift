//
//  ViewController.swift
//  UIcalculater_CodeBase
//
//  Created by 머성이 on 6/20/24.
//


/*
 <aside>
 🧑🏻‍💻 `UILabel` 을 사용해서 수식을 표시할 수 있는 라벨을 띄웁니다.

 - **속성**
     - `backgroundColor = .black`
     - `textColor = .white`
     - 우선, 텍스트는 `12345` 로 고정
     - 텍스트 오른쪽 정렬
     - Font = 시스템 볼드체, 사이즈 60
 - **AutoLayout**
     - leading, trailing = superView 로 부터 30 떨어지도록 세팅
     - top = superView 로 부터 200 떨어지도록 세팅
     - height = 100
 </aside>
 */

import UIKit
import SnapKit

class ViewController: UIViewController {
    let testLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("값이 제대로 오는지 확인")
        ConfigureUI()
    }
    
    private func ConfigureUI(){
        //배경 검은색 설정
        view.backgroundColor = .black
        
        // 디스플레이 레이블 설정
        testLabel.text = "12345"
        testLabel.textColor = .white
        testLabel.textAlignment = .right
        testLabel.font = UIFont.boldSystemFont(ofSize: 60)
        
        [testLabel]
            .forEach{ view.addSubview($0)}
        
        // offset은 뷰를 기준으로 외부 방향으로 거리를 설정
        // inset은 뷰를 기준으로 내부 방향으로 거리를 설정
        testLabel.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().inset(30)
            $0.top.equalToSuperview().offset(200)
        }
    }
    
    //버튼 배열 값 넣기
    
    
    //버튼 쪽 스택 뷰 구현 예시
    /*
     7, 8, 9 +
     4, 5, 6 -
     1 ,2 ,3 *
     AC,0 ,= ,/
     */
    

    
    
    //디스플레이 스택 뷰 구현
    
    
}


