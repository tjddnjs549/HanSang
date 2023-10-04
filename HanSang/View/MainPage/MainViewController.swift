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
//    let searchController = UISearchController()
    
    private let mainLabel: UILabel = {
        let mainLabel = UILabel()
        
        // "오늘의"와 "추천 레시피"를 모두 포함하는 NSAttributedString을 생성
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
        let fullText = "어떤 메뉴를 만들어 볼까요?"
        
        let attributedText = NSMutableAttributedString(string: fullText, attributes: [
            .font: FontGuide.size19,
            .foregroundColor: UIColor.black
        ])
        
        let menuRange = (fullText as NSString).range(of: "어떤메뉴")
        attributedText.addAttribute(.font, value: FontGuide.size19Bold, range: menuRange)
        
        categoryLabel.attributedText = attributedText
        categoryLabel.textAlignment = .left
        
        return categoryLabel
    }()




    
    
    
//    private let categoryLabel: UILabel = {
//        let categoryLabel = UILabel()
//        categoryLabel.text = "어떤 메뉴를 만들어 볼까요?"
//        categoryLabel.textAlignment = .left
//        categoryLabel.textColor = .black
//        categoryLabel.font = UIFont.systemFont(ofSize: 16)
//        return categoryLabel
//    }()
    
//    private let logoLabel: UILabel = {
//        let logoLabel = UILabel()
//        logoLabel.text = "Logo"
//        logoLabel.tintColor = .systemGreen
//        // 아이콘 이미지 설정 및 크기 조정
//        let logoImage = UIImage(systemName: "heart")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 21))
//        return logoLabel
//    }()
    
    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "HANSANG")
        imageView.contentMode = .scaleAspectFit
//        imageView.snp.makeConstraints { make in
//            make.width.equalTo(105.37)
//            make.height.equalTo(12.54)
//        }
        return imageView
    }()
    
    private let searchButton: UIButton = {
        let searchButton = UIButton()
        searchButton.tintColor = .black
        // 아이콘 이미지 설정 및 크기 조정
        let searchImage = UIImage(systemName: "magnifyingglass")
        searchButton.setImage(searchImage, for: .normal)
        // 버튼 탭 액션 설정
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)

        return searchButton
    }()
//


//    private let bobButton: UIButton = {
//        let bobButton = UIButton()
//        bobButton.backgroundColor = .white
//        bobButton.layer.cornerRadius = 10
//        bobButton.layer.shadowColor = UIColor.black.cgColor // 그림자의 색상 설정
//        bobButton.layer.shadowOffset = CGSize(width: 0, height: 2) // 그림자의 오프셋 설정 (X, Y)
//        bobButton.layer.shadowOpacity = 0.5 // 그림자의 투명도 설정 (0.0 ~ 1.0)
//        bobButton.layer.shadowRadius = 4 // 그림자의 블러 반경 설정
//        return bobButton
//    }()
//
//    private let noodleButton: UIButton = {
//        let noodleButton = UIButton()
//        noodleButton.backgroundColor = .white
//        noodleButton.layer.cornerRadius = 10
//        noodleButton.layer.shadowColor = UIColor.black.cgColor // 그림자의 색상 설정
//        noodleButton.layer.shadowOffset = CGSize(width: 0, height: 2) // 그림자의 오프셋 설정 (X, Y)
//        noodleButton.layer.shadowOpacity = 0.5 // 그림자의 투명도 설정 (0.0 ~ 1.0)
//        noodleButton.layer.shadowRadius = 4 // 그림자의 블러 반경 설정
//
//        return noodleButton
//    }()
//
//    private let breadButton: UIButton = {
//        let breadButton = UIButton()
//        breadButton.backgroundColor = .white
//        breadButton.layer.cornerRadius = 10
//        breadButton.layer.shadowColor = UIColor.black.cgColor // 그림자의 색상 설정
//        breadButton.layer.shadowOffset = CGSize(width: 0, height: 2) // 그림자의 오프셋 설정 (X, Y)
//        breadButton.layer.shadowOpacity = 0.5 // 그림자의 투명도 설정 (0.0 ~ 1.0)
//        breadButton.layer.shadowRadius = 4 // 그림자의 블러 반경 설정
//
//        return breadButton
//    }()
//
//    private let alcoholButton: UIButton = {
//        let alcoholButton = UIButton()
//        alcoholButton.backgroundColor = .white
//        alcoholButton.layer.cornerRadius = 10
//        alcoholButton.layer.shadowColor = UIColor.black.cgColor // 그림자의 색상 설정
//        alcoholButton.layer.shadowOffset = CGSize(width: 0, height: 2) // 그림자의 오프셋 설정 (X, Y)
//        alcoholButton.layer.shadowOpacity = 0.5 // 그림자의 투명도 설정 (0.0 ~ 1.0)
//        alcoholButton.layer.shadowRadius = 4 // 그림자의 블러 반경 설정
//
//        return alcoholButton
//    }()
//
//    private let othersButton: UIButton = {
//        let othersButton = UIButton()
//        othersButton.backgroundColor = .white
//        othersButton.layer.cornerRadius = 10
//        othersButton.layer.shadowColor = UIColor.black.cgColor // 그림자의 색상 설정
//        othersButton.layer.shadowOffset = CGSize(width: 0, height: 2) // 그림자의 오프셋 설정 (X, Y)
//        othersButton.layer.shadowOpacity = 0.5 // 그림자의 투명도 설정 (0.0 ~ 1.0)
//        othersButton.layer.shadowRadius = 4 // 그림자의 블러 반경 설정
//
//        return othersButton
//    }()
    

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
//        let button: UIButton = {
//            let button = UIButton()
//            button.setTitle("VC 이동", for: .normal)
//            button.tintColor = .systemGray3
//            button.backgroundColor = .white
//            return button
//        }()
        
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
        self.view.addSubview(logoImage)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(bobButton)
