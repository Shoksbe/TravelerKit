//
//  TranslateViewController.swift
//  TravelerKit
//
//  Created by Gregory De knyf on 20/07/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import UIKit

// -MARK: Properties
class TranslateViewController: UIViewController {
    
    var myTranslating: TranslateBrain!
    
    @IBOutlet weak var toBeTranslatedTextView: UITextView!
    @IBOutlet weak var translatedTextView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
}

// -MARK: Methods
extension TranslateViewController {
    
    override func viewDidLoad() {
        //Observe notification
        NotificationCenter.default.addObserver(self, selector: #selector(showAlertError(_:)), name: .errorTranslate, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(textTranslated(_:)), name: .textTranslated, object: nil)
        
        //Gesture to remove keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        myTranslating = TranslateBrain()
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        getTranslation()
    }
    
    //When text is translated, this function is called by the NotificationObserver
    @objc func textTranslated(_ notification: Notification) {
        guard let translateText = notification.userInfo?["text"] as? String else { return }
        
        //Hide the activity indicator
        activityIndicator.isHidden = true
        
        //Adding translated text to the translation view
        translatedTextView.text = translateText
    }
    
    func getTranslation() {
        //Show activity indicator
        activityIndicator.isHidden = false
        //Translation of user entered text
        myTranslating.translate(toBeTranslatedTextView.text)
    }
    
    ///Displays errors
    @objc private func showAlertError(_ notification: Notification) {
        guard let message = notification.userInfo?["error"] as? String else { return }
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}

// -MARK: Textview
extension TranslateViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //When return button did tap
        if(text == "\n") {
            //Remove keyboard
            textView.resignFirstResponder()
            getTranslation()
            return false
        }
        return true
    }
}
