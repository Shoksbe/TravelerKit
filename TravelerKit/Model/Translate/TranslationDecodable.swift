//
//  TranslationDecodable.swift
//  TravelerKit
//
//  Created by Gregory De knyf on 1/08/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import Foundation

//Structure use for parse data from api
struct TranslationDecodable: Decodable {
    struct Data: Decodable {
        struct Translation: Decodable {
            let translatedText: String
            let detectedSourceLanguage: String
        }
        let translations: [Translation]
    }
    let data: Data
}