//        bobButton.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(noodleButton)
//        noodleButton.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(breadButton)
//        breadButton.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(alcoholButton)
//        alcoholButton.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(othersButton)
//        othersButton.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(backButton)
//        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 184),
//            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
//            collectionView.widthAnchor.constraint(equalToConstant: 348),
            collectionView.heightAnchor.constraint(equalToConstant: 300),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -15),
            
            mainLabel.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 100),
            mainLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 19),
            
            categoryLabel.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 495),
            categoryLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 19),
            
            logoImage.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 70),
            logoImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 19),
            logoImage.widthAnchor.constraint(equalToConstant: 105.37),
            logoImage.heightAnchor.constraint(equalToConstant: 12.54),
            
            
            searchButton.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 65),
            searchButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -19),
//
//            searchButton.heightAnchor.constraint(equalToConstant: 50),
//            searchButton.widthAnchor.constraint(equalToConstant: 50),
            
//            bobButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 530),
//            bobButton.widthAnchor.constraint(equalToConstant: 90),
//            bobButton.heightAnchor.constraint(equalToConstant: 100),
//            bobButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
//
//            noodleButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 530),
//            noodleButton.widthAnchor.constraint(equalToConstant: 90),
//            noodleButton.heightAnchor.constraint(equalToConstant: 100),
//            noodleButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 150),
//
//            breadButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 530),
//            breadButton.widthAnchor.constraint(equalToConstant: 90),
//            breadButton.heightAnchor.constraint(equalToConstant: 100),
//            breadButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 260),
//
//            alcoholButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 650),
//            alcoholButton.widthAnchor.constraint(equalToConstant: 90),
//            alcoholButton.heightAnchor.constraint(equalToConstant: 100),
//            alcoholButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 100),
//
//            othersButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 650),
//            othersButton.widthAnchor.constraint(equalToConstant: 90),
//            othersButton.heightAnchor.constraint(equalToConstant: 100),
//            othersButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 210),

        ])
    }
    
    func createStackview() {
        
        
        let bobButton: UIButton = {
            let bobButton = UIButton()
            bobButton.backgroundColor = .white
            bobButton.setTitle(" 🍚 \n  밥", for: .normal)
            bobButton.setTitleColor(.black, for: .normal)
            bobButton.titleLabel?.font = UIFont.systemFont(ofSize: 40)
            bobButton.titleLabel?.numberOfLines = 0

            let iconText = NSMutableAttributedString(string: "🍚", attributes: [
                .font: UIFont.systemFont(ofSize: 50) // 아이콘 크기 조절
            ])
            let buttonText = NSMutableAttributedString(string: "\n    밥", attributes: [
                .font: UIFont.systemFont(ofSize: 19) // 텍스트 크기 조절
            ])
            
            let combinedText = NSMutableAttributedString()
            combinedText.append(iconText)
            combinedText.append(buttonText)
            
            bobButton.setAttributedTitle(combinedText, for: .normal)

            bobButton.layer.cornerRadius = 10
            bobButton.layer.shadowColor = UIColor.black.cgColor // 그림자의 색상 설정
            bobButton.layer.shadowOffset = CGSize(width: 0, height: 2.5) // 그림자의 오프셋 설정 (X, Y)
            bobButton.layer.shadowOpacity = 0.5 // 그림자의 투명도 설정 (0.0 ~ 1.0)
            bobButton.layer.shadowRadius = 4 // 그림자의 블러 반경 설정
            bobButton.translatesAutoresizingMaskIntoConstraints = false
            //            bobButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 530)
            bobButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
            bobButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
//            bobButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 40)
            return bobButton
        }()
        
        let noodleButton: UIButton = {
            let noodleButton = UIButton()
            noodleButton.backgroundColor = .white
            noodleButton.setTitle(" 🍝 \n  면", for: .normal)
            noodleButton.setTitleColor(.black, for: .normal)
            noodleButton.titleLabel?.font = UIFont.systemFont(ofSize: 40)
            noodleButton.titleLabel?.numberOfLines = 0

            let iconText = NSMutableAttributedString(string: "🍝", attributes: [
                .font: UIFont.systemFont(ofSize: 50) // 아이콘 크기 조절
            ])
            let buttonText = NSMutableAttributedString(string: "\n    면", attributes: [
                .font: UIFont.systemFont(ofSize: 19) // 텍스트 크기 조절
            ])
            
            let combinedText = NSMutableAttributedString()
            combinedText.append(iconText)
            combinedText.append(buttonText)
            
            noodleButton.setAttributedTitle(combinedText, for: .normal)

            noodleButton.layer.cornerRadius = 10
            noodleButton.layer.shadowColor = UIColor.black.cgColor // 그림자의 색상 설정
            noodleButton.layer.shadowOffset = CGSize(width: 0, height: 2.5) // 그림자의 오프셋 설정 (X, Y)
            noodleButton.layer.shadowOpacity = 0.5 // 그림자의 투명도 설정 (0.0 ~ 1.0)
            noodleButton.layer.shadowRadius = 4 // 그림자의 블러 반경 설정
//                        noodleButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 530)
                        noodleButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
                        noodleButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
//                        noodleButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 150)

            return noodleButton
        }()
        
        let breadButton: UIButton = {
            let breadButton = UIButton()
            breadButton.backgroundColor = .white
            breadButton.setTitle(" 🍞 \n  빵", for: .normal)
            breadButton.setTitleColor(.black, for: .normal)
            breadButton.titleLabel?.font = UIFont.systemFont(ofSize: 40)
            breadButton.titleLabel?.numberOfLines = 0
//            breadButton.textAlignment = .center

            let iconText = NSMutableAttributedString(string: "🍞", attributes: [
                .font: UIFont.systemFont(ofSize: 50) // 아이콘 크기 조절
            ])
            let buttonText = NSMutableAttributedString(string: "\n    빵", attributes: [
                .font: UIFont.systemFont(ofSize: 19) // 텍스트 크기 조절
            ])
            
            let combinedText = NSMutableAttributedString()
            combinedText.append(iconText)
            combinedText.append(buttonText)
            
            breadButton.setAttributedTitle(combinedText, for: .normal)

            breadButton.layer.cornerRadius = 10
            breadButton.layer.shadowColor = UIColor.black.cgColor // 그림자의 색상 설정
            breadButton.layer.shadowOffset = CGSize(width: 0, height: 2.5) // 그림자의 오프셋 설정 (X, Y)
            breadButton.layer.shadowOpacity = 0.5 // 그림자의 투명도 설정 (0.0 ~ 1.0)
            breadButton.layer.shadowRadius = 4 // 그림자의 블러 반경 설정
            print("눌렀음")
//                        breadButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 530)
                        breadButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
                        breadButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
//                        breadButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 260)

            return breadButton
        }()

        
        let stackView = UIStackView(arrangedSubviews: [bobButton, noodleButton, breadButton])
//        stackView.frame = view.bounds
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .white
        stackView.axis = .horizontal
        stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 530).isActive = true
