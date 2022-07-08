//
//  ReviewCollectionViewCell.swift
//  MakingConstraintsN2
//
//  Created by Kavaleuski Ivan on 08/07/2022.
//

import UIKit
import SnapKit
import Cosmos

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension ReviewCollectionViewCell: ReusableView { }

class ReviewCollectionViewCell: UICollectionViewCell {
    
    let reviewNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()

    let startsView: CosmosView = {
        let view = CosmosView()
        view.settings.updateOnTouch = false
        view.settings.starSize = 18
        view.settings.starMargin = 1
        view.settings.fillMode = .precise
        return view
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()

    let userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        makeConstraints()
        backgroundColor = .darkGray
        layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(reviewName: String, date: String, rating: Double, userName: String, description: String ) {
        reviewNameLabel.text = reviewName
        startsView.rating = rating
        dateLabel.text = date
        userNameLabel.text = userName
        descriptionLabel.text = description
    }
    
    func addSubviews() {
        contentView.addSubview(reviewNameLabel)
        contentView.addSubview(startsView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    func makeConstraints() {
        
        reviewNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(20)
            make.trailing.equalTo(dateLabel.snp.leading)
            make.height.equalTo(20)
        }
        
        startsView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(reviewNameLabel.snp.bottom).inset(-5)
            make.bottom.equalTo(userNameLabel.snp.bottom)
            make.width.equalTo(120)
        }

        dateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(20)
            make.width.equalTo(70)
            make.height.equalTo(20)
        }

        userNameLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(dateLabel.snp.bottom)
            make.height.equalTo(20)
            make.leading.equalTo(startsView.snp.trailing)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(startsView.snp.bottom)
            make.trailing.leading.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(10)
        }
    }
}
