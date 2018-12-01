//
//  SavedMemeViewController.swift
//  Meme
//
//  Created by Bruno Alves on 01/12/18.
//  Copyright © 2018 Bruno Alves. All rights reserved.
//

import UIKit

class SavedMemeViewController: UIViewController {

    // MARK: Meme property
    
    var meme: Meme?
    
    // MARK: Outlet
    
    @IBOutlet weak var memeImage: UIImageView!
    
    // MARK: Lyfecicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memeImage.image = meme?.memeImage
    }
}
