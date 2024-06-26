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
 //
 */

import UIKit
import SnapKit

class ViewController: UIViewController {
    var clView: ClView!
    var oper = "+-*/"
    
    override func loadView() {
        super.loadView()
        clView = ClView(frame: self.view.frame) //clView 이니셜라이즈 초기화 관련
        
        self.view = clView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("값이 제대로 오는지 확인")
        
        // 버튼들이 제대로 초기화되었는지 확인
                if clView.buttons.isEmpty {
                    print("버튼 배열이 비어있습니다.")
                } else {
                    print("버튼 배열 초기화 성공")
                }

        clView.buttons.forEach{
            $0.addTarget(self, action: #selector(buttonClicked), for: .touchDown)
        }
    }
    
    @objc
    func buttonClicked(_ sender: UIButton){
        guard let buttonTitle = sender.currentTitle else { return }
        
        switch buttonTitle{
        case "AC":
            // 초기화 로직
            clView.displayLabel.text = "0"
            return
        case "=":
            // 계산 로직
            // BTexpression을 굳이 선언해준 이유는, 가독성 면에서도 그렇고 안전하게 언래핑하기 위함도 있다.
            if let BTexpression = clView.displayLabel.text{
                if let result = calculate(expression: BTexpression) {
                    clView.displayLabel.text = "\(result)"
                }else {
                    clView.displayLabel.text = "에러 발생"
                }
                return
            }
        default:
            // 연산기호 중복 제거
            if let checkOper = clView.displayLabel.text, let lastChar = checkOper.last{
                if oper.contains(lastChar) && oper.contains(buttonTitle){
                    clView.displayLabel.text?.removeLast()
                }else if checkOper == "0" && oper.contains(buttonTitle) {
                 // 첫째 자리에 연산기호 X
                    return
                }
            }
            
            // 기본값이 0일 때, 새로운 값으로 대체
            if clView.displayLabel.text == "0" {
                clView.displayLabel.text = buttonTitle
            } else {
                clView.displayLabel.text = (clView.displayLabel.text ?? "") + buttonTitle
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


