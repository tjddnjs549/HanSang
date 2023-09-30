//
//  네비게이션 컨트롤러 넣기.swift
//  HanSang
//
//  Created by 박성원 on 2023/09/25.
//

import UIKit

final class DetailViewController: UIViewController {

    // MARK: - dummy
    
    var material: [String] = ["스테이크용 소고기", "아스파라거스", "새송이 버섯", "감자", "소스", "돼지고기", "와인", "양파", "양파", "양파"]
    var unit: [String] =  ["1개", "2개", "3개", "4개", "5개", "6개", "7개", "8개", "8개", "8개"]
    var imageArray: [UIImage] = [UIImage(named: "Meet")!,UIImage(named: "Meet")!,UIImage(named: "Meet")!,UIImage(named: "Meet")!]
    var imageDescriptionArray: [String] = ["스테이크용 고기를 키친타올을 사용해 물기를 닦아낸다.", "스테이크용 고기를 키친타올을 사용해 물기를 닦아낸다.", "스테이크용 고기를 키친타올을 사용해 물기를 닦아낸다.", "스테이크용 고기를 키친타올을 사용해 물기를 닦아낸다."]

    
    private let detailView = DetailView()
 
    var isLiked: Bool = false
    
    override func loadView() {
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allSetting()
        detailView.detailViewMiddle.materialTableView.reloadData()
        detailView.detailViewBottom.recipeTableView.reloadData()
        
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
            cell.selectionStyle = .none
            print(#function)
            return cell
        }
       return UITableViewCell()
    }
}


extension DetailViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if tableView == detailView.detailViewMiddle.materialTableView {
                return 30
            } else if tableView == detailView.detailViewBottom.recipeTableView {
                return 80
            }
            return 0
        }
}
