//
//  MemeTextField.swift
//  Meme
//
//  Created by Bruno Alves on 18/10/18.
//  Copyright © 2018 Bruno Alves. All rights reserved.
//
//[
//    NSAttributedStringKey.foregroundColor : UIColor(named: "TextColor"),
//    NSAttributedStringKey.strokeColor : UIColor(named: "TextStrokeColor"),
//    NSAttributedStringKey.strokeWidth: 4,
//    NSAttributedStringKey.font : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)
//]

import UIKit

class MemeTextField: UITextField {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        defaultTextAttributes = [
            NSStrokeColorAttributeName: UIColor(named: "TextStrokeColor") ?? "",
            NSForegroundColorAttributeName: UIColor(named: "TextColor") ?? "",
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40) ?? "",
            NSStrokeWidthAttributeName: -4
        ]
        
        attributedPlaceholder = NSAttributedString(string: placeholder!, attributes: [
            NSStrokeColorAttributeName: UIColor(named: "TextStrokeColor") ?? "",
            NSForegroundColorAttributeName: UIColor(named: "TextColor") ?? "",
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40) ?? "",
            NSStrokeWidthAttributeName: -4
        ])
        
        self.textAlignment = .center
        
    }
}
