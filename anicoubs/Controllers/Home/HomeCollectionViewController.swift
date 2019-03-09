//
//  HomeViewController.swift
//  anicoubs
//
//  Created by Holofox on 30.01.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

import UIKit

class HomeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    enum CellId {
        static let owner = "ownerCellId"
        static let postponed = "postponedCellId"
        static let suggests = "suggestsCellId"
    }
    
    fileprivate lazy var cellIdDictionary : [Int: String] = [0: CellId.owner, 1: CellId.postponed, 2: CellId.suggests]
    
    // MARK: Property
    
    let segmentedBar: UISegmentedControl = {
        let items = ["Owner", "Postponed", "Suggests"]
        let control = UISegmentedControl(items: items)
            control.selectedSegmentIndex = 0
            control.tintColor = Color.primaryColor
        
        return control
    }()
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupNavBarButtons()
        setupLayout()
        
    }
    
    // MARK: Navigation
    
    private func setupNavigationBar() {
        segmentedBar.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)
        
        // NOTE: Add search
        
        /*let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = nil
        
        navigationItem.searchController = search*/
        
        navigationItem.title = "Home"
        navigationItem.titleView = segmentedBar
        
    }
    
    private func setupNavBarButtons() {
        let addButton = UIBarButtonItem(image: UIImage(named: "plus")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAdd))
        
        navigationItem.rightBarButtonItems = [addButton]
    }
    
    
    // MARK: Handle
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        scrollToBarIndex(menuIndex: sender.selectedSegmentIndex)
    }
    
    @objc func handleAdd() {
        navigationController?.pushViewController(CollapsibleTableViewController(), animated: true)
    }

    // MARK: Layout
    
    fileprivate func setupLayout() {
        
        collectionView.backgroundColor = Color.backgroundColor
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.allowsSelection = true

        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        collectionView.register(OwnerViewCollectionCell.self, forCellWithReuseIdentifier: CellId.owner)
        collectionView.register(PostponedCollectionViewCell.self, forCellWithReuseIdentifier: CellId.postponed)
        collectionView.register(SuggestsViewCollectionCell.self, forCellWithReuseIdentifier: CellId.suggests)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        
    }
    
    // MARK: Segments selector
    
    private func scrollToBarIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        segmentedBar.selectedSegmentIndex = menuIndex
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        let item = x / view.frame.width
        
        segmentedBar.selectedSegmentIndex = Int(item)
    }
    
    // MARK: CollectionView
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellIdDictionary.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = cellIdDictionary[indexPath.item, default: CellId.owner]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) 

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.safeAreaLayoutGuide.layoutFrame.height)
    }

}

