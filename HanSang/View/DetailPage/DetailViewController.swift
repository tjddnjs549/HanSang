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
    
    override func loadView() {
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetting()
        naviBarSetting()
        detailView.materialTableView.reloadData()
        detailView.recipeTableView.reloadData()
        
    }
}

// MARK: - tableView 세팅

private extension DetailViewController {
    
    func tableViewSetting() {
        detailView.materialTableView.delegate = self
        detailView.materialTableView.dataSource = self
        detailView.recipeTableView.delegate = self
        detailView.recipeTableView.dataSource = self
        detailView.materialTableView.register(MaterialTableViewCell.self, forCellReuseIdentifier: "MaterialTableViewCell")
        detailView.recipeTableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: "RecipeTableViewCell")
        
    }
    
    //네비게이션바 세팅
    private func naviBarSetting() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .clear
        appearance.shadowColor = .none
        navigationItem.hidesSearchBarWhenScrolling = false
        //navigationController?.navigationBar.tintColor = .red
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        //한글 버튼 넣을 시
        let updateButton = UIBarButtonItem(title: "수정", style: .done, target: self, action: #selector(updateButtonTapped))
        
        updateButton.tintColor = UIColor.black //색 조정
        navigationItem.rightBarButtonItem = updateButton //오른쪽에 넣음 (왼쪽일 시: navigationItem.leftBarButtonItem)
    }
    
    @objc func updateButtonTapped() {
        let createViewController = CreateViewController()
        navigationController?.pushViewController(createViewController, animated: true)
    }
}

// MARK: - table UITableViewDelegate / UITableViewDataSource


extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == detailView.materialTableView {
            return material.count
        } else if tableView == detailView.recipeTableView {
            return imageArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == detailView.materialTableView {
            print(#function)
            let cell = tableView.dequeueReusableCell(withIdentifier: "MaterialTableViewCell", for: indexPath) as! MaterialTableViewCell
            cell.materialLabel.text = material[indexPath.row]
            cell.unitLabel.text = unit[indexPath.row]
            cell.selectionStyle = .none
            return cell
        } else if tableView == detailView.recipeTableView {
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
            if tableView == detailView.materialTableView {
                return 30
            } else if tableView == detailView.recipeTableView {
                return 80
            }
            return 0
        }
}
