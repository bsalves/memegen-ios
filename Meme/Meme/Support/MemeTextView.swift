//
//  MemeTextView.swift
//  Meme
//
//  Created by Bruno Alves on 18/10/18.
//  Copyright © 2018 Bruno Alves. All rights reserved.
//

import UIKit

@IBDesignable
class MemeTextView: UITextField {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        //Set text attributted for self
        let textAttributes: [CFString:Any] = [
            kCTForegroundColorAttributeName: UIColor(named: "TextColor"),
            kCTStrokeColorAttributeName: UIColor(named: "TextStrokeColor"),
            kCTFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40) ?? "",
            kCTStrokeWidthAttributeName: 4
        ]
        
        self.defaultTextAttributes = textAttributes as [String : Any]
    }

}
