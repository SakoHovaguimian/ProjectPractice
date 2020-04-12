//
//  HomeViewController.swift
//  ProjectPractice
//
//  Created by Sako Hovaguimian on 3/10/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo

protocol PresentProfileControllerDelegate: class {
    func presentProfileVC()
}

class HomeViewController: UIViewController {
    
    weak var delegate: PresentProfileControllerDelegate!
    
    private let user = User.fakeDataUsers().randomElement()!
    
    private var popOverViewController: PopOverViewController?
    
    private var buttonState: Bool = false
    
    private lazy var homeTableView: UITableView = {
        let tv = UITableView()
        tv.tableFooterView = UIView()
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        tv.register(UINib(nibName: HomeTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: HomeTableViewCell.identifier)
        return tv
    }()
    
    private lazy var profileButton: UIButton = {
        let profileBarButton = UIButton(type: .custom)
        profileBarButton.clipsToBounds = true
        profileBarButton.imageView?.contentMode = .scaleAspectFill
        profileBarButton.setImage(self.user.image, for: .normal)
        profileBarButton.addTarget(self, action: #selector(self.profileButtonTapped(sender:)), for: .touchUpInside)
        return profileBarButton
    }()
    
    private lazy var homeCollectionView: UICollectionView =  {
        return self.configureCollectionView()
    }()
    
    private lazy var optionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blackishGray
        button.clipsToBounds = true
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(self.optionsButtonTapped(sender:)), for: .touchUpInside)
        return button
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
    
    @objc private func profileButtonTapped(sender: UIButton) {
        self.delegate.presentProfileVC()
        logDebugMessage("Profile Button Tapped")
    }
    
    @objc private func optionsButtonTapped(sender: UIButton) {
        self.animateActionButton()
    }
    
    private func configureViews() {
        
        self.view.addSubview(self.homeTableView)
        
        self.homeTableView.anchor(top: self.view.topAnchor, left: self.view.leftAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: self.view.frame.height / 2)
        
        self.view.addSubview(self.homeCollectionView)
        
        self.homeCollectionView.anchor(top: self.homeTableView.bottomAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 15, paddingLeft: 0, paddingBottom: 50, paddingRight: 0)
        
        self.view.addSubview(self.optionsButton)
        
        self.optionsButton.anchor(bottom: self.view.safeAreaLayoutGuide.bottomAnchor,
                                  right: self.view.rightAnchor,
                                  paddingBottom: 32,
                                  paddingRight: 16,
                                  width: 70,
                                  height: 70)
        
        self.optionsButton.layer.cornerRadius = 35.0

    }
    
    private func animateActionButton() {

        UIView.animate(withDuration: 0.25, animations: {
            if self.buttonState {
                self.optionsButton.transform = .identity
            } else {
                self.optionsButton.transform = CGAffineTransform(rotationAngle: .pi / 4)
                self.loadPopOverViewController()
            }
            self.buttonState.toggle()
        })
        
    }
    
    private func loadPopOverViewController() {
        
        self.popOverViewController = PopOverViewController()
        self.popOverViewController?.view.alpha = 0.0

        self.popOverViewController?.modalPresentationStyle = .popover
        self.popOverViewController?.optionsButtonDelegate = self

        let popOverVC = self.popOverViewController?.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = self.optionsButton
        popOverVC?.permittedArrowDirections = .down
        popOverVC?.popoverBackgroundViewClass = nil
        
        self.popOverViewController?.preferredContentSize = CGSize(width: 250, height: 250)

        self.present(self.popOverViewController!, animated: true)
        
    }
    
    private func setupNavBar() {
        
        let customView = UIView()
        customView.setDimmensions(height: 44, width: 35)
        customView.addSubview(self.profileButton)
        
        self.profileButton.setDimmensions(height: 35, width: 35)
        self.profileButton.layer.cornerRadius = 35 / 2
        
        profileButton.centerX(inView: customView, constant: 0)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customView)
        
        self.navigationItem.title = "HOME"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: nil, action: nil)
        
    }
    
    private func configureCollectionView() -> UICollectionView {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.isScrollEnabled = true
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.register(UINib(nibName: HomeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        
        return cv
        
    }
    
    
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = self.homeTableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell {
            
            cell.value = "Home Page"
            cell.textLabel?.textColor = .white
            
            return cell
            
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let recipe = Recipe.generateFakeRecipe()
//        let object = ["name": recipe]
        let object = ["name": "Sako Hovaguimian"]
        NotificationCenter.default.post(name: .testNotification, object: object)
    }
    
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = self.homeCollectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell {
            cell.containerView.backgroundColor = .ISABELLINE
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionFrame = self.homeCollectionView.frame
        return CGSize(width: collectionFrame.width, height: collectionFrame.height - 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(RecipeViewController(), animated: true)
    }
    
}

extension HomeViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        self.popOverViewController = nil
        self.animateActionButton()
    }
}

extension HomeViewController: OptionButtonTappedDelegate {
    
    func handleOptionButtonTapped(forOption option: Option) {
        logSuccess(option.name)
        self.animateActionButton()
    }
    
}
