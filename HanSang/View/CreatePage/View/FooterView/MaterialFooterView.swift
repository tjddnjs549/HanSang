//
//  MaterialHeaderView.swift
//  HanSang
//
//  Created by 배은서 on 2023/09/28.
//

import UIKit

class MaterialFooterView: UITableViewHeaderFooterView {
    
    static let identifier = "MaterialFooterView"
    
    var touchedAddButton: (() -> ())?
    
    @IBOutlet weak var addButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func touchUpAddButton(_ sender: Any) {
        touchedAddButton?()
    }
    
}
