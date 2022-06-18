//
//  TopToolBar.swift
//  Bricks Ball
//
//  Created by peo on 2022/06/18.
//

import UIKit

class TopToolBar: UIView {
    let currentScoreLabel: UILabel = {
        let currentScoreLabel = UILabel()
        currentScoreLabel.textColor = .black
        currentScoreLabel.text = "0"
        currentScoreLabel.font = UIFont.systemFont(ofSize: Const.View.TopToolBar.CurrentScoreLabel.fontSize)
        return currentScoreLabel
    }()
    
    let topScoreLabel: UILabel = {
        let topScoreLabel = UILabel()
        topScoreLabel.textColor = .black
        topScoreLabel.text = "TOP 100"
        topScoreLabel.font = UIFont.systemFont(ofSize: Const.View.TopToolBar.TopScoreLabel.fontSize)
        return topScoreLabel
    }()
    
    let settingButton: UIButton = {
        let settingButton = UIButton()
        settingButton.setBackgroundImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        settingButton.tintColor = .black
        return settingButton
    }()
    
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
        self.addSubview(self.currentScoreLabel)
        self.addSubview(self.topScoreLabel)
        self.addSubview(self.settingButton)
    }
    
    func makeConstraints() {
        self.currentScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.currentScoreLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.currentScoreLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            
        ])
        
        self.topScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topScoreLabel.leadingAnchor.constraint(equalTo: self.currentScoreLabel.leadingAnchor),
            self.topScoreLabel.topAnchor.constraint(equalTo: self.currentScoreLabel.bottomAnchor)
        ])
        
        self.settingButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.settingButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.settingButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.settingButton.widthAnchor.constraint(equalToConstant: Const.View.TopToolBar.SettingButton.width),
            self.settingButton.heightAnchor.constraint(equalToConstant: Const.View.TopToolBar.SettingButton.height)
        ])
    }
    
    func setCurrentScore(_ score: Int) {
        self.currentScoreLabel.text = String(score)
    }
}
