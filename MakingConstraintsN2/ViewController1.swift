//
//  ViewController1.swift
//  MakingConstraintsN2
//
//  Created by Kavaleuski Ivan on 12/07/2022.
//

import UIKit
import SnapKit

class ViewController1: UIViewController {
    
    let scrollview: UIScrollView = {
        let sr = UIScrollView()
        sr.translatesAutoresizingMaskIntoConstraints = false
        sr.backgroundColor = .red
        return sr
    }()
    
    let view1: UIImageView = {
        let sr = UIImageView()
        sr.backgroundColor = .cyan
        sr.translatesAutoresizingMaskIntoConstraints = false
        return sr
    }()
    
    let restoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Восстановить", for: .normal)
        button.addTarget(self, action: #selector(restoreButtonPressed), for: .touchUpInside)
        return button
    }()
    
    @objc func restoreButtonPressed() {
        print("pressed")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        makeConstr()
    }
    
    func makeConstr() {
        view.addSubview(scrollview)
        scrollview.addSubview(view1)
        view1.addSubview(restoreButton)
        
        scrollview.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.bottom.equalToSuperview().inset(200)
        }
        
        view1.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.width.equalTo(300)
            make.height.equalTo(739)
        }
        scrollview.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 1000)
        
        restoreButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
    }
}
