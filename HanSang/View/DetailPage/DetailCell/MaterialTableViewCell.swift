//
//  MaterialTableViewCell.swift
//  HanSang
//
//  Created by 박성원 on 2023/09/27.
//

import UIKit

final class MaterialTableViewCell: UITableViewCell {
    
    // MARK: - properties

    lazy var materialLabel: UILabel = {
        let label = UILabel()
        label.labelMakeUI(textColor: UIColor.black, font: .systemFont(ofSize: 16))
        return label
    }()
    
    lazy var unitLabel: UILabel = {
        let label = UILabel()
        label.labelMakeUI(textColor: UIColor.black, font: .systemFont(ofSize: 16))
        label.textAlignment = .right
        return label
    }()
    
    private lazy var cellStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [materialLabel,unitLabel])
        stack.spacing = 20
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        cellMakeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        materialLabel.text = nil
        unitLabel.text = nil
    }
}


// MARK: - cellMakeUI

private extension MaterialTableViewCell {
    
    func cellMakeUI() {
        self.contentView.addSubview(cellStackView)
        
        NSLayoutConstraint.activate([
            cellStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            cellStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            cellStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 4),
            cellStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -4),
        ])
        
    }

}
