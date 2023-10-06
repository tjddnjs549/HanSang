//
//  네비게이션 컨트롤러 넣기.swift
//  HanSang
//
//  Created by 박성원 on 2023/09/25.
//

import UIKit
import AudioToolbox

final class DetailViewController: UIViewController {
    
    var content: Content? {
        didSet {
            if let imageData = content?.picture, let image = UIImage(data: imageData) {
                detailView.detailViewTop.foodImageView.image = image
            }
            detailView.detailViewTop.titleLabel.text = content?.title
            detailView.detailViewTop.makeTimeLabel.text = content?.time
            detailView.detailViewTop.makeDifficultyLabel.text = content?.difficulty
            if let imageData = content?.user?.profilePicture, let image = UIImage(data: imageData) {
                detailView.detailViewTop.profileImageView.image = image
            }
            detailView.detailViewTop.profileNameLabel.text = content?.user?.nickname
            detailView.detailViewTop.likeButton.isSelected = ((content?.bookmark) != nil)
        }
    }
    
    // MARK: - properties
    
    let dataManager = ContentDataManager.shared
    private let detailView = DetailView()
    
    var material: [Materials] = []
    var recipe: [Recipe] = []
    
    var index: Int?
    var isLiked: Bool = false
    var number = 0
    var timer: Timer?
    
    lazy var timeSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.labelMakeUI(textColor: ColorGuide.black, font: FontGuide.size16Bold)
        return label
    }()
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allSetting()
    }
}

// MARK: - tableView 세팅

private extension DetailViewController {
    
    func allSetting() {
        tableViewSetting()
        buttonTapped()
        naviBarSetting()
        dataSetting()
    }
    
    private func naviBarSetting() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .clear
        appearance.shadowColor = .none
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.tintColor = ColorGuide.main
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let deletedButton = UIBarButtonItem(image: UIImage(systemName: "trash")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(deletedButtonTapped))
        
        navigationItem.rightBarButtonItem = deletedButton
        
