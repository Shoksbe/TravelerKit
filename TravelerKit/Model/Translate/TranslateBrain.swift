//
//  Translate.swift
//  TravelerKit
//
//  Created by Gregory De knyf on 1/08/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import Foundation

class TranslateBrain {
    
    // MARK: - Properties
    
    var translateText: String? {
        didSet {
            NotificationCenter.default.post(name: .textTranslated, object: nil, userInfo: ["text": translateText!])
        }
    }
    var error: String? {
        didSet {
            NotificationCenter.default.post(name: .errorTranslate, object: nil, userInfo: ["error": error!])
        }
    }
    
    
    // MARK: - Methods
    
    /// Conversion of the text given by the user by connecting the GoogleTranslate API.
    ///
    /// - Parameter text: The text to translate
    func translate(_ text: String) {
        //Get data from Google api
        TranslateService.shared.getTranslation(of: text) { (success, myTranslation) in
            if success, let translateText = myTranslation?.data.translations.first?.translatedText {
                self.translateText = translateText
            } else {
                self.error = "Could not translate text."
            }
        }
    }
}
