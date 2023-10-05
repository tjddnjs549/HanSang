import UIKit
import SnapKit

class StopwatchView: UIView {
    private var timer = Timer()
    private var isRunning = false
    private var elapsedTime = 0.0
    private var minute = 0
    private var hour = 0

    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 36)
        label.textAlignment = .center
        label.text = "00:00:00"
        return label
    }()

    private lazy var startStopButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.backgroundColor = ColorGuide.main.withAlphaComponent(0.75)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(startStopButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reset", for: .normal)
        button.backgroundColor = ColorGuide.textHint.withAlphaComponent(0.75)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

    private func setupUI() {
        addSubview(timeLabel)
        addSubview(startStopButton)
        addSubview(resetButton)

        timeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(216)
        }

        startStopButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-80)
            make.top.equalTo(timeLabel.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.4)
        }

        resetButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(80)
            make.top.equalTo(timeLabel.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
    }

    @objc private func startStopButtonTapped() {
        isRunning.toggle()

        if isRunning {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            startStopButton.setTitle("Stop", for: .normal)
        } else {
            timer.invalidate()
            startStopButton.setTitle("Start", for: .normal)
        }
    }

    @objc private func resetButtonTapped() {
        timer.invalidate()
        isRunning = false
        elapsedTime = 0.0
        minute = 0
        hour = 0
        updateTimeLabel()
        startStopButton.setTitle("Start", for: .normal)
    }

    @objc private func updateTime() {
        elapsedTime += 0.1

        if elapsedTime >= 3600.0 { // 3600 초(1시간) 이상일 때, 시간을 증가시키고 초를 리셋합니다.
            elapsedTime = 0.0
            hour += 1
        } else if elapsedTime >= 60.0 { // 60 초(1분) 이상일 때, 분을 증가시키고 초를 리셋합니다.
            elapsedTime -= 60.0
            minute += 1
        }
        updateTimeLabel()
    }

    private func updateTimeLabel() {
        let seconds = Int(elapsedTime)
        let minutes = minute
        let hours = seconds / 3600
        let tenthsOfSecond = Int((elapsedTime * 10).truncatingRemainder(dividingBy: 10))

        timeLabel.text = String(format: "%02d:%02d:%02d.%01d", hours, minutes, seconds, tenthsOfSecond)
    }
}
