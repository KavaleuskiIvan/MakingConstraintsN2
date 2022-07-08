//
//  ViewController.swift
//  MakingConstraintsN2
//
//  Created by Kavaleuski Ivan on 07/07/2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dark-road") ?? UIImage()
        imageView.backgroundColor = .brown
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let restoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Восстановить", for: .normal)
        button.addTarget(self, action: #selector(restoreButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let unlimitedAccessLabel: UILabel = {
        let label = UILabel()
        label.text = "Неограниченный доступ"
        label.font = .systemFont(ofSize: 26, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        return stackView
    }()
    
    let lifetimePlanButton: ImageTwoLinedButton = {
        let button = ImageTwoLinedButton()
        button.configure(with: ImageTwoLinedButtonViewModel(primaryText: "Пожизненный доступ", secondaryText: "7490 Разовый платеж", image: UIImage(systemName: "circle") ?? UIImage()), borderColor: UIColor.white.cgColor, imageColor: .white)
        button.addTarget(self, action: #selector(lifetimePlanButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let threeMonthPlanButton: ImageTwoLinedButton = {
        let button = ImageTwoLinedButton()
        button.configure(with: ImageTwoLinedButtonViewModel(primaryText: "3 Месяца", secondaryText: "3890 /3 months", image: UIImage(systemName: "circle") ?? UIImage()), borderColor: UIColor.white.cgColor, imageColor: .white)
        button.addTarget(self, action: #selector(threeMonthPlanButtonPressed), for: .touchUpInside)
        return button
    }()

    let oneMonthtimePlanButton: ImageTwoLinedButton = {
        let button = ImageTwoLinedButton()
        button.configure(with: ImageTwoLinedButtonViewModel(primaryText: "1 Месяц", secondaryText: "2350 /month", image: UIImage(systemName: "circle") ?? UIImage()), borderColor: UIColor.white.cgColor, imageColor: .white)
        button.addTarget(self, action: #selector(oneMonthtimePlanButtonPressed), for: .touchUpInside)
        return button
    }()
    
    var reviewsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collView
    }()
    
    let continueButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        button.setTitle("Продолжить", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        return button
    }()
    
    let textOrLabel: UILabel = {
        let label = UILabel()
        label.text = "или"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    let continueLimitedEditionButton: UIButton = {
        let button = UIButton()

        let text = NSMutableAttributedString(string: "Продолжить с ограниченной версией")

        let attrs = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.patternDash.rawValue | NSUnderlineStyle.single.rawValue,
                     NSAttributedString.Key.underlineColor: UIColor.orange,
                     NSAttributedString.Key.foregroundColor: UIColor.white] as [NSAttributedString.Key : Any]

        text.addAttributes(attrs, range: NSRange(location: 0, length: text.length))
        button.setAttributedTitle(text, for: .normal)
        return button
    }()
    
    let termsTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.backgroundColor = .clear
        return textView
    }()
    
    let containerView = UIView()
    var pageViews = [UIView]()
    
    var accessButtons: [ImageTwoLinedButton] = []
    var selectedPlan: Plans?
    
    var reviewCollectionViewCells: [ReviewCollectionViewCell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupReviewCollectionView()
        
        addSubviews()
        makeConstraints()
        
        accessButtons = [lifetimePlanButton, threeMonthPlanButton, oneMonthtimePlanButton]
        
        setupTermsLabel()
    }
    
    @objc func restoreButtonPressed() {
        print("pressed")
    }
    
    @objc func lifetimePlanButtonPressed() {
        checkingWhichPlan(plan: .lifetime, button: lifetimePlanButton)
    }
    @objc func threeMonthPlanButtonPressed() {
        checkingWhichPlan(plan: .threeMonth, button: threeMonthPlanButton)
    }
    @objc func oneMonthtimePlanButtonPressed() {
        checkingWhichPlan(plan: .oneMonth, button: oneMonthtimePlanButton)
    }
    
    func checkingWhichPlan(plan: Plans, button: ImageTwoLinedButton) {
        for button in accessButtons {
            button.setUnselected()
            button.removePopularLabelFromSuperview()
        }
        if selectedPlan == plan {
            button.setUnselected()
            selectedPlan = .none
        } else {
            button.setSelected()
            button.setupPopularLabel(stackView: buttonsStackView, onButton: button)
            selectedPlan = plan
        }
    }
    
    enum Plans {
        case lifetime
        case threeMonth
        case oneMonth
    }
    
    func setupReviewCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        reviewsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        reviewsCollectionView.contentInset = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
        reviewsCollectionView.backgroundColor = .clear
        
        reviewsCollectionView.showsHorizontalScrollIndicator = false
        reviewsCollectionView.delegate = self
        reviewsCollectionView.dataSource = self
        reviewsCollectionView.register(ReviewCollectionViewCell.self, forCellWithReuseIdentifier: ReviewCollectionViewCell.reuseIdentifier)
        
        let cell1 = ReviewCollectionViewCell()
        let cell2 = ReviewCollectionViewCell()
        let cell3 = ReviewCollectionViewCell()
        let cell4 = ReviewCollectionViewCell()
        reviewCollectionViewCells = [cell1, cell2, cell3, cell4]
    }
    
    func setupTermsLabel() {
        let termsOfUse = "Условия Использования"
        let policyPD = ", Политику Конфиденциальноси"
        let offer = ", Условия Подписки"
        let message = "Продолжая, вы принимаете: "
        
        let fullMessage = message + termsOfUse + policyPD + offer
        let attributedString = NSMutableAttributedString(string: fullMessage)
        
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: NSRange(location: 0, length: fullMessage.count))
        attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: fullMessage.count))
        attributedString.addAttribute(.link, value: 0, range: NSRange(location: message.count, length: termsOfUse.count))
        attributedString.addAttribute(.link, value: 0, range: NSRange(location: (message + termsOfUse).count + 1, length: policyPD.count))
        attributedString.addAttribute(.link, value: 0, range: NSRange(location: (message + termsOfUse + policyPD).count + 1, length: (offer.count)-1))
        
        termsTextView.linkTextAttributes = [.foregroundColor: UIColor.orange]
        termsTextView.attributedText = attributedString
        termsTextView.textAlignment = .center
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        reviewCollectionViewCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCollectionViewCell.reuseIdentifier, for: indexPath) as! ReviewCollectionViewCell
        cell.configure(reviewName: "Мурррфект!", date: "13 Фев", rating: 3.5, userName: "Анастасия", description: "Я могу записывать не только входящие, но и исходящие звонки.")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 80, height: 150)
    }
}

