//
//  ViewController.swift
//  UIcalculater_CodeBase
//
//  Created by 머성이 on 6/20/24.
//

// 추가 해야할 것
/*
    1.  m -> model
        v -> 디자인
        c -> view. model 데이터를 갖고와서 컨트롤러

    나누어보기
 
    2. SOLID 적용해보기
 
 */

import UIKit
import SnapKit

class ViewController: UIViewController {
    let displayLabel = UILabel()
    var oper = "+-*/"
    override func viewDidLoad() {
        super.viewDidLoad()
        print("값이 제대로 오는지 확인")
        configureUI()
    }
    
    private func configureUI(){
        //배경 검은색 설정
        view.backgroundColor = .black
        
        // 디스플레이 레이블 설정
        displayLabel.text = "0"
        displayLabel.textColor = .white
        displayLabel.textAlignment = .right
        displayLabel.font = UIFont.boldSystemFont(ofSize: 60)
        
        // displayLabel, horizontalStackView을 View에 추가
        [displayLabel].forEach{ view.addSubview($0)}
        
        let Buttons = ["7", "8", "9", "+",
                       "4", "5", "6", "-",
                       "1", "2", "3", "*",
                       "AC", "0", "=", "/"]
        
        // 수직 스택 뷰 생성
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.backgroundColor = .black
        verticalStackView.spacing = 10
        verticalStackView.distribution = .fillEqually
        
        var rowButtons: [[String]] = []
        
        // horizontalStackView가 생성될 때 마다 4개씩 끊어서 verticalStackView에 투척
        for i in stride(from: 0, to: Buttons.count, by: 4){
            let row = Array(Buttons[i..<min(i + 4, Buttons.count)])
            rowButtons.append(row)
            
            let horizontalStackView = makeHorizontalStackView(row)
            verticalStackView.addArrangedSubview(horizontalStackView)
        }
        
        view.addSubview(verticalStackView)
        
        // offset은 뷰를 기준으로 외부 방향으로 거리를 설정
        // inset은 뷰를 기준으로 내부 방향으로 거리를 설정
        // 디스플레이 레이블 오토 레이아웃
        displayLabel.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().inset(30)
            $0.top.equalToSuperview().offset(200)
        }
        
        // verticalStackView 오토 레이아웃
        verticalStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(displayLabel.snp.bottom).offset(60)
            $0.width.equalTo(350)
        }
    }
    
    private func makeHorizontalStackView(_ views: [String]) -> UIStackView{
        // 버튼 설정 클로저 , map 응용
        let buttons: [UIButton] = views.map { num in
            let button = UIButton()
            button.setTitle(num, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
            
            button.frame.size.height = 80
            button.frame.size.width = 80
            button.layer.cornerRadius = 40
            button.addTarget(self, action: #selector(buttonClicked), for: .touchDown)
            
            // 연산 버튼 orange 색상 변경
            if "+-*/=AC".contains(num){
                button.backgroundColor = UIColor.orange
            }else{
                button.backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
            }
            
            return button
        }
        
        // 가로 스택뷰 속성
        let HstackView = UIStackView(arrangedSubviews: buttons)
        HstackView.axis = .horizontal
        HstackView.backgroundColor = .black
        HstackView.spacing = 10
        HstackView.distribution = .fillEqually
        
        // horizaontalStacview 오토레이 아웃
        HstackView.snp.makeConstraints{
            $0.height.equalTo(80)
        }
        
        return HstackView
    }
    
    @objc
    private func buttonClicked(_ sender: UIButton){
        guard let buttonTitle = sender.currentTitle else { return }
        
        switch buttonTitle{
        case "AC":
            // 초기화 로직
            displayLabel.text = "0"
            return
        case "=":
            // 계산 로직
            // BTexpression을 굳이 선언해준 이유는, 가독성 면에서도 그렇고 안전하게 언래핑하기 위함도 있다.
            if let BTexpression = displayLabel.text{
                if let result = calculate(expression: BTexpression) {
                    displayLabel.text = "\(result)"
                }else {
                    displayLabel.text = "에러 발생"
                }
                return
            }
        default:
            // 중복 제거
            if let checkOper = displayLabel.text, let lastChar = checkOper.last {
                if oper.contains(lastChar) && oper.contains(buttonTitle){
                    displayLabel.text?.removeLast()
                }
            }
            
            // 기본값이 0일 때, 새로운 값으로 대체
            if displayLabel.text == "0" {
                displayLabel.text = buttonTitle
            } else {
                displayLabel.text = (displayLabel.text ?? "") + buttonTitle
            }
        }
    }
    
    /// 수식 문자열을 넣으면 계산해주는 메서드.
    ///
    /// 예를 들어 expression 에 "1+2+3" 이 들어오면 6 을 리턴한다.
    /// 잘못된 형식의 수식을 넣으면 앱이 크래시 난다. ex) "1+2++"
    ///
    /// 'NSExpression' 클래스
    /// -> 문자열 수식을 평가할 수 있는 클래스. 이를 사용하면 기본적인 산술 연산 뿐 아니라 다양한 수학 함수도 사용 가능
    func calculate(expression: String) -> Int? {
        let expression = NSExpression(format: expression)
        if let result = expression.expressionValue(with: nil, context: nil) as? Int {
            return result
        } else {
            return nil
        }
    }
}


