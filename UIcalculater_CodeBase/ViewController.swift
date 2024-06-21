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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("값이 제대로 오는지 확인")
        configureUI()
    }
    
    private func configureUI(){
        //배경 검은색 설정
        view.backgroundColor = .black
        
        // 디스플레이 레이블 설정
        displayLabel.text = "12345"
        displayLabel.textColor = .white
        displayLabel.textAlignment = .right
        displayLabel.font = UIFont.boldSystemFont(ofSize: 60)

        // displayLabel, horizontalStackView을 View에 추가
        [displayLabel]
            .forEach{ view.addSubview($0)}
        
        let Buttons = ["7","8","9","+"]
        let horizontalStackView = makeHorizontalStackView(Buttons)
        
        view.addSubview(horizontalStackView)
        
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
        horizontalStackView.snp.makeConstraints {
            $0.height.equalTo(80)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().inset(30)
            $0.top.equalTo(displayLabel.snp.bottom).offset(20)
        }
    }
    
    private func makeHorizontalStackView(_ views: [String]) -> UIStackView{
        // 버튼 설정 클로저 , map 응용
        let buttons: [UIButton] = views.map { num in
            let button = UIButton()
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
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.backgroundColor = .black
        stackView.spacing = 10
        stackView.distribution = .fillEqually

        return stackView
    }
    
    @objc
    private func buttonClicked(){
        print("안농")
    }
}

