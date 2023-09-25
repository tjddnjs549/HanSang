//
//  네비게이션 컨트롤러 넣기.swift
//  HanSang
//
//  Created by 박성원 on 2023/09/25.
//

import UIKit

final class DetailViewController: UIViewController {

    private let detailView = DetailView()
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    
}
