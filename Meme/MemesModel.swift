//
//  MemesModel.swift
//  Meme
//
//  Created by Bruno Alves on 01/12/18.
//  Copyright © 2018 Bruno Alves. All rights reserved.
//

import Foundation

class MemesModel {
    var memes = [Meme]()
    private init () {}
    static var shared = MemesModel()
}
