//
//  MaterialView.swift
//  HanSang
//
//  Created by 배은서 on 2023/09/28.
//

import UIKit
import SnapKit

class MaterialView: UIView {
    
    // MARK: - Properties
    
    private var materialList: [Material] = []
    
    private let messageLabel: UILabel = {
        $0.text =
                """
                어떤 재료가
                필요한가요?
                """
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 25)
        $0.numberOfLines = 2
        return $0
    }(UILabel())
    
    private lazy var materialCreateTableView: UITableView = {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.dataSource = self
        $0.delegate = self
        
        let footerNib = UINib(nibName: MaterialFooterView.identifier, bundle: nil)
        $0.register(footerNib, forHeaderFooterViewReuseIdentifier: MaterialFooterView.identifier)
        $0.register(MaterialCreateTableViewCell.self, forCellReuseIdentifier: MaterialCreateTableViewCell.identifier)
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
        [messageLabel, materialCreateTableView].forEach {
            addSubview($0)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(15)
            $0.leading.equalToSuperview().inset(15)
        }
        
        materialCreateTableView.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Custom Method
    
}

//MARK: - UITableViewDataSource

extension MaterialView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if materialList.isEmpty {
            return 1
        } else {
            return materialList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MaterialCreateTableViewCell.identifier) as? MaterialCreateTableViewCell
        else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        
        cell.touchedDeleteButton = {
            self.materialList.remove(at: indexPath.row)
            self.materialCreateTableView.reloadData()
        }
        
        return cell
    }
}


//MARK: - UITableViewDelegate

extension MaterialView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: MaterialFooterView.identifier) as? MaterialFooterView
        else { return nil }

        footerView.touchedAddButton = {
            self.materialList.append(Material(material: "", unit: ""))
            self.materialCreateTableView.reloadData()
        }

        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
}



