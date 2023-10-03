//
//  네비게이션 컨트롤러 넣기.swift
//  HanSang
//
//  Created by 박성원 on 2023/09/25.
//

import UIKit
import AudioToolbox

final class DetailViewController: UIViewController {

    // MARK: - dummy
    
    var material: [String] = ["스테이크용 소고기", "아스파라거스", "새송이 버섯", "감자", "소스", "돼지고기", "돼지고기", "돼지고기"]
    var unit: [String] =  ["1개", "2개", "3개", "4개", "5개", "6개", "7개", "8개", "8개", "8개"]
    var imageArray: [UIImage] = [UIImage(named: "Meet")!,UIImage(named: "Meet")!,UIImage(named: "Meet")!,UIImage(named: "Meet")!,UIImage(named: "Meet")!,UIImage(named: "Meet")!,UIImage(named: "Meet")!,UIImage(named: "Meet")!]
    var imageDescriptionArray: [String] = ["스테이크용 고기를 키친타올을 사용해 물기를 닦아낸다. 스테이크용 고기를 키친타올을 사용해 물기를 닦아낸다. 스테이크용 고기를 키친타올을 사용해 물기를 닦아낸다. 스테이크용 고기를 키친타올을 사용해 물기를 닦아낸다.", "스테이크용 고기를 키친타올을 사용해 물기를 닦아낸다.", "스테이크용 고기를 키친타올을 사용해 물기를 닦아낸다.", "스테이크용 고기를 키친타올을 사용해 물기를 닦아낸다.", "스테이크용 고기를 키친타올을 사용해 물기를 닦아낸다.", "스테이크용 고기를 키친타올을 사용해 물기를 닦아낸다.", "스테이크용 고기를 키친타올을 사용해 물기를 닦아낸다.", "스테이크용 고기를 키친타올을 사용해 물기를 닦아낸다."] //50자 이내
    
    lazy var timeSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 60
        slider.value = 60
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private let detailView = DetailView()
    
    var isLiked: Bool = false
    var number = 0
    var timer: Timer?
    var time: String = "60초"
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allSetting()

        self.detailView.detailViewMiddle.materialTableView.reloadData()
        self.detailView.detailViewBottom.recipeTableView.reloadData()
    }
}

// MARK: - tableView 세팅

private extension DetailViewController {
    
    func allSetting() {
        tableViewSetting()
        buttonTapped()
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
}


// MARK: - @objc func

extension DetailViewController {
    
    @objc func likeButtonTapped() {
        detailView.detailViewTop.likeButton.isSelected.toggle()
        isLiked = detailView.detailViewTop.likeButton.isSelected
        print(isLiked)
    }
    @objc func contentUpdateButtonTapped() {
        let createVC = CreateViewController()
        navigationController?.pushViewController(createVC, animated: true)
    }
    
    @objc func timerButtonTapped() {
        let alertController = UIAlertController(title: "타이머", message: "\(time)로 설정", preferredStyle: .alert)
        
        alertController.view.addSubview(timeSlider)
        NSLayoutConstraint.activate([
            timeSlider.leadingAnchor.constraint(equalTo: alertController.view.leadingAnchor, constant: 16),
            timeSlider.trailingAnchor.constraint(equalTo: alertController.view.trailingAnchor, constant: -16),
            timeSlider.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 60)
        ])
        
        let startAction = UIAlertAction(title: "시작", style: .default) { _ in
            self.timer?.invalidate() // 현재 타이머 중지
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.doSomethingAfter1Second), userInfo: nil, repeats: true) // 타이머 재시작
        }
        alertController.addAction(startAction)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
            self.timer?.invalidate() // 타이머 중지
        }
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

    @objc func doSomethingAfter1Second() {
        if number > 0 {
            number -= 1
            print(Float(number) / Float(60))
            timeSlider.value = Float(number) / Float(60)
        } else {
            number = 0
            timer?.invalidate()
            AudioServicesPlaySystemSound(SystemSoundID(1000))
            self.dismiss(animated: true, completion: nil)
        }
    }
}
// MARK: - table UITableViewDelegate / UITableViewDataSource

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == detailView.detailViewMiddle.materialTableView {
            return material.count
        } else if tableView == detailView.detailViewBottom.recipeTableView {
            return imageArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == detailView.detailViewMiddle.materialTableView {
            print(#function)
            let cell = tableView.dequeueReusableCell(withIdentifier: "MaterialTableViewCell", for: indexPath) as! MaterialTableViewCell
            cell.materialLabel.text = material[indexPath.row]
            cell.unitLabel.text = unit[indexPath.row]
            cell.selectionStyle = .none
            return cell
        } else if tableView == detailView.detailViewBottom.recipeTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as! RecipeTableViewCell
            cell.cellMakeUI(index: indexPath.row)
            cell.recipeImageView.image = imageArray[indexPath.row]
            cell.recipeLabel.text = imageDescriptionArray[indexPath.row]
            cell.timerButton.addTarget(self, action: #selector(timerButtonTapped), for: .touchUpInside)
            cell.selectionStyle = .none
         
            print(#function)
            return cell
        }
       return UITableViewCell()
    }
}
extension DetailViewController: UITableViewDelegate {
}
