//
//  ViewController+ImagePicker.swift
//  Meme
//
//  Created by Bruno Alves on 18/10/18.
//  Copyright © 2018 Bruno Alves. All rights reserved.
//

import UIKit

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerEditedImage"] as? UIImage {
            self.image.image = image
        } else if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            self.image.image = image
        } else {
            return
        }
        dismiss(animated: true, completion: nil)
    }
}
