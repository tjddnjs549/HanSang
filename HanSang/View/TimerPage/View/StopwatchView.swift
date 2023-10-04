import UIKit
import SnapKit

class StopwatchView: UIView {
    
    let timerLabel = UILabel()
    let startStopButton = UIButton()
    let resetButton = UIButton()
    
    var timer:Timer = Timer()
    var count:Int = 0
    var timerCounting:Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        startStopButton.setTitleColor(UIColor.green, for: .normal)
        addSubview(startStopButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
