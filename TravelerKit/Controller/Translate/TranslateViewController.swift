//
//  TranslateViewController.swift
//  TravelerKit
//
//  Created by Gregory De knyf on 20/07/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import UIKit

// MARK: - Properties
class TranslateViewController: UIViewController {
    
    var translateBrain: TranslateBrain!
    
    @IBOutlet weak var toBeTranslatedTextView: UITextView!
    @IBOutlet weak var translatedTextView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var targetLanguageButton: UIButton!
    @IBOutlet weak var targetLanguageLabel: UILabel!

}

// MARK: - ViewLifeCycle
extension TranslateViewController {

    //Launch one time
    override func viewDidLoad() {
        //Gesture to remove keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    //Launch each time when view appear
    override func viewWillAppear(_ animated: Bool) {
        getTranslation()
        updateTargetLanguage()
    }
}

// MARK: - Methods
extension TranslateViewController {
    
    private func getTranslation() {
        //Show activity indicator
        activityIndicator.isHidden = false

        //Abreviation of target language
        let targetLanguage = TranslateBrain.targetLanguage.initial

        //Get data from Google api
        TranslateService.shared.getTranslation(of: toBeTranslatedTextView.text, to: targetLanguage)
        { (success, translatedText) in

            //Hide activity indicator
            self.activityIndicator.isHidden = true

            if success, let translatedText = translatedText {
                //Adding translated text to the translation view
                self.translatedTextView.text = translatedText
            } else {
                //Show alert with error
                self.showAlertError()
            }
        }
    }

    private func updateTargetLanguage() {
        //The name of the target language used
        let targetLanguageName = TranslateBrain.targetLanguage.name

        //Set the button title with target language
        targetLanguageButton.setTitle(targetLanguageName, for: .normal)

        //Set the language text label in target language textview
        targetLanguageLabel.text = targetLanguageName
    }

    @objc private func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        getTranslation()
    }
    
    private func showAlertError() {
        let alert = UIAlertController(title: "Error", message: "Could not translate text.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}

// MARK: - TextviewDelegate 
extension TranslateViewController: UITextViewDelegate {
    
    //Dismiss keyboarg and get traduction when return button did tap
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
