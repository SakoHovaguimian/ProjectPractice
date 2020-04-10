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
    
    private let items = ["TestTrack.mp3", "Nova.mp3","TestTrack.mp3", "Nova.mp3","TestTrack.mp3", "Nova.mp3"]
    
    private var player: AVPlayer?
    private var timeObserver: Any?
    
    private var controlButtonIsPlaying: Bool = true {
        didSet {
            self.updateControlButtonState()
        }
    }
    
    private var currentPage: Int = 0 {
        didSet {
            let song = self.items[self.currentPage]
            self.setupAudioPlayer(url: song)
        }
    }
    
    private var pageSize: CGSize {
        let layout = self.musicCollectionView.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = layout.itemSize
        if layout.scrollDirection == .horizontal {
            pageSize.width += layout.minimumLineSpacing
        } else {
            pageSize.height += layout.minimumLineSpacing
        }
        return pageSize
    }
    
    private lazy var slider: UISlider = {
        let slide = UISlider()
        slide.minimumValue = 0
        slide.maximumValue = 100
        slide.value = 0
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
        label.text = "00:00/00:00"
        label.textAlignment = .right
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var musicCollectionView: UICollectionView = {
        return self.configureCollectionView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .ISABELLINE
        
        self.setupNavBar()
        self.configureSlider()
        self.configureButton()
        self.configureDurationLabel()
        self.setupObservers()
        self.setupCollectionView()
        
        self.currentPage = 0
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    
        self.controlButtonIsPlaying = false
        self.player?.pause()
        
    }
    
    private func setupObservers() {
        
        NotificationCenter.default.addObserver(
        self,
        selector: #selector(self.playerDidFinishPlaying),
        name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
        object: nil)
        
    }
    
    private func updateControlButtonState() {
        let title = self.controlButtonIsPlaying ? "isPlaying" : "isPaused"
        self.controlButton.titleLabel?.text = title
        self.controlButton.setTitle(title, for: .normal)
    }
    
    private func setupNavBar() {
        
        self.navigationItem.title = "SHOPPING LIST"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Shopping", style: .plain, target: nil, action: nil)
        
    }
    
    private func setupAudioPlayer(url: String? = "TestTrack.mp3") {
        
        let path = Bundle.main.path(forResource: url, ofType: nil)
        let url = URL(fileURLWithPath: path ?? "")
        
        self.controlButtonIsPlaying = true
        
        self.player = AVPlayer(url: url)
        self.player?.play()
        
        self.slider.maximumValue = Float((self.player?.currentItem?.asset.duration.seconds)!)
        self.configureTimeObserver()
        
    }
    
    private func configureTimeObserver() {
        
        self.timeObserver =  player?.addPeriodicTimeObserver(forInterval: CMTime.init(value: 1, timescale: 1), queue: .main, using: { [weak self] time in
            let time = CMTimeGetSeconds(time)
            self?.slider.value = Float(time)
            self?.durationLabel.text = (self?.stringFromTimeInterval(interval: time))! + "/" + (self?.stringFromTimeInterval(interval: Float64((self?.slider.maximumValue)!)))!
        
        })
    
    }
    
    private func configureSlider() {
        
        self.slider.minimumTrackTintColor = .black
        self.slider.maximumTrackTintColor = .muddyBlue
        self.slider.thumbTintColor = .tinderOrange
        
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
    
    private func stringFromTimeInterval(interval: Float64) -> String {

        let truncatedInterval = interval.truncate(to: 0)
        let hours = (Int(truncatedInterval) / 3600)
        let minutes = Int(truncatedInterval / 60) - Int(hours * 60)
        let seconds = Int(truncatedInterval) - (Int(truncatedInterval / 60) * 60)

        return String(format: "%0.2d:%0.2d",minutes,seconds)
    }
    
    private func configureCollectionView() -> UICollectionView {
        
        let flowLayout = UPCarouselFlowLayout()
        flowLayout.itemSize = CGSize(width: 200, height: 200.0)
        flowLayout.scrollDirection = .horizontal
        flowLayout.sideItemScale = 0.8
        flowLayout.sideItemAlpha = 0.8
        flowLayout.spacingMode = .fixed(spacing: 5.0)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self

        return collectionView
        
    }
    
    private func setupCollectionView() {
        
        self.view.addSubview(self.musicCollectionView)
        
        self.musicCollectionView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor,
                                        left: self.view.leftAnchor,
                                        bottom: self.slider.topAnchor,
                                        right: self.view.rightAnchor,
                                        paddingTop: 0,
                                        paddingLeft: 0,
                                        paddingBottom: 64,
                                        paddingRight: 0)
        
    }
    
    @objc private func playerDidFinishPlaying() {
        self.player?.removeTimeObserver(self.timeObserver!)
        self.currentPage += 1
        self.musicCollectionView.scrollToItem(at: IndexPath(row: currentPage, section: 0), at: .centeredHorizontally, animated: true)
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
                self.player?.pause()
                self.controlButtonIsPlaying = false
            case .moved:
                let seconds : Float64 = Float64(slider.value)
                player?.seek(to: CMTimeMakeWithSeconds(Float64(seconds), preferredTimescale: (player?.currentItem!.asset.duration.timescale)!))
            case .ended:
                self.configureTimeObserver()
                self.player?.play()
                self.controlButtonIsPlaying = true
            default:
                break
            }
        }
        
    }
    
}

extension ShoppingListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.musicCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let image = UIImage(named: indexPath.row % 2 == 0 ? "dgd1" : "dgd2")
        let imageView = UIImageView(frame: cell.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = image
        cell.addSubview(imageView)
        cell.backgroundColor = .armyGreen
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.musicCollectionView.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
    }
    
    
}

