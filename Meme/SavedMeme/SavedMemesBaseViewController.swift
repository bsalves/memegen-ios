//
//  SavedMemesBaseViewController.swift
//  Meme
//
//  Created by Bruno Alves on 01/12/18.
//  Copyright © 2018 Bruno Alves. All rights reserved.
//

import UIKit

protocol SavedMemesDelegate: class {
    func createNewMeme()
}

class SavedMemesBaseViewController: UIViewController {
    
    weak var delegate: SavedMemesDelegate?
    
    var memes: [Meme]?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.createNewMeme(sender:)))
    }
    
    @objc func createNewMeme(sender: Any?) {
        delegate?.createNewMeme()
        dismiss(animated: true, completion: nil)
    }
}
