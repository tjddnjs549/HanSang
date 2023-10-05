import UIKit
import SnapKit

class TimerView: UIView {
    
    let timeDatePicker = UIDatePicker()
    let startButton = UIButton()
    let stopButton = UIButton()
    let timerLabel = UILabel()
    
    var timer: Timer?
    var remainingTime: TimeInterval = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // MARK: - UIDatePicker 설정
        timeDatePicker.datePickerMode = .countDownTimer
        addSubview(timeDatePicker)
        timeDatePicker.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
        // MARK: - 시작 버튼 설정
        startButton.setTitle("Start Timer", for: .normal)
        startButton.backgroundColor = .orange.withAlphaComponent(0.75)
        startButton.layer.cornerRadius = 15
        startButton.layer.borderWidth = 1.5
        startButton.layer.borderColor = UIColor.systemOrange.cgColor
        startButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        addSubview(startButton)
        startButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(-80)
            make.top.equalTo(timeDatePicker.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        // MARK: - 중지 버튼 설정
        stopButton.setTitle("Stop Timer", for: .normal)
        stopButton.backgroundColor = .red.withAlphaComponent(0.75)
        stopButton.layer.cornerRadius = 15
        stopButton.layer.borderWidth = 1.5
        stopButton.layer.borderColor = UIColor.systemRed.cgColor
        stopButton.addTarget(self, action: #selector(stopTimer), for: .touchUpInside)
        addSubview(stopButton)
        stopButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(80)
            make.top.equalTo(timeDatePicker.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        // MARK: - UILabel 설정
        timerLabel.textAlignment = .center
        timerLabel.font = UIFont.systemFont(ofSize: 24)
        addSubview(timerLabel)
        timerLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(startButton.snp.bottom).offset(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func startTimer() {
        let selectedTime = timeDatePicker.countDownDuration
        
        if selectedTime <= 0 {
            return
        }
        
        remainingTime = selectedTime
        updateTimerLabel()
        
        // MARK: - 기존 타이머 초기화
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
                
                // MARK: = 시작 버튼 비활성화, 중지 버튼 활성화
                self.startButton.isEnabled = false
                self.stopButton.isEnabled = true
            }
    }
    
    @objc func stopTimer() {
        // MARK: - 타이머 중지
        timer?.invalidate()
        timer = nil
        
        // MARK: - 시작 버튼 활성화, 중지 버튼 비활성화
        startButton.isEnabled = true
        stopButton.isEnabled = false
    }
    
    @objc func updateTime() {
        if remainingTime >= 1 {
            remainingTime -= 1
            let hours = Int(remainingTime) / 3600
            let minutes = (Int(remainingTime) % 3600) / 60
            let seconds = Int(remainingTime) % 60
            timerLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else if remainingTime == 0 {
            timerLabel.text = "00:00:00"
            
            // 타이머 종료
            timer?.invalidate()
            timer = nil
            startButton.isEnabled = true
            stopButton.isEnabled = false
            
            // 알림 표시
            let alert = UIAlertController(title: "타이머 완료", message: "설정한 시간이 끝났습니다.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(okAction)
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    func updateTimerLabel() {
        if remainingTime >= 1 {
            let hours = Int(remainingTime) / 3600
            let minutes = (Int(remainingTime) % 3600) / 60
            let seconds = Int(remainingTime) % 60
            timerLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
              remainingTime -= 0
          } else {
            timerLabel.text = "00:00:00"
          }
    }
}
