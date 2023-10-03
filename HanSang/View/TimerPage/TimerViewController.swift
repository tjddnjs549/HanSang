import UIKit

class TimerViewController: UIViewController {
    
    let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["timer", "stopwatch"])
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    let timer: UIView = {
        let view = TimerView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stopwatch: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var shouldHideFirstView: Bool? {
        didSet {
            guard let shouldHideFirstView = self.shouldHideFirstView else { return }
            self.timer.isHidden = shouldHideFirstView
            self.stopwatch.isHidden = !self.timer.isHidden
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
        self.view.addSubview(self.timer)
        self.view.addSubview(self.stopwatch)
        
        NSLayoutConstraint.activate([
            self.segmentedControl.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.segmentedControl.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            self.segmentedControl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            self.segmentedControl.heightAnchor.constraint(equalToConstant: 30),
        ])
        NSLayoutConstraint.activate([
            self.timer.leftAnchor.constraint(equalTo: self.segmentedControl.leftAnchor),
            self.timer.rightAnchor.constraint(equalTo: self.segmentedControl.rightAnchor),
            self.timer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80),
            self.timer.topAnchor.constraint(equalTo: self.segmentedControl.bottomAnchor, constant: 16),
        ])
        NSLayoutConstraint.activate([
            self.stopwatch.leftAnchor.constraint(equalTo: self.timer.leftAnchor),
            self.stopwatch.rightAnchor.constraint(equalTo: self.timer.rightAnchor),
            self.stopwatch.bottomAnchor.constraint(equalTo: self.timer.bottomAnchor),
            self.stopwatch.topAnchor.constraint(equalTo: self.timer.topAnchor),
        ])
        
        self.segmentedControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
        
        self.segmentedControl.selectedSegmentIndex = 0
        self.didChangeValue(segment: self.segmentedControl)
    }
    
    @objc private func didChangeValue(segment: UISegmentedControl) {
        self.shouldHideFirstView = segment.selectedSegmentIndex != 0
    }
}