//        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40)
//        stackView.heightAnchor.constraint(equalToConstant: 220)
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        stackView.distribution = .equalSpacing
//        stackView.alignment =
//        stackView.spacing = 20
    }
    
    func createStackview2() {
        
        let alcoholButton: UIButton = {
            let alcoholButton = UIButton()
            alcoholButton.backgroundColor = .white
            alcoholButton.setTitle(" 🍺 \n  술", for: .normal)
            alcoholButton.setTitleColor(.black, for: .normal)
            alcoholButton.titleLabel?.font = UIFont.systemFont(ofSize: 40)
            alcoholButton.titleLabel?.numberOfLines = 0

            let iconText = NSMutableAttributedString(string: "🍺", attributes: [
                .font: UIFont.systemFont(ofSize: 50) // 아이콘 크기 조절
            ])
            let buttonText = NSMutableAttributedString(string: "\n    술", attributes: [
                .font: UIFont.systemFont(ofSize: 19) // 텍스트 크기 조절
            ])
            
            let combinedText = NSMutableAttributedString()
            combinedText.append(iconText)
            combinedText.append(buttonText)
            
            alcoholButton.setAttributedTitle(combinedText, for: .normal)

            alcoholButton.layer.cornerRadius = 10
            alcoholButton.layer.shadowColor = UIColor.black.cgColor // 그림자의 색상 설정
            alcoholButton.layer.shadowOffset = CGSize(width: 0, height: 2.5) // 그림자의 오프셋 설정 (X, Y)
            alcoholButton.layer.shadowOpacity = 0.5 // 그림자의 투명도 설정 (0.0 ~ 1.0)
            alcoholButton.layer.shadowRadius = 4 // 그림자의 블러 반경 설정
//                        alcoholButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 650)
                        alcoholButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
                        alcoholButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
//                        alcoholButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 100)

            return alcoholButton
        }()
        
        let othersButton: UIButton = {
            let othersButton = UIButton()
            othersButton.backgroundColor = .white
            othersButton.setTitle(" 🍴 \n기타", for: .normal)
            othersButton.setTitleColor(.black, for: .normal)
            othersButton.titleLabel?.font = UIFont.systemFont(ofSize: 40)
            othersButton.titleLabel?.numberOfLines = 0

            let iconText = NSMutableAttributedString(string: "🍴", attributes: [
                .font: UIFont.systemFont(ofSize: 50) // 아이콘 크기 조절
            ])
            let buttonText = NSMutableAttributedString(string: "\n  기타", attributes: [
                .font: UIFont.systemFont(ofSize: 19) // 텍스트 크기 조절
            ])
            
            let combinedText = NSMutableAttributedString()
            combinedText.append(iconText)
            combinedText.append(buttonText)
            
            othersButton.setAttributedTitle(combinedText, for: .normal)

            othersButton.layer.cornerRadius = 10
            othersButton.layer.shadowColor = UIColor.black.cgColor // 그림자의 색상 설정
            othersButton.layer.shadowOffset = CGSize(width: 0, height: 2.5) // 그림자의 오프셋 설정 (X, Y)
            othersButton.layer.shadowOpacity = 0.5 // 그림자의 투명도 설정 (0.0 ~ 1.0)
            othersButton.layer.shadowRadius = 4 // 그림자의 블러 반경 설정
//                        othersButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 650)
                        othersButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
                        othersButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
//                        othersButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 210)
            return othersButton
        }()
        
        let stackView2 = UIStackView(arrangedSubviews: [alcoholButton, othersButton])
//        stackView.frame = view.bounds
        view.addSubview(stackView2)
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        stackView2.backgroundColor = .white
        stackView2.axis = .horizontal
        stackView2.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 650).isActive = true
