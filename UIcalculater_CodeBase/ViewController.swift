//
//  ViewController.swift
//  UIcalculater_CodeBase
//
//  Created by 머성이 on 6/20/24.
//

/*
 🧑🏻‍💻 `UIStackView` 을 사용해서 4개의 버튼을 모아 가로 스택뷰 생성. 왼쪽과 같이 구성해보세요.

 - **`UIButton` 속성**
     - `font = .boldSystemFont(ofSize: 30)`
     - `backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)`
     - `frame.size.height = 80`
     - `frame.size.width = 80`
     - `layer.cornerRadius = 40`
 - **`horizontalStackView` 속성**
     - `axis = .horizontal`
     - `backgroundColor = .black`
     - `spacing = 10`
     - `distribution = .fillEqually`
 - **`horizontalStackView AutoLayout`**
     - height = 80
 */

import UIKit
import SnapKit

class ViewController: UIViewController {
    let displayLabel = UILabel()
    let horizontalStackView = UIStackView()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("값이 제대로 오는지 확인")
        ConfigureUI()
    }
    
    private func ConfigureUI(){
        //배경 검은색 설정
        view.backgroundColor = .black
        
        // 디스플레이 레이블 설정
        displayLabel.text = "12345"
        displayLabel.textColor = .white
        displayLabel.textAlignment = .right
        displayLabel.font = UIFont.boldSystemFont(ofSize: 60)
        
        // 버튼 설정 클로저 , map 응용
        let buttons: [UIButton] = ["7", "8", "9", "+"].map { num in
            button.setTitle(num, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
            button.backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
            button.frame.size.height = 80
            button.frame.size.width = 80
            button.layer.cornerRadius = 40
            button.addTarget(self, action: #selector(buttonClicked), for: .touchDown)
            
            return button
        }
        
        // 가로 스택뷰 속성
        horizontalStackView.axis = .horizontal
        horizontalStackView.backgroundColor = .black
        horizontalStackView.spacing = 10
        horizontalStackView.distribution = .fillEqually
       
        // 버튼들을 horizontalStackView에 넣기
       buttons.forEach{ horizontalStackView.addSubview($0)}
        
        // displayLabel, horizontalStackView을 View에 추가
        [displayLabel,horizontalStackView]
            .forEach{ view.addSubview($0)}
        
        // offset은 뷰를 기준으로 외부 방향으로 거리를 설정
        // inset은 뷰를 기준으로 내부 방향으로 거리를 설정
        // 디스플레이 레이블 오토 레이아웃
        displayLabel.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().inset(30)
            $0.top.equalToSuperview().offset(200)
        }
        
        // horizontalStackView 오토 레이아웃
        horizontalStackView.snp.makeConstraints{
            $0.height.equalTo(80)
        }
    }
    
    @objc
    private func buttonClicked(){
        print("안농")
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


