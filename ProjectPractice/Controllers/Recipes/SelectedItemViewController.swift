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
    
    private var recipes: [Recipe] = [Recipe]() {
        didSet {
            self.selectedCollectionView.reloadData()
        }
    }
    
    private lazy var selectedCollectionView: UICollectionView = {
        return self.configureCollectionView()
    }()
    
    init(cuisine: Cuisine) {
        self.cuisine = cuisine
        super.init(nibName: nil, bundle: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.configureViews()
        
        self.setupNavBar()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func addRecipeButtonTapped(sender: UIButton) {
        self.recipes.append(Recipe.generateFakeRecipe())
    }
    
    private func setupNavBar() {
        
        let navFont = UIFont(name: "HelveticaNeue-Bold", size: 18.0)
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white, .font: navFont!]
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = .tinderOrange
        self.navigationItem.title = self.cuisine.name.uppercased()
        
    }
    
    private func configureViews() {
        
        self.view.addSubview(self.selectedCollectionView)
        
        self.selectedCollectionView.addConstraintsToFillView(self.view)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addRecipeButtonTapped(sender:)))
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
        cv.contentInset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
        cv.showsHorizontalScrollIndicator = false
        cv.register(UINib(nibName: RecipeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: RecipeCollectionViewCell.identifier)
        
        return cv
        
    }
    
    private func setupWaterFallViewAt(_ index: Int) -> CGFloat {
        
        if index % 7 == 0 {
            return 240.0
        } else if index % 7 == 1 {
            return 350.0
        } else if index % 7 == 2 {
            return 400.0
        } else if index % 7 == 3 {
            return 180.0
        } else if index % 7 == 4 {
            return 280.0
        } else if index % 7 == 5 {
            return 500.0
        } else if index % 7 == 6 {
            return 310.0
        } else {
            return 240.0
        }
    
    }

}

extension SelectedItemViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = self.selectedCollectionView.dequeueReusableCell(withReuseIdentifier: RecipeCollectionViewCell.identifier, for: indexPath) as? RecipeCollectionViewCell {
            cell.recipeImageView.image = Cuisine.generateFakeCuisines().randomElement()?.image
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        logDebugMessage("IndexPath tapped is \(indexPath.row)")
    }
    
}

extension SelectedItemViewController: WaterfallLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return self.setupWaterFallViewAt(indexPath.row)
    }
    
}
