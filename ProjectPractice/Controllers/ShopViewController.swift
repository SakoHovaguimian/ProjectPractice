//
//  ShopViewController.swift
//  ProjectPractice
//
//  Created by Sako Hovaguimian on 3/10/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController {
    
    private lazy var shopCollectionView: UICollectionView =  {
        return self.configureCollectionView()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.configureViews()
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.setupNavBar()
        
    }
    
    private func setupNavBar() {
        self.navigationItem.title = "RECIPES"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Recipes", style: .plain, target: nil, action: nil)
    }
    
    private func configureViews() {
        self.view.addSubview(self.shopCollectionView)
        self.shopCollectionView.addConstraintsToFillView(self.view)
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

extension ShopViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = self.shopCollectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell {
            cell.cuisine = Cuisine.generateFakeCuisine()
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionFrame = self.view.frame
        return CGSize(width: collectionFrame.width / 2, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let food = "Pizza"
        let description = "This is the best pizza you've ever had in your life."
        self.navigationController?.pushViewController(SelectedItemViewController(food: food, description: description), animated: true)
    }
    
}
