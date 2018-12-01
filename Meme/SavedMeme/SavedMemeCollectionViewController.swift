//
//  SavedMemeCollectionViewController.swift
//  Meme
//
//  Created by Bruno Alves on 01/12/18.
//  Copyright © 2018 Bruno Alves. All rights reserved.
//

import UIKit

class SavedMemeCollectionViewController: SavedMemesBaseViewController {

    // MARK: Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Lyfecicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    private func setup() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width
        
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
    }
}

extension SavedMemeCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MemesModel.shared.memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "meme", for: indexPath) as! SavedMemeCollectionViewCell
        
        let item = MemesModel.shared.memes[indexPath.row]
        cell.image.image = item.memeImage
        return cell
    }
    
}
