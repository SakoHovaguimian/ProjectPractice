//
//  ShoppingListViewController.swift
//  ProjectPractice
//
//  Created by Sako Hovaguimian on 3/14/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import AVKit
import Animo

class ShoppingListViewController: UIViewController {
    
    var player: AVPlayer?
    var timeObserver: Any?
    
    var controlButtonIsPlaying: Bool = true {
        didSet {
            self.updateControlButtonState()
        }
    }
    
    private lazy var slider: UISlider = {
        let slide = UISlider()
        slide.minimumValue = 0
        slide.maximumValue = 100
        slide.value = 50
        slide.addTarget(self, action: #selector(self.onSliderValChanged(slider:event:)), for: .valueChanged)
        return slide
    }()
    
    private lazy var controlButton: UIButton =  {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .tinderOrange
        btn.setTitle("isPlaying", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(self.controlButtonTapped(sender:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var durationLabel: UILabel =  {
        let label = UILabel()
        label.text = "Something is coming"
        label.textAlignment = .right
        label.textColor = .lightGray
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .ISABELLINE
        
        self.setupAudioPlayer()
        self.setupNavBar()
        self.configureSlider()
        self.configureButton()
        self.configureDurationLabel()
        
    }
    
    private func updateControlButtonState() {
        let title = self.controlButtonIsPlaying ? "isPlaying": "isPaused"
        self.controlButton.setTitle(title, for: .normal)
    }
    
    private func setupNavBar() {
        
        self.navigationItem.title = "SHOPPING LIST"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Shopping", style: .plain, target: nil, action: nil)
        
    }
    
    private func setupAudioPlayer() {
        
        let path = Bundle.main.path(forResource: "TestTrack.mp3", ofType :nil)
        let url = URL(fileURLWithPath: path ?? "")
        
        NotificationCenter.default.addObserver(
        self,
        selector: #selector(self.playerDidFinishPlaying),
        name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
        object: nil)
        
        self.player = AVPlayer(url: url)
        self.player?.play()
        self.slider.maximumValue = Float((self.player?.currentItem?.asset.duration.seconds)!)
        self.configureTimeObserver()
        
    }
    
    private func configureTimeObserver() {
        
        self.timeObserver =  player?.addPeriodicTimeObserver(forInterval: CMTime.init(value: 1, timescale: 1), queue: .main, using: { time in
            let time = CMTimeGetSeconds(time)
            self.slider.value = Float(time)
            self.durationLabel.text = self.stringFromTimeInterval(interval: time)
        
        })
    
    }
    
    
    private func configureSlider() {
        self.view.addSubview(self.slider)
        self.slider.centerX(inView: self.view)
        self.slider.centerY(inView: self.view)
        self.slider.anchor(left: self.view.leftAnchor, right: self.view.rightAnchor,
                            paddingLeft: 32, paddingRight: 32)
    }
    
    private func configureButton(){
        self.view.addSubview(self.controlButton)
        self.controlButton.centerX(inView: self.view)
        self.controlButton.anchor(top: self.slider.bottomAnchor, paddingTop: 64, width: self.view.frame.width - 64, height: 50)
    }
    
    private func configureDurationLabel() {
        self.view.addSubview(self.durationLabel)
        self.durationLabel.anchor(top: self.slider.bottomAnchor, left: self.slider.leftAnchor, right: self.slider.rightAnchor, paddingTop: -16 , height: 50)
    }
    
    func stringFromTimeInterval(interval: Float64) -> String {

        let truncatedInterval = interval.truncate(to: 0)
        let hours = (Int(truncatedInterval) / 3600)
        let minutes = Int(truncatedInterval / 60) - Int(hours * 60)
        let seconds = Int(truncatedInterval) - (Int(truncatedInterval / 60) * 60)

        return String(format: "%0.2d:%0.2d",minutes,seconds)
    }
    
    @objc private func playerDidFinishPlaying() {
        self.durationLabel.text = "Ended"
    }
    
    @objc private func controlButtonTapped(sender: UIButton) {
        self.controlButtonIsPlaying = !self.controlButtonIsPlaying
        self.controlButtonIsPlaying ? self.player?.play() : self.player?.pause()
    }
    
    @objc private func onSliderValChanged(slider: UISlider, event: UIEvent) {
        
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                self.player?.removeTimeObserver(self.timeObserver!)
            case .moved:
                let seconds : Float64 = Float64(slider.value)
                player?.seek(to: CMTimeMakeWithSeconds(Float64(seconds),preferredTimescale: (player?.currentItem!.asset.duration.timescale)!)) { [weak self](state) in
                    self?.player?.play()
                }
            case .ended:
                self.configureTimeObserver()
            default:
                break
            }
            
        }
    }
    
}


