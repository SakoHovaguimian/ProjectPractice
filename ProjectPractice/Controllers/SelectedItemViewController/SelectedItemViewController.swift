//
//  SelectedItemViewController.swift
//  ProjectPractice
//
//  Created by Sako Hovaguimian on 3/12/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo

class SelectedItemViewController: UIViewController {
    
    private var cuisine: Cuisine
    
    private lazy var selectedCollectionView: UICollectionView =  {
        return self.configureCollectionView()
    }()
    
    init(cuisine: Cuisine) {
        self.cuisine = cuisine
        super.init(nibName: nil, bundle: nil)
        self.setupNavBar(title: self.cuisine.name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.configureViews()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNavBar(title: String) {
        self.navigationItem.title = title.uppercased()
    }
    
    private func configureViews() {
        self.view.addSubview(self.selectedCollectionView)
        self.selectedCollectionView.addConstraintsToFillView(self.view)
    }
    
    private func configureCollectionView() -> UICollectionView {
        
        let layout = WaterfallLayoutCollectionFlowLayout()
        layout.delegate = self
        
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.isScrollEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        return cv
        
    }
    
    private func setupWaterFallViewAt() -> CGFloat {
        
        let numberArray: [CGFloat] = [240.0, 200.0, 400.0, 350.0, 280.0, 500.0, 440.0]
        
        return numberArray.randomElement()!
        
    }
    
    
}

extension SelectedItemViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.selectedCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .ISABELLINE
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return self.setupWaterFallViewAt(indexPath.row)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 1.0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 1.0
//    }
    
}

extension SelectedItemViewController: WaterfallLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return self.setupWaterFallViewAt()
    }
    
}