        let backButton = UIBarButtonItem(title: "닫기", style: .done, target: self, action: #selector(backButtonTapped))
        
        backButton.tintColor = ColorGuide.main
        navigationItem.leftBarButtonItem = backButton
        
    }
    func tableViewSetting() {
        detailView.detailViewMiddle.materialTableView.delegate = self
        detailView.detailViewMiddle.materialTableView.dataSource = self
        detailView.detailViewMiddle.materialTableView.register(MaterialTableViewCell.self, forCellReuseIdentifier: "MaterialTableViewCell")
        detailView.detailViewBottom.recipeTableView.delegate = self
        detailView.detailViewBottom.recipeTableView.dataSource = self
        detailView.detailViewBottom.recipeTableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: "RecipeTableViewCell")
        detailView.detailViewMiddle.materialTableView.rowHeight = UITableView.automaticDimension
        detailView.detailViewMiddle.materialTableView.estimatedRowHeight = 40
        detailView.detailViewBottom.recipeTableView.rowHeight = UITableView.automaticDimension
        detailView.detailViewBottom.recipeTableView.estimatedRowHeight = 100
    }
    func buttonTapped() {
        detailView.detailViewTop.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        detailView.detailViewBottom.recipeUdateButton.addTarget(self, action: #selector(contentUpdateButtonTapped), for: .touchUpInside)
    }
    func dataSetting() {
        guard let content = content else { return }
        recipe = dataManager.getRecipesForContent(content: content)
        material = dataManager.getMaterialsForContent(content: content)
        self.detailView.detailViewMiddle.materialTableView.reloadData()
        self.detailView.detailViewBottom.recipeTableView.reloadData()
    }
    
}
// MARK: - table UITableViewDelegate / UITableViewDataSource

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == detailView.detailViewMiddle.materialTableView {
            return material.count
        } else if tableView == detailView.detailViewBottom.recipeTableView {
            return recipe.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == detailView.detailViewMiddle.materialTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MaterialTableViewCell", for: indexPath) as! MaterialTableViewCell
            cell.materialLabel.text = material[indexPath.item].material
            cell.unitLabel.text = material[indexPath.item].unit
            cell.selectionStyle = .none
            return cell
        } else if tableView == detailView.detailViewBottom.recipeTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as! RecipeTableViewCell
            cell.cellMakeUI(index: indexPath.row)
            guard let imageData = recipe[indexPath.row].images, let image = UIImage(data: imageData) else {return UITableViewCell()}
                cell.recipeImageView.image = image
            
            cell.recipeLabel.text = recipe[indexPath.row].descriptions
            cell.timerLabel.text = convertToMinutes(getSeconds: recipe[indexPath.row].timer)
            
            if  recipe[indexPath.row].timer == "" {
                cell.timerStackView.isHidden = true
            }
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
}
extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == detailView.detailViewBottom.recipeTableView {
            self.index = indexPath.row
            if let value = recipe[indexPath.row].timer {
                showTimerAlert(timerValue: value)
            }
        }
    }
}
// MARK: - func
private extension DetailViewController {
    func convertToMinutes(getSeconds: String?) -> String {
        guard let secondsString = getSeconds, let getSeconds = Double(secondsString) else {
            return ""
        }
        
        let hours = Int(getSeconds / 3600)
        let minutes = Int(getSeconds / 60)
        let seconds = Int(getSeconds) % 60
        if hours > 0 {
            return "\(hours)시간 \(minutes)분"
        } else if minutes > 0 && seconds != 0 {
            return "\(minutes)분 \(seconds)초"
        } else if seconds == 0 {
            return "\(minutes)분"
        } else {
            return "\(seconds)초"
        }
    }
    func showTimerAlert(timerValue: String) {
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        alertController.view.addSubview(timeSlider)
        alertController.view.addSubview(timerLabel)
        
        NSLayoutConstraint.activate([
            timerLabel.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 10),
            timerLabel.centerXAnchor.constraint(equalTo: alertController.view.centerXAnchor),
            timeSlider.leadingAnchor.constraint(equalTo: alertController.view.leadingAnchor, constant: 10),
            timeSlider.trailingAnchor.constraint(equalTo: alertController.view.trailingAnchor, constant: -10),
            timeSlider.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 20)
        ])
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
            self.timer?.invalidate()
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        self.timer?.invalidate()
        if let timerSeconds = Double(timerValue) {
            self.number = Int(timerSeconds)
            self.timeSlider.maximumValue = Float(timerSeconds)
            UIView.animate(withDuration: TimeInterval(number)) {
                self.timeSlider.setValue(Float(self.number), animated: true)
            } completion: { _ in
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.doSomethingAfter1Second), userInfo: nil, repeats: true)
            }
        }
    }
}
// MARK: - @objc func
extension DetailViewController {
    
    @objc private func likeButtonTapped() {
        guard let content = self.content else {
            return
        }
        detailView.detailViewTop.likeButton.isSelected.toggle()
        isLiked = detailView.detailViewTop.likeButton.isSelected
        print(isLiked)
        ContentDataManager.shared.toggleBookmark(content: content)
    }
    @objc private func contentUpdateButtonTapped() {
        let createVC = CreateViewController()
        createVC.content = content
        navigationController?.pushViewController(createVC, animated: true)
    }
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc private func deletedButtonTapped() {
        guard let content = self.content else { return }
        dataManager.deleteToDo(data: content)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
        let seconds = Int(sender.value)
        DispatchQueue.main.async {
            self.timerLabel.text = "\(seconds) 초"
        }
        number = seconds
    }
  
    @objc private func doSomethingAfter1Second() {
        if number > 0 {
            number -= 1
            timeSlider.value = Float(number)
            timerLabel.text = "\(number) 초"
        } else {
            number = 0
            timer?.invalidate()
            AudioServicesPlaySystemSound(SystemSoundID(1000))
            self.dismiss(animated: true, completion: nil)
        }
    }
}
