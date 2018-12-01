//
//  ViewController.swift
//  Meme
//
//  Created by Bruno Alves on 17/10/18.
//  Copyright © 2018 Bruno Alves. All rights reserved.
//

import UIKit

protocol NewMemeDelegate: class {
    func didFinish(created meme: Meme)
}

class ViewController: UIViewController {
    
    // MARK: Property
    
    weak var delegate: NewMemeDelegate?
    
    //MARK: Outlets

    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottonText: UITextField!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var topBar: UIToolbar!
    @IBOutlet weak var bottomBar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    var memes = [Meme]()
    
    //MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        topText.addTarget(self, action: #selector(self.unsubscribeFromKeyboardNotifications), for: UIControlEvents.editingDidBegin)
        topText.addTarget(self, action: #selector(self.subscribeToKeyboardNotifications), for: UIControlEvents.editingDidEnd)
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        configure(textField: topText, withText: "TOP")
        configure(textField: bottonText, withText: "BOTTOM")
    }
    
    func configure(textField: UITextField, withText text: String) {
        textField.defaultTextAttributes = [
            NSStrokeColorAttributeName: UIColor(named: "TextStrokeColor") ?? "",
            NSForegroundColorAttributeName: UIColor(named: "TextColor") ?? "",
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40) ?? "",
            NSStrokeWidthAttributeName: -4
        ]
        
        textField.delegate = self
        textField.textAlignment = .center
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    //MARK: Keyboard behavior
    
    @objc func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(_ notification: Notification) {
        view.frame.origin.y = -getKeyboardHeight(notification)
    }
    
    func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }

    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: Meme controllers
    
    func generateMemedImage() -> UIImage {
        
        hideTopAndBottomBars(true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        hideTopAndBottomBars(false)
        
        return memedImage
    }
    
    func hideTopAndBottomBars(_ hide: Bool) {
        topBar.isHidden = hide
        bottomBar.isHidden = hide
    }
    
    //MARK: Actions
    
    func presentImagePickerWith(sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func shot(_ sender: Any) {
        presentImagePickerWith(sourceType: .camera)
    }
    
    @IBAction func takeFromAlbum(_ sender: Any) {
        presentImagePickerWith(sourceType: .photoLibrary)
    }
    
    @IBAction func share(_ sender: Any) {
        
        // set up activity view controller
        let imageToShare = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [imageToShare], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        activityViewController.completionWithItemsHandler = { (activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) -> Void in
            if completed {
                guard let originalImage = self.image.image else { return }
                guard let topText = self.topText.text else { return }
                guard let bottonText = self.bottonText.text else { return }
                
                let meme = Meme(topText: topText, bottomText: bottonText, memeImage: imageToShare, originalImage: originalImage)
                
                self.delegate?.didFinish(created: meme)
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func clear() {
        image.image = nil
        topText.text = nil
        bottonText.text = nil
    }
    
    @IBAction func clear(_ sender: Any) {
        clear()
        dismiss(animated: true, completion: nil)
    }
    
}




