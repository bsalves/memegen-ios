//
//  ViewController.swift
//  Meme
//
//  Created by Bruno Alves on 17/10/18.
//  Copyright © 2018 Bruno Alves. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottonText: UITextField!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var topBar: UIToolbar!
    @IBOutlet weak var bottomBar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func generateMemedImage() -> UIImage {
        
        hideBars()
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        showBars()
        
        return memedImage
    }
    
    private func hideBars() {
        topBar.isHidden = true
        bottomBar.isHidden = true
    }
    
    private func showBars() {
        topBar.isHidden = false
        bottomBar.isHidden = false
    }
    
    @IBAction func shot(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let imagePicker =  UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Erro!", message: "Não foi possível iniciar a camera do seu dispositivo.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func takeFromAlbum(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func share(_ sender: Any) {
        
        // set up activity view controller
        let imageToShare = [ generateMemedImage() ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func clear(_ sender: Any) {
        image.image = nil
        topText.text = nil
        bottonText.text = nil
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
