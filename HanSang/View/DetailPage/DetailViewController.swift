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
#if DEBUG && canImport(SwiftUI)
import SwiftUI
private struct UIViewControllerRepresenter: UIViewControllerRepresentable {
    let viewController: UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController {
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct UIViewControllerPreviewView: PreviewProvider {
    static var previews: some View {
        let viewController = DetailViewController()
        return UIViewControllerRepresenter(viewController: viewController)
    }
}
#endif
