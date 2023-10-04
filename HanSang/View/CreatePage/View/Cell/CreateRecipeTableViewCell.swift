//
//  CreateRecipeTableViewCell.swift
//  HanSang
//
//  Created by 배은서 on 2023/10/03.
//

import UIKit
import SnapKit

class CreateRecipeTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "CreateRecipeTableViewCell"
    static let timerNotificationName = Notification.Name("SetTimer")
    
    var timer: String?

    private let countLabel: UILabel = {
        $0.font = .boldSystemFont(ofSize: 15)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private let recipeImageView: UIImageView = {
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.layer.cornerRadius = 10
        return $0
    }(UIImageView())
    
    private let imageAddButton: UIButton = {
        var config = UIButton.Configuration.plain()
        var titleAttr = AttributedString.init("     사진을  \n 추가해주세요.")
        titleAttr.font = .systemFont(ofSize: 8, weight: .light)
        config.attributedTitle = titleAttr
        config.image = UIImage(systemName: "photo")
        config.imagePlacement = NSDirectionalRectEdge.top
        config.imagePadding = 5
        $0.configuration = config
        $0.titleLabel?.numberOfLines = 2
        $0.tintColor = .systemGray4
        return $0
    }(UIButton())

    private let recipleTextView: UITextView = {
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .black
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        return $0
    }(UITextView())
    
    private let timerButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.preferredSymbolConfigurationForImage = .init(font: UIFont.systemFont(ofSize: 20))
        config.image = UIImage(systemName: "timer")
        $0.configuration = config
        $0.tintColor = .systemGray4
        $0.addTarget(self, action: #selector(touchUpTimerButton), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private let timeLabel: UILabel = {
        $0.text = "off"
        $0.font = .systemFont(ofSize: 10)
        $0.textColor = .systemGray4
        return $0
    }(UILabel())
    
    private let timerStackView: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .center
        return $0
    }(UIStackView())
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
        setupLayout()
        registerLongPress()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        backgroundColor = .white
        
        [timerButton, timeLabel].forEach {
            timerStackView.addArrangedSubview($0)
        }
    }
    
    private func setupLayout() {
        [countLabel, recipeImageView, imageAddButton, recipleTextView, timerStackView].forEach {
            contentView.addSubview($0)
        }
        
        countLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
        }
        
        recipeImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.equalTo(countLabel.snp.trailing).offset(10)
            $0.width.height.equalTo(60)
        }
        
        imageAddButton.snp.makeConstraints {
            $0.center.equalTo(recipeImageView)
        }
        
        recipleTextView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.equalTo(recipeImageView.snp.trailing).offset(10)
        }
        
        timerStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.equalTo(recipleTextView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.width.equalTo(50)
        }
    }
    
    //MARK: - @objc
    
    @objc private func touchUpTimerButton() {
        let alertController = UIAlertController(title: "시간을 설정해주세요.", message: nil, preferredStyle: .actionSheet)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .countDownTimer
        
        let viewController = UIViewController()
        viewController.view = datePicker
        
        alertController.setValue(viewController, forKey: "contentViewController")
        
        let okAction = UIAlertAction(title: "설정", style: .default) { _ in
            self.timer = String(datePicker.countDownDuration)
            self.timeLabel.text = String(self.formatTimeIntervalToHHMMSS(datePicker.countDownDuration))
            self.timerButton.tintColor = .black
            self.timeLabel.textColor = .black
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        [okAction, cancelAction].forEach {
            alertController.addAction($0)
        }
        
        NotificationCenter.default.post(name: CreateRecipeTableViewCell.timerNotificationName, object: alertController)
    }
    
    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            self.timer = nil
            self.timeLabel.text = "off"
            self.timerButton.tintColor = .systemGray4
            self.timeLabel.textColor = .systemGray4
        default:
            return
        }
    }
    
    // MARK: - Custom Method
    
    private func registerLongPress() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressGesture.isEnabled = true
        longPressGesture.minimumPressDuration = 1
        timerButton.addGestureRecognizer(longPressGesture)
    }
    
    private func formatTimeIntervalToHHMMSS(_ timeInterval: TimeInterval) -> String {
        let hours = Int(timeInterval) / 3600
        let minutes = (Int(timeInterval) % 3600) / 60
        let seconds = Int(timeInterval) % 60

        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    func setCount(_ count: Int) {
        countLabel.text = "\(count)"
    }
}
