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
    
    private var isTimerOn: Bool = false

    private let countLabel: UILabel = {
        $0.font = .boldSystemFont(ofSize: 15)
        $0.textColor = .black
        return $0
    }(UILabel())

    private let recipleTextView: UITextView = {
        $0.font = .systemFont(ofSize: 10)
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
        $0.font = .systemFont(ofSize: 15)
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
        [countLabel, recipleTextView, timerStackView].forEach {
            addSubview($0)
        }
        
        countLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
        }
        
        recipleTextView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.equalTo(countLabel.snp.trailing).offset(15)
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
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .countDownTimer

        let alert = UIAlertController(title: "타이머 시간을 설정해주세요.", message: nil, preferredStyle: .actionSheet)
        alert.view.addSubview(datePicker)
        
        let okButton = UIAlertAction(title: "설정", style: .default) { _ in
            self.timeLabel.text = String(datePicker.countDownDuration)
        }
        let cancelButton = UIAlertAction(title: "취소", style: .default)
        
        [okButton, cancelButton].forEach {
            alert.addAction($0)
        }
        
        NotificationCenter.default.post(name: CreateRecipeTableViewCell.timerNotificationName, object: alert)
    }
    
    // MARK: - Custom Method
    
    func setCount(_ count: Int) {
        countLabel.text = "\(count)"
    }
}