private extension ViewController {
    
    func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(restoreButton)
        view.addSubview(unlimitedAccessLabel)
        view.addSubview(buttonsStackView)
        
        buttonsStackView.addArrangedSubview(lifetimePlanButton)
        buttonsStackView.addArrangedSubview(threeMonthPlanButton)
        buttonsStackView.addArrangedSubview(oneMonthtimePlanButton)
        
        view.addSubview(reviewsCollectionView)
        view.addSubview(continueButton)
        view.addSubview(textOrLabel)
        view.addSubview(continueLimitedEditionButton)
        view.addSubview(termsTextView)
    }
    
    func makeConstraints() {
        
        backgroundImageView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
        
        restoreButton.snp.makeConstraints { make in
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).inset(20)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(20)
            make.width.equalTo(150)
            make.height.equalTo(20)
        }
        
        unlimitedAccessLabel.snp.makeConstraints { make in
            make.top.equalTo(restoreButton.snp.bottom).inset(-20)
            make.leading.trailing.equalToSuperview()
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.height.equalTo(240)
            make.top.equalTo(unlimitedAccessLabel.snp.bottom).inset(-25)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        
        reviewsCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(buttonsStackView.snp.bottom).inset(-30)
            make.height.equalTo(150)
        }
        
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(reviewsCollectionView.snp.bottom).inset(-30)
            make.trailing.leading.equalToSuperview().inset(40)
            make.height.equalTo(70)
        }
        
        textOrLabel.snp.makeConstraints { make in
            make.top.equalTo(continueButton.snp.bottom).inset(-10)
            make.leading.trailing.equalToSuperview()
        }
        
        continueLimitedEditionButton.snp.makeConstraints { make in
            make.top.equalTo(textOrLabel.snp.bottom).inset(-10)
            make.leading.trailing.equalToSuperview()
        }
        
        termsTextView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(100)
        }
    }
}

