//
//  MainViewController.swift
//  TacoPOP
//
//  Created by Per Kristensen on 17/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, DataServiceDelegate {
    
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var ds = DataService.instance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ds.delegate = self
        ds.loadDeliciousTacoData()
        ds.tacoArray.shuffle()
        
        collectionView.dataSource = self
        collectionView.delegate = self

        headerView.addDropShadow()
        
//        let nib = UINib(nibName: "TacoCollectionViewCell", bundle: nil)
//        collectionView.register(nib, forCellWithReuseIdentifier: "TacoCollectionViewCell")
        collectionView.register(TacoCollectionViewCell.self)
    }
    
    func deliciousTacoDataLoaded() {
        collectionView.reloadData()
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ds.tacoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TacoCollectionViewCell", for: indexPath) as? TacoCollectionViewCell {
//            cell.configureCell(taco: ds.tacoArray[indexPath.row])
//            return cell
//        }
//        
//        return UICollectionViewCell()
        
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as TacoCollectionViewCell
        cell.configureCell(taco: ds.tacoArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 168, height: 178)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? TacoCollectionViewCell {
            cell.shake()
        }
    }
}
