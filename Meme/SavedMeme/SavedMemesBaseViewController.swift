//
//  SavedMemesBaseViewController.swift
//  Meme
//
//  Created by Bruno Alves on 01/12/18.
//  Copyright © 2018 Bruno Alves. All rights reserved.
//

import UIKit

class SavedMemesBaseViewController: UIViewController {
    
    var selectedMeme: Meme?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.createNewMeme(sender:)))
    }
    
    @objc func createNewMeme(sender: Any?) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "NewMeme") as! ViewController
        newViewController.delegate = self
        self.present(newViewController, animated: true, completion: nil)
    }
}

extension SavedMemesBaseViewController: NewMemeDelegate {
    func didFinish(created meme: Meme) {
        MemesModel.shared.memes.append(meme)
    }
}
