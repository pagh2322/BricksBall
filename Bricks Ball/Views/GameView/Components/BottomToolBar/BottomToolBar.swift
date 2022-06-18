//
//  BottomToolBar.swift
//  Bricks Ball
//
//  Created by peo on 2022/06/18.
//

import UIKit

class BottomToolBar: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.makeSubviews()
        self.makeConstraints()
        self.backgroundColor = .brown
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeSubviews() {
    }
    
    func makeConstraints() {
    }
    
    
}
