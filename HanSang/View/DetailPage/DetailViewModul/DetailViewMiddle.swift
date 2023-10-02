//
//  DetailViewMiddle.swift
//  HanSang
//
//  Created by 박성원 on 2023/10/01.
//

import UIKit

final class DetailViewMiddle: UIView {

    lazy var detailVC = DetailViewController()
    
    // MARK: - properties
    private let materialLabel: UILabel = {
        let label = UILabel()
        label.labelMakeUI(textColor: UIColor.black, font: .boldSystemFont(ofSize: 20))
        label.text = "레시피 재료"
        return label
    }()
    
    lazy var materialTableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = true
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let recipeLabel: UILabel = {
        let label = UILabel()
        label.labelMakeUI(textColor: UIColor.black, font: .boldSystemFont(ofSize: 20))
        label.text = "조리 방법"
        return label
    }()
    
    private lazy var kickView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        view.clipsToBounds = true
        view.layer.cornerRadius = 10.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var kickLabel: UILabel = {
        let label = UILabel()
        label.labelMakeUI(textColor: UIColor.black, font: .boldSystemFont(ofSize: 18))
        label.text = "레시피 Kick!"
        return label
    }()
    
    lazy var makeKickLabel: UILabel = {
        let label = UILabel()
        label.labelMakeUI(textColor: UIColor.black, font: .systemFont(ofSize: 16))
        label.text = """
                    이 레시피의 킥은 이것입니다!
                    이것을 조리할 때 빼먹지말고 넣어주세요.
                    만약 없다면 oo 이것으로 대체해도 무방합니다!
                    """
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        materialMakeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DetailViewMiddle {
    
    func materialMakeUI() {
        let subView = [materialLabel, materialTableView, recipeLabel, kickView, kickLabel, makeKickLabel]
        for view in subView {
            self.addSubview(view)
        }
        NSLayoutConstraint.activate([
            materialLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            materialLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            materialLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            
            materialTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            materialTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            materialTableView.topAnchor.constraint(equalTo: self.materialLabel.bottomAnchor, constant: 20),
            //materialTableView.heightAnchor.constraint(equalToConstant: 200), //❗️❗️❗️❗️❗️
            
            recipeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            recipeLabel.topAnchor.constraint(equalTo: self.materialTableView.bottomAnchor, constant: 20),
            
            kickView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            kickView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            kickView.topAnchor.constraint(equalTo: self.recipeLabel.bottomAnchor, constant: 20),
            
            kickLabel.leadingAnchor.constraint(equalTo: self.kickView.leadingAnchor, constant: 20),
            kickLabel.topAnchor.constraint(equalTo: self.kickView.topAnchor, constant: 15),
            
            makeKickLabel.topAnchor.constraint(equalTo: self.kickLabel.bottomAnchor, constant: 10),
            makeKickLabel.leadingAnchor.constraint(equalTo: self.kickView.leadingAnchor, constant: 20),
            makeKickLabel.trailingAnchor.constraint(equalTo: self.kickView.trailingAnchor, constant: -20),
            makeKickLabel.bottomAnchor.constraint(equalTo: self.kickView.bottomAnchor, constant: -20)
        ])
    }
    
}
