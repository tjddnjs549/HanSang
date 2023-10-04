import UIKit

class TimerViewController: UIViewController {
    
    let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Timer", "Stopwatch"])
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    let Timer: UIView = {
        let view = TimerView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let Stopwatch: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var shouldHideFirstView: Bool? {
        didSet {
            guard let shouldHideFirstView = self.shouldHideFirstView else { return }
            self.Timer.isHidden = shouldHideFirstView
            self.Stopwatch.isHidden = !self.Timer.isHidden
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if let originalImage = UIImage(named: "HANSANG") {
            let tintedImage = originalImage.withTintColor(ColorGuide.main)
            let button = UIBarButtonItem(image: tintedImage, style: .plain, target: nil, action: nil)
            button.tintColor = ColorGuide.main
            navigationItem.leftBarButtonItem = button
        }
        
        self.view.addSubview(self.segmentedControl)
        self.view.addSubview(self.Timer)
        self.view.addSubview(self.Stopwatch)
        
        NSLayoutConstraint.activate([
            self.segmentedControl.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.segmentedControl.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            self.segmentedControl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            self.segmentedControl.heightAnchor.constraint(equalToConstant: 30),
        ])
        NSLayoutConstraint.activate([
            self.Timer.leftAnchor.constraint(equalTo: self.segmentedControl.leftAnchor),
            self.Timer.rightAnchor.constraint(equalTo: self.segmentedControl.rightAnchor),
            self.Timer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80),
            self.Timer.topAnchor.constraint(equalTo: self.segmentedControl.bottomAnchor, constant: 16),
        ])
        NSLayoutConstraint.activate([
            self.Stopwatch.leftAnchor.constraint(equalTo: self.Timer.leftAnchor),
            self.Stopwatch.rightAnchor.constraint(equalTo: self.Timer.rightAnchor),
            self.Stopwatch.bottomAnchor.constraint(equalTo: self.Timer.bottomAnchor),
            self.Stopwatch.topAnchor.constraint(equalTo: self.Timer.topAnchor),
        ])
        
        self.segmentedControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
        
        self.segmentedControl.selectedSegmentIndex = 0
        self.didChangeValue(segment: self.segmentedControl)
    }
    
    @objc private func didChangeValue(segment: UISegmentedControl) {
        self.shouldHideFirstView = segment.selectedSegmentIndex != 0
    }
}
