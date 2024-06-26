//
//  ClView.swift
//  UIcalculater_CodeBase
//
//  Created by 머성이 on 6/26/24.
//

import UIKit
import SnapKit

class ClView: UIView {
    lazy var displayLabel: UILabel = {
        let label = UILabel()
        
        // 디스플레이 레이블 설정
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 60)
    
        return label
    }()
    
    var buttons: [UIButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(){
        //배경 검은색 설정
        self.backgroundColor = .black
        
        self.addSubview(displayLabel)
        
        // displayLabel을 View에 추가
        [displayLabel].forEach{
            self.addSubview($0)
        }
        
        // 수직 스택 뷰 생성
            let verStackView = UIStackView()
            verStackView.axis = .vertical
            verStackView.backgroundColor = .black
            verStackView.spacing = 10
            verStackView.distribution = .fillEqually

        // horizontalStackView가 생성될 때 마다 4개씩 끊어서 verticalStackView에 투척
        for i in stride(from: 0, to: ClButtons.texts.count, by: 4){
            let row = Array(ClButtons.texts[i..<min(i + 4, ClButtons.texts.count)])
            
            let horizontalStackView = makeHorizontalStackView(row)
            verStackView.addArrangedSubview(horizontalStackView)
        }
        self.addSubview(verStackView)
        
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
        verStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(displayLabel.snp.bottom).offset(60)
            $0.width.equalTo(350)
        }
    }
    
    private func makeHorizontalStackView(_ views: [String]) -> UIStackView{
        // 버튼 설정 클로저 , map 응용
        let rowButtons = views.map { num in
            let button = UIButton()
            button.setTitle(num, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
            button.frame.size.height = 80
            button.frame.size.width = 80
            button.layer.cornerRadius = 40
            
            // 연산 버튼 orange 색상 변경
            if "+-*/=AC".contains(num){
                button.backgroundColor = UIColor.orange
            }else{
                button.backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
            }
            
            buttons.append(button)
            
            return button
        }

        // 가로 스택뷰 속성
        let HorizontalStackView = UIStackView(arrangedSubviews: rowButtons)
            HorizontalStackView.axis = .horizontal
            HorizontalStackView.backgroundColor = .black
            HorizontalStackView.spacing = 10
            HorizontalStackView.distribution = .fillEqually
            
            HorizontalStackView.snp.makeConstraints{
            $0.height.equalTo(80)
        }
        
        return HorizontalStackView
    }
    
    
}
