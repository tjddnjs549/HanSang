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
        label.labelMakeUI(textColor: ColorGuide.black, font: FontGuide.size19Bold)
        label.text = "레시피 재료"
        return label
    }()
    
    lazy var materialTableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let recipeLabel: UILabel = {
        let label = UILabel()
        label.labelMakeUI(textColor: ColorGuide.black, font: FontGuide.size19Bold)
        label.text = "조리 방법"
        return label
    }()
    
    private lazy var kickView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorGuide.inputLine
        view.clipsToBounds = true
        view.layer.cornerRadius = 10.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var kickLabel: UILabel = {
        let label = UILabel()
        label.labelMakeUI(textColor: ColorGuide.black, font: FontGuide.size19Bold)
        label.text = "레시피 Kick!"
        return label
    }()
    
    lazy var makeKickLabel: UILabel = {
        let label = UILabel()
        label.labelMakeUI(textColor: ColorGuide.black, font: FontGuide.size16)
        label.text = """
                    이 레시피의 킥은 불조절입니다!
                    약불에서 살짝 계란을 익혀주세요!
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
            //materialTableView.heightAnchor.constraint(equalToConstant: 100), //❗️❗️❗️❗️❗️
            
            recipeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            recipeLabel.topAnchor.constraint(equalTo: self.materialTableView.bottomAnchor, constant: 20),
            
            kickView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            kickView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            kickView.topAnchor.constraint(equalTo: self.recipeLabel.bottomAnchor, constant: 20),
            kickView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
            kickLabel.leadingAnchor.constraint(equalTo: self.kickView.leadingAnchor, constant: 20),
            kickLabel.topAnchor.constraint(equalTo: self.kickView.topAnchor, constant: 15),
            
            makeKickLabel.topAnchor.constraint(equalTo: self.kickLabel.bottomAnchor, constant: 10),
            makeKickLabel.leadingAnchor.constraint(equalTo: self.kickView.leadingAnchor, constant: 20),
            makeKickLabel.trailingAnchor.constraint(equalTo: self.kickView.trailingAnchor, constant: -20),
            makeKickLabel.bottomAnchor.constraint(equalTo: self.kickView.bottomAnchor, constant: -20)
        ])
    }
    
}
