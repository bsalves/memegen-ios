//
//  ViewController.swift
//  Meme
//
//  Created by Bruno Alves on 17/10/18.
//  Copyright © 2018 Bruno Alves. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Outlets

    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottonText: UITextField!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var topBar: UIToolbar!
    @IBOutlet weak var bottomBar: UIToolbar!
    
    //MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        topText.addTarget(self, action: #selector(self.unsubscribeFromKeyboardNotifications), for: UIControlEvents.editingDidBegin)
        topText.addTarget(self, action: #selector(self.subscribeToKeyboardNotifications), for: UIControlEvents.editingDidEnd)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    @objc func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillChangeFrame, object: nil)
    }
    
    //MARK: Keybvoard listeners
    
    func keyboardWillShow(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if endFrameY >= UIScreen.main.bounds.size.height {
                view.frame.origin.y = 0
            } else {
                view.frame.origin.y -= getKeyboardHeight(notification)
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
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
    
    //MARK: Actions
    
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
    
}
