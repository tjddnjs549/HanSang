//
//  MainViewController.swift
//  HanSang
//
//  Created by 박성원 on 2023/09/25.
//

import UIKit

class MainViewController: UIViewController {

    
    // MARK: - varibles
    private var images: [UIImage] = []
    
    private let mainLabel: UILabel = {
        let mainLabel = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "오늘의\n", attributes: [
            .font: FontGuide.size32,
            .foregroundColor: UIColor.black
        ])
        attributedText.append(NSAttributedString(string: "추천 레시피", attributes: [
            .font: FontGuide.size32Bold,
            .foregroundColor: UIColor.black
        ]))
        mainLabel.attributedText = attributedText
        mainLabel.textAlignment = .left
        mainLabel.numberOfLines = 0
        
        return mainLabel
    }()
   
    private let categoryLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.text = "어떤 메뉴"
        categoryLabel.font = FontGuide.size19Bold
        categoryLabel.textAlignment = .left
        return categoryLabel
    }()
    
            
    private let categoryLabel2: UILabel = {
        let categoryLabel2 = UILabel()
        categoryLabel2.text = "를 만들어 볼까요?"
        categoryLabel2.textAlignment = .left
        categoryLabel2.font = FontGuide.size19
        categoryLabel2.textColor = ColorGuide.black
        return categoryLabel2
    }()
    
            
    
    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "HANSANG")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let searchButton: UIButton = {
        let searchButton = UIButton()
        searchButton.tintColor = .black
        let searchImage = UIImage(systemName: "magnifyingglass")
        searchButton.setImage(searchImage, for: .normal)
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)

        return searchButton
    }()

    // MARK: - UI Components
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MainPageCollectionViewCell.self, forCellWithReuseIdentifier: MainPageCollectionViewCell.identifier)
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        createStackview()
        createStackview2()
        self.navigationController?.isNavigationBarHidden = true
        
        for _ in 0...25 {
            images.append(UIImage(named: "1")!)
            images.append(UIImage(named: "2")!)
            images.append(UIImage(named: "3")!)
            images.append(UIImage(named: "4")!)
            images.append(UIImage(named: "5")!)
            images.append(UIImage(named: "6")!)
            images.append(UIImage(named: "7")!)
        }
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainLabel)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(categoryLabel2)
        categoryLabel2.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(logoImage)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 195),
            collectionView.heightAnchor.constraint(equalToConstant: 300),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -15),
            
            mainLabel.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 110),
            mainLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 19),
            
            categoryLabel.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 528),
            categoryLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 28),
            
            categoryLabel2.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 529),
            categoryLabel2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 100),

            logoImage.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 70),
            logoImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 19),
            logoImage.widthAnchor.constraint(equalToConstant: 105.37),
            logoImage.heightAnchor.constraint(equalToConstant: 12.54),
            
            searchButton.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 65),
            searchButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -19),
        ])
    }
    
    func createStackview() {
        
        let bobButton: UIButton = {
            let bobButton = UIButton()
            bobButton.backgroundColor = .white
            bobButton.setTitle(" 🍚 \n  밥", for: .normal)
            bobButton.setTitleColor(.black, for: .normal)
            bobButton.titleLabel?.numberOfLines = 0
            
            let iconText = NSMutableAttributedString(string: "🍚", attributes: [
                .font: UIFont.systemFont(ofSize: 40)
            ])
            let buttonText = NSMutableAttributedString(string: "\n    밥", attributes: [
                .font: UIFont.systemFont(ofSize: 15)
            ])
            
            let combinedText = NSMutableAttributedString()
            combinedText.append(iconText)
            combinedText.append(buttonText)
            
            bobButton.setAttributedTitle(combinedText, for: .normal)
            bobButton.layer.cornerRadius = 20
            bobButton.layer.shadowColor = UIColor.black.cgColor
            bobButton.layer.shadowOffset = CGSize(width: 0, height: 2.5)
            bobButton.layer.shadowOpacity = 0.5
            bobButton.layer.shadowRadius = 4
            bobButton.translatesAutoresizingMaskIntoConstraints = false
            bobButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
            bobButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
            return bobButton
        }()
        
        let soupButton: UIButton = {
            let soupButton = UIButton()
            soupButton.backgroundColor = .white
            soupButton.setTitle(" 🥘 \n  찌개", for: .normal)
            soupButton.setTitleColor(.black, for: .normal)
            soupButton.titleLabel?.numberOfLines = 0

            let iconText = NSMutableAttributedString(string: "🥘", attributes: [
                .font: UIFont.systemFont(ofSize: 40)
            ])
            let buttonText = NSMutableAttributedString(string: "\n   찌개", attributes: [
                .font: UIFont.systemFont(ofSize: 14)
            ])
            
            let combinedText = NSMutableAttributedString()
            combinedText.append(iconText)
            combinedText.append(buttonText)

            soupButton.setAttributedTitle(combinedText, for: .normal)
            soupButton.layer.cornerRadius = 20
            soupButton.layer.shadowColor = UIColor.black.cgColor
            soupButton.layer.shadowOffset = CGSize(width: 0, height: 2.5)
            soupButton.layer.shadowOpacity = 0.5
            soupButton.layer.shadowRadius = 4
            soupButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
            soupButton.heightAnchor.constraint(equalToConstant: 80).isActive = true

            return soupButton
        }()

        
        let noodleButton: UIButton = {
            let noodleButton = UIButton()
            noodleButton.backgroundColor = .white
            noodleButton.setTitle(" 🍝 \n  면", for: .normal)
            noodleButton.setTitleColor(.black, for: .normal)
            noodleButton.titleLabel?.numberOfLines = 0

            let iconText = NSMutableAttributedString(string: "🍝", attributes: [
                .font: UIFont.systemFont(ofSize: 45)
            ])
            let buttonText = NSMutableAttributedString(string: "\n     면", attributes: [
                .font: UIFont.systemFont(ofSize: 15)
            ])
            
            let combinedText = NSMutableAttributedString()
            combinedText.append(iconText)
            combinedText.append(buttonText)
            
            noodleButton.setAttributedTitle(combinedText, for: .normal)
            noodleButton.layer.cornerRadius = 20
            noodleButton.layer.shadowColor = UIColor.black.cgColor
            noodleButton.layer.shadowOffset = CGSize(width: 0, height: 2.5)
            noodleButton.layer.shadowOpacity = 0.5
            noodleButton.layer.shadowRadius = 4
            noodleButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
            noodleButton.heightAnchor.constraint(equalToConstant: 80).isActive = true

            return noodleButton
        }()
        
        let breadButton: UIButton = {
            let breadButton = UIButton()
            breadButton.backgroundColor = .white
            breadButton.setTitle(" 🍞 \n  빵", for: .normal)
            breadButton.setTitleColor(.black, for: .normal)
            breadButton.titleLabel?.numberOfLines = 0

            let iconText = NSMutableAttributedString(string: "🍩", attributes: [
                .font: UIFont.systemFont(ofSize: 40)
            ])
            let buttonText = NSMutableAttributedString(string: "\n 베이킹", attributes: [
                .font: UIFont.systemFont(ofSize: 14)
            ])
            
            let combinedText = NSMutableAttributedString()
            combinedText.append(iconText)
            combinedText.append(buttonText)
            
            breadButton.setAttributedTitle(combinedText, for: .normal)
            breadButton.layer.cornerRadius = 20
            breadButton.layer.shadowColor = UIColor.black.cgColor
            breadButton.layer.shadowOffset = CGSize(width: 0, height: 2.5)
            breadButton.layer.shadowOpacity = 0.5
            breadButton.layer.shadowRadius = 4
            breadButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
            breadButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
            return breadButton
        }()

        let stackView = UIStackView(arrangedSubviews: [bobButton,soupButton, noodleButton, breadButton])
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .white
        stackView.axis = .horizontal
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -205).isActive = true
        stackView.distribution = .equalSpacing
    }
    
    func createStackview2() {
        
        let alcoholButton: UIButton = {
            let alcoholButton = UIButton()
            alcoholButton.backgroundColor = .white
            alcoholButton.setTitle(" 🍷 \n  술", for: .normal)
            alcoholButton.setTitleColor(.black, for: .normal)
            alcoholButton.titleLabel?.numberOfLines = 0

            let iconText = NSMutableAttributedString(string: "🍷", attributes: [
                .font: UIFont.systemFont(ofSize: 40)
            ])
            let buttonText = NSMutableAttributedString(string: "\n    술", attributes: [
                .font: UIFont.systemFont(ofSize: 15)
            ])
            
            let combinedText = NSMutableAttributedString()
            combinedText.append(iconText)
            combinedText.append(buttonText)
            
            alcoholButton.setAttributedTitle(combinedText, for: .normal)
            alcoholButton.layer.cornerRadius = 20
            alcoholButton.layer.shadowColor = UIColor.black.cgColor
            alcoholButton.layer.shadowOffset = CGSize(width: 0, height: 2.5)
            alcoholButton.layer.shadowOpacity = 0.5
            alcoholButton.layer.shadowRadius = 4
            alcoholButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
            alcoholButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
            return alcoholButton
        }()
        
        let pizzaButton: UIButton = {
            let pizzaButton = UIButton()
            pizzaButton.backgroundColor = .white
            pizzaButton.setTitle(" 🍕 \n  분식", for: .normal)
            pizzaButton.setTitleColor(.black, for: .normal)
            pizzaButton.titleLabel?.numberOfLines = 0

            let iconText = NSMutableAttributedString(string: "🍕", attributes: [
                .font: UIFont.systemFont(ofSize: 40)
            ])
            let buttonText = NSMutableAttributedString(string: "\n   분식", attributes: [
                .font: UIFont.systemFont(ofSize: 15)
            ])
            
            let combinedText = NSMutableAttributedString()
            combinedText.append(iconText)
            combinedText.append(buttonText)
            
            pizzaButton.setAttributedTitle(combinedText, for: .normal)
            pizzaButton.layer.cornerRadius = 20
            pizzaButton.layer.shadowColor = UIColor.black.cgColor
            pizzaButton.layer.shadowOffset = CGSize(width: 0, height: 2.5)
            pizzaButton.layer.shadowOpacity = 0.5
            pizzaButton.layer.shadowRadius = 4
            pizzaButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
            pizzaButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
            return pizzaButton
        }()
        
        let steameddishButton: UIButton = {
            let steameddishButton = UIButton()
            steameddishButton.backgroundColor = .white
            steameddishButton.setTitle(" 🍲 \n  찜", for: .normal)
            steameddishButton.setTitleColor(.black, for: .normal)
            steameddishButton.titleLabel?.numberOfLines = 0

            let iconText = NSMutableAttributedString(string: "🍲", attributes: [
                .font: UIFont.systemFont(ofSize: 40)
            ])
            let buttonText = NSMutableAttributedString(string: "\n    찜", attributes: [
                .font: UIFont.systemFont(ofSize: 15)
            ])
            
            let combinedText = NSMutableAttributedString()
            combinedText.append(iconText)
            combinedText.append(buttonText)
            
            steameddishButton.setAttributedTitle(combinedText, for: .normal)
            steameddishButton.layer.cornerRadius = 20
            steameddishButton.layer.shadowColor = UIColor.black.cgColor
            steameddishButton.layer.shadowOffset = CGSize(width: 0, height: 2.5)
            steameddishButton.layer.shadowOpacity = 0.5
            steameddishButton.layer.shadowRadius = 4
            steameddishButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
            steameddishButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
            return steameddishButton
        }()


        
        let othersButton: UIButton = {
            let othersButton = UIButton()
            othersButton.backgroundColor = .white
            othersButton.setTitle(" 🍴 \n기타", for: .normal)
            othersButton.setTitleColor(.black, for: .normal)
            othersButton.titleLabel?.numberOfLines = 0

            let iconText = NSMutableAttributedString(string: "🍴", attributes: [
                .font: UIFont.systemFont(ofSize: 40)
            ])
            let buttonText = NSMutableAttributedString(string: "\n   기타", attributes: [
                .font: UIFont.systemFont(ofSize: 14)
            ])
            
            let combinedText = NSMutableAttributedString()
            combinedText.append(iconText)
            combinedText.append(buttonText)
            
            othersButton.setAttributedTitle(combinedText, for: .normal)
            othersButton.layer.cornerRadius = 20
            othersButton.layer.shadowColor = UIColor.black.cgColor
            othersButton.layer.shadowOffset = CGSize(width: 0, height: 2.5)
            othersButton.layer.shadowOpacity = 0.5
            othersButton.layer.shadowRadius = 4
            othersButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
            othersButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
            return othersButton
        }()
        
        let stackView2 = UIStackView(arrangedSubviews: [alcoholButton, pizzaButton, steameddishButton, othersButton])
        view.addSubview(stackView2)
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        stackView2.backgroundColor = .white
        stackView2.axis = .horizontal
        stackView2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        stackView2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        stackView2.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -110).isActive = true
        stackView2.distribution = .equalSpacing
    }
    
    @objc func searchButtonTapped() {
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPageCollectionViewCell.identifier, for: indexPath) as?
                MainPageCollectionViewCell else {
            fatalError("Failed to dequeue MainPageCollectionViewCell in MainViewController")
        }
        
        let image = self.images[indexPath.row]
        cell.configure(with: image)
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = ColorGuide.inputLine.cgColor
        cell.layer.cornerRadius = 12
        cell.layer.masksToBounds = true
        cell.layer.shadowColor = ColorGuide.textHint.cgColor
        cell.layer.shadowOpacity = 1
        cell.layer.shadowOffset = CGSize(width: 2, height: 2)
        cell.layer.shadowRadius = 12

        return cell
    }
}

extension  MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(self.view.frame.width)
        let size = (self.view.frame.width)
        return CGSize(width: 270, height: 290)
    }
    
    // Vertical Specing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        15
    }
    
//    // Horizontal Specing
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        8
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: 200, height: 77)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        return CGSize(width: 200, height: 200)
//    }
}
