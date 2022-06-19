//
//  HomeView.swift
//  Bricks Ball
//
//  Created by peo on 2022/06/16.
//

import UIKit

class HomeView: UIView {
    let singleModeButton: UIButton = {
        let singleModeButton = UIButton()
        singleModeButton.setBackgroundImage(UIImage(systemName: "chart.bar.xaxis")?.withTintColor(.init(white: 1.0, alpha: 0.8)), for: .normal)
        singleModeButton.tintColor = .init(white: 1.0, alpha: 0.8)
        return singleModeButton
    }()
    
    let multiModeButton: UIButton = {
        let singleModeButton = UIButton()
        singleModeButton.setBackgroundImage(UIImage(systemName: "star.fill")?.withTintColor(.init(white: 1.0, alpha: 0.8)), for: .normal)
        singleModeButton.tintColor = .init(white: 1.0, alpha: 0.8)
        return singleModeButton
    }()
    
    func makeSubviews() {
        self.addSubview(self.singleModeButton)
        self.addSubview(self.multiModeButton)
    }
    
    func makeConstraints() {
        self.singleModeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.singleModeButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.singleModeButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.singleModeButton.heightAnchor.constraint(equalToConstant: 40),
            self.singleModeButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        self.multiModeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.multiModeButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.multiModeButton.topAnchor.constraint(equalTo: self.singleModeButton.bottomAnchor, constant: 20),
            self.multiModeButton.heightAnchor.constraint(equalToConstant: 40),
            self.multiModeButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.makeSubviews()
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
