//
//  SearchViewController.swift
//  HanSang
//
//  Created by clone1 on 2023/10/02.
//

import UIKit

class SearchViewController: UIViewController {
//, UISearchResultsUpdating {

    // MARK: - varibles
    private var images: [Content] = []
    
    // MARK: - UI Components
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MyPageCustomCell.self, forCellWithReuseIdentifier: MyPageCustomCell.identifier)
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.navigationController?.isNavigationBarHidden = false
        
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        
        let cancel = UIBarButtonItem(systemItem: .cancel, primaryAction: UIAction(handler: { _ in
        }))
        self.navigationItem.rightBarButtonItem = cancel
        self.navigationItem.hidesSearchBarWhenScrolling = false
        let searchbar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 10, height: 50))
        searchbar.sizeToFit()
        searchbar.placeholder = "Search User"
        // Create a custom back button item
        let chevronLeft = UIImage(systemName: "chevron.left")
        let customBackButton = UIBarButtonItem(image: chevronLeft, style: .plain, target: self, action: #selector(backButtonTapped))
        customBackButton.tintColor = ColorGuide.textHint
        cancel.tintColor = ColorGuide.textHint

        // Set the custom back button as the left navigation bar button item
        self.navigationItem.leftBarButtonItem = customBackButton


        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
        
    private func setupUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 120),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 300),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 28),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -28),

    ])
        
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageCustomCell.identifier, for: indexPath) as?
                MyPageCustomCell else {
            fatalError("Failed to dequeue CostomCollectionViewCell in MainViewController")
        }
        
        let image = images[indexPath.row]
        cell.configure(image)
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = ColorGuide.inputLine.cgColor
        cell.layer.cornerRadius = 12
        cell.layer.masksToBounds = true

        return cell
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (view.bounds.size.width - 76) / 2
        return CGSize(width: size, height: 182)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 200, height: 0)
    }
}
