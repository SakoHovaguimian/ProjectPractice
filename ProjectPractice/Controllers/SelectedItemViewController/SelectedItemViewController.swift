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

   private lazy var selectedCollectionView: UICollectionView =  {
       return self.configureCollectionView()
   }()

   override func viewDidLoad() {
       super.viewDidLoad()

       self.view.backgroundColor = .white
       self.configureViews()

   }
    
    init(food: String, description: String) {
        super.init(nibName: nil, bundle: nil)
        self.setupNavBar(title: food)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNavBar(title: String) {
        self.navigationItem.title = title
    }
    
    private func configureViews() {
        self.view.addSubview(self.selectedCollectionView)
        self.selectedCollectionView.addConstraintsToFillView(self.view)
    }
    
    private func configureCollectionView() -> UICollectionView {
        
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .vertical
         layout.minimumLineSpacing = 0
         layout.minimumInteritemSpacing = 0
         
         let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
         cv.translatesAutoresizingMaskIntoConstraints = false
         cv.delegate = self
         cv.dataSource = self
         cv.backgroundColor = .clear
         cv.isScrollEnabled = true
         cv.showsHorizontalScrollIndicator = false
         cv.register(UINib(nibName: HomeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)

         return cv
         
     }
    
}


extension SelectedItemViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = self.selectedCollectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell {
            cell.containerView.backgroundColor = indexPath.row == 0 ? .red : indexPath.row == 1 ? .black : .blue
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionFrame = self.selectedCollectionView.frame
        return CGSize(width: collectionFrame.width, height: collectionFrame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(ShopViewController(), animated: true)
    }
    
}
