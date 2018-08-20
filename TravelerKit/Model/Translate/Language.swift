//
//  LanguageSupported.swift
//  TravelerKit
//
//  Created by De knyf Gregory on 16/08/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import Foundation

struct Language {
    let name: String
    let initial: String

    static let List =
        [
            Language(name: "French", initial: "fr"),
            Language(name: "Deutsch", initial: "de"),
            Language(name: "Engels", initial: "en"),
            Language(name: "Arabisch", initial: "ar"),
            Language(name: "Spanish", initial: "es"),
            Language(name: "Italian", initial: "it"),
            Language(name: "Portuguese", initial: "pt"),
            Language(name: "Russian", initial: "ru")
        ]
}
