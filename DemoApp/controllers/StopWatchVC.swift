//
//  StopWatchVC.swift
//  DemoApp
//
//  Created by Monika on 22/09/20.
//

import UIKit

class StopWatchVC: UIViewController {
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var btnPause: UIButton!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var lblTimer: UILabel!
    
    var seconds = 0
    var timer = Timer()
 
    var isRunning = false
    var isResumed = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnPause.disable(val: true)
        btnStop.disable(val: true)
    }

    @IBAction func stop(_ sender: Any) {
        timer.invalidate()
        lblTimer.timerStyle(val: String(0))
        seconds = 0
        btnPause.disable(val: true)
        btnStop.disable(val: true)
        btnPlay.disable(val: false)
    }
    
    @IBAction func pause(_ sender: Any) {
        if isResumed {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateUI), userInfo: nil, repeats: true)
        } else {
            timer.invalidate()
        }
        isResumed.toggle()
    }
    
    @IBAction func play(_ sender: Any) {
        if !isRunning {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateUI), userInfo: nil, repeats: true)
            btnPlay.disable(val: true)
            btnPause.disable(val: false)
            btnStop.disable(val: false)
        }
    }
    
    @objc func updateUI() {
        seconds += 1
        lblTimer.timerStyle(val: String(seconds))
    }
}

extension UIButton {
    func disable(val: Bool = true) {
        isUserInteractionEnabled = !val
        alpha = val ? 0.5 : 1.0
    }
}

extension UILabel {
    func timerStyle(val: String) {
        if let intValue = Int(val) {
            self.text = String(format:"%02i:%02i:%02i", intValue / 3600, intValue / 60 % 60, intValue % 60)
        }
    }
}
