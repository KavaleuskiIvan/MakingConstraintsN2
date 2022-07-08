//
//  ImageTwoLinedButton.swift
//  MakingConstraintsN2
//
//  Created by Kavaleuski Ivan on 07/07/2022.
//

import UIKit

struct ImageTwoLinedButtonViewModel {
    let primaryText: String
    let secondaryText: String
    let image: UIImage
}

class ImageTwoLinedButton: UIButton {
    let primaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    let secondaryText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    let circleImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    let popularLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular"
        label.backgroundColor = .red
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(primaryLabel)
        addSubview(secondaryText)
        addSubview(circleImage)
        
        
        clipsToBounds = true
        layer.cornerRadius = 33
        layer.borderWidth = 1
        backgroundColor = .systemGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: ImageTwoLinedButtonViewModel, borderColor: CGColor, imageColor: UIColor) {
        primaryLabel.text = viewModel.primaryText
        secondaryText.text = viewModel.secondaryText
        circleImage.image = viewModel.image
        circleImage.tintColor = imageColor
        layer.borderColor = UIColor.white.cgColor
    }
    
    func setSelected() {
        circleImage.image = UIImage(systemName: "checkmark.circle.fill") ?? UIImage()
        circleImage.tintColor = .orange
        layer.borderColor = UIColor.red.cgColor
    }
    
    func setUnselected() {
        circleImage.image = UIImage(systemName: "circle") ?? UIImage()
        circleImage.tintColor = .white
        layer.borderColor = UIColor.white.cgColor
    }
    
    func setupPopularLabel(stackView: UIStackView, onButton: ImageTwoLinedButton) {
        stackView.addSubview(popularLabel)
        
        popularLabel.snp.makeConstraints { make in
            make.trailing.equalTo(onButton.circleImage.snp.leading).inset(-20)
            make.width.equalTo(80)
            make.top.equalTo(onButton.snp.top).inset(-10)
        }
    }
    
    func removePopularLabelFromSuperview() {
        popularLabel.removeFromSuperview()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circleImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(30)
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        primaryLabel.snp.makeConstraints { make in
            make.trailing.equalTo(circleImage.snp.leading)
            make.top.equalToSuperview().inset(5)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
        secondaryText.snp.makeConstraints { make in
            make.trailing.equalTo(circleImage.snp.leading)
            make.top.equalTo(primaryLabel.snp.bottom)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
    }
}
