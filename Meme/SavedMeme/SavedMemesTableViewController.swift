//
//  SavedMemesTableViewController.swift
//  Meme
//
//  Created by Bruno Alves on 01/12/18.
//  Copyright © 2018 Bruno Alves. All rights reserved.
//

import UIKit

class SavedMemesTableViewController: SavedMemesBaseViewController {

    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Lyfecicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

extension SavedMemesTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "meme") as! SavedMemeTableViewCell
        
        if let memes = self.memes {
            let item = memes[indexPath.row]
            cell.memeImage.image = item.memeImage
            cell.title.text = "\(item.topText) \(item.bottomText)"
            return cell
        }
        return UITableViewCell()
    }
    
}
