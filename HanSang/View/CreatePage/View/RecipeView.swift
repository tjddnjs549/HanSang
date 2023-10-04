//
//  RecipeView.swift
//  HanSang
//
//  Created by 배은서 on 2023/10/03.
//

import UIKit
import SnapKit

class RecipeView: UIView {

    // MARK: - Properties
    
    private let messageLabel: UILabel = {
        $0.text =
                """
                요리 순서를
                작성해주세요.
                """
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 25)
        $0.numberOfLines = 2
        return $0
    }(UILabel())
    
    private lazy var recipeTableView: UITableView = {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.dataSource = self
        $0.delegate = self
        
        let footerNib = UINib(nibName: MaterialFooterView.identifier, bundle: nil)
        $0.register(footerNib, forHeaderFooterViewReuseIdentifier: MaterialFooterView.identifier)
        $0.register(CreateRecipeTableViewCell.self, forCellReuseIdentifier: CreateRecipeTableViewCell.identifier)
        return $0
    }(UITableView())
    
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        backgroundColor = .white
    }
    
    private func setupLayout() {
        [messageLabel, recipeTableView].forEach {
            addSubview($0)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(15)
            $0.leading.equalToSuperview().inset(15)
        }
        
        recipeTableView.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Custom Method

}

//MARK: - UITableViewDataSource

extension RecipeView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CreateRecipeTableViewCell.identifier) as? CreateRecipeTableViewCell
        else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        
        cell.setCount(indexPath.row + 1)
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension RecipeView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: MaterialFooterView.identifier) as? MaterialFooterView
        else { return nil }

        footerView.touchedAddButton = {
            // 재료 추가
        }

        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
}