//        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40)
//        stackView.heightAnchor.constraint(equalToConstant: 220)
        stackView2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 90).isActive = true
        stackView2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -90).isActive = true
        stackView2.distribution = .equalSpacing
        stackView2.spacing = 20
    }
    
//    @objc private func searchButtonTapped() {
//        // 좋아요 버튼이 탭되었을 때 수행할 동작을 여기에 추가하세요.
//        print("버튼이 눌렸습니당")
//        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SearchViewController") else {return}
//        self.present(nextVC, animated: true)
//    }
    
//    @objc private func searchButtonTapped() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil) // 스토리보드 이름을 적절하게 변경하세요.
//        guard let nextVC = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else { return }
//        self.present(nextVC, animated: true, completion: nil)
//    }
    
    
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
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor // 그림자의 색상 설정
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.5) // 그림자의 오프셋 설정 (X, Y)
        cell.layer.shadowOpacity = 0.5 // 그림자의 투명도 설정 (0.0 ~ 1.0)
        cell.layer.shadowRadius = 4 // 그림자의 블러 반경 설정

        return cell
    }
}

extension  MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(self.view.frame.width)
        let size = (self.view.frame.width)
        return CGSize(width: 280, height: 302)
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

//[" 🍚 \n  밥", " 🍝 \n  면", " 🍞 \n  빵", " 🍺 \n  술", " 🍴 \n기타"]
