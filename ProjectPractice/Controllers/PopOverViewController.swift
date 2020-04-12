//
//  PopOverViewController.swift
//  ProjectPractice
//
//  Created by Sako Hovaguimian on 4/11/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo

enum Option: Int, CaseIterable {
    
    case pokemon
    case digimon
    case yugioh
    
    var name: String {
        
        switch self {
            case .pokemon: return "Pokemon"
            case .digimon: return "Digimon"
            case .yugioh: return "Yu-Gi-Oh"
        }
        
    }
    
    static var numberOfItems: Int {
        return self.allCases.count
    }

}

protocol OptionButtonTappedDelegate: class {
    func handleOptionButtonTapped(forOption option: Option)
}

class PopOverViewController: UIViewController {
    
    weak var optionsButtonDelegate: OptionButtonTappedDelegate!
    
    private lazy var optionsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: self.generateOptionButtons())
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.axis = .vertical
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureViews()
        self.view.backgroundColor = .white
        
    }
    
    private func configureViews() {
        self.view.addSubview(self.optionsStackView)
        self.optionsStackView.anchor(top: self.view.topAnchor,
                                     left: self.view.leftAnchor,
                                     bottom: self.view.bottomAnchor,
                                     right: self.view.rightAnchor,
                                     paddingTop: 0,
                                     paddingLeft: 0,
                                     paddingBottom: 16,
                                     paddingRight: 0)
    }
    
    private func generateOptionButtons() -> [UIButton] {
        
        var options = [UIButton]()
        
        for i in 0..<Option.numberOfItems {
            
            let option = Option(rawValue: i)
            let optionName = option?.name ?? ""
            
            let button = UIButton(type: .system)
            button.tag = i
            button.setTitle(optionName, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .white
            button.addTarget(self, action: #selector(self.handleButtonTapped(sender:)), for: .touchUpInside)
            options.append(button)
            
        }
        
        return options
        
    }
    
    @objc private func handleButtonTapped(sender: UIButton) {
        if let option = Option(rawValue: sender.tag) {
            self.optionsButtonDelegate.handleOptionButtonTapped(forOption: option)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
