//
//  CreateRecipeTableViewCell.swift
//  HanSang
//
//  Created by 배은서 on 2023/10/03.
//

import UIKit
import SnapKit
import PhotosUI

class CreateRecipeTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "CreateRecipeTableViewCell"
    
    var timer: String?

    private let countLabel: UILabel = {
        $0.font = .boldSystemFont(ofSize: 15)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    lazy var recipeImageView: UIImageView = {
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.layer.cornerRadius = 10
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
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
        $0.addTarget(self, action:  #selector(touchUpAddButton), for: .touchUpInside)
        return $0
    }(UIButton())
    
    lazy var recipleTextView: UITextView = {
        $0.font = .systemFont(ofSize: 13)
        $0.text = "조리 방법을 자세하게 알려주세요."
        $0.textColor = .systemGray4
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        $0.delegate = self
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
    
    let timeLabel: UILabel = {
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
            $0.leading.equalTo(countLabel.snp.trailing).offset(15)
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
            $0.leading.equalTo(recipleTextView.snp.trailing).offset(5)
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
        
        NotificationCenter.default.post(name: NotificationName.timer, object: alertController)
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
    
    @objc func touchUpAddButton() {
        setupImagePicker()
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
    
    func isAllFilled() -> Bool {
        return recipeImageView.image != nil && recipleTextView.text != "조리 방법을 자세하게 알려주세요."
    }
    
    func getRecipe() -> RecipeModel {
        return RecipeModel(
            descriptions: recipleTextView.text ?? "",
            image: recipeImageView.image ?? UIImage(),
            timer: timer ?? "")
    }
}

//MARK: - UITextViewDelegate

extension CreateRecipeTableViewCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.textColor = .black
        
        if textView.text == "조리 방법을 자세하게 알려주세요." {
            textView.text = nil
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "조리 방법을 자세하게 알려주세요."
            textView.textColor = .systemGray4
        }
    }
}

//MARK: - PHPickerViewControllerDelegate
 
extension CreateRecipeTableViewCell: PHPickerViewControllerDelegate {
    func setupImagePicker() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 0
        configuration.filter = .any(of: [.images])
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        NotificationCenter.default.post(name: NotificationName.present, object: picker)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        guard !results.isEmpty else {
            NotificationCenter.default.post(name: NotificationName.dismiss, object: nil)
            return
        }
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async {
                    self.recipeImageView.image = image as? UIImage
                    self.contentView.sendSubviewToBack(self.imageAddButton)
                }
            }
            NotificationCenter.default.post(name: NotificationName.dismiss, object: nil)
        } else {
            print("ERROR❗️")
        }
    }
}
