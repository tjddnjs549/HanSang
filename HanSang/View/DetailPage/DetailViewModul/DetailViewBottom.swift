//
//  DetailViewBottom.swift
//  HanSang
//
//  Created by 박성원 on 2023/10/01.
//

import UIKit

class DetailViewBottom: UIView {

    // MARK: - properties

    lazy var recipeTableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    lazy var recipeUdateButton: UIButton = {
        let button = UIButton(type: .custom)
        button.buttonMakeUI(backgroundColor: UIColor.lightGray.withAlphaComponent(0.4), cornerRadius: 10.0, borderWidth: 0.0, borderColor: UIColor.clear.cgColor, setTitle: "레시피 수정하기", font: .boldSystemFont(ofSize: 20), setTitleColor: UIColor.black)
        return button
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        kickMakeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension DetailViewBottom {
    func kickMakeUI() {
        let subView = [recipeTableView, recipeUdateButton]
        for view in subView {
            addSubview(view)
        }

        NSLayoutConstraint.activate([
            recipeTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            recipeTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            recipeTableView.heightAnchor.constraint(equalToConstant: 300),//❗️❗️❗️❗️
            recipeTableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            recipeTableView.bottomAnchor.constraint(equalTo: self.recipeUdateButton.topAnchor, constant: -20),
            
            recipeUdateButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            recipeUdateButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            recipeUdateButton.topAnchor.constraint(equalTo: self.recipeTableView.bottomAnchor, constant: 30),
            recipeUdateButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
}
