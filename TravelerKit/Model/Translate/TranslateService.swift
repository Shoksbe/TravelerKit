//
//  TranslateService.swift
//  TravelerKit
//
//  Created by Gregory De knyf on 1/08/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import Foundation

class TranslateService {
    
    static let shared = TranslateService()
    private init() {}
    
    private var task: URLSessionDataTask?
    private var session = URLSession(configuration: .default)
    init(session: URLSession) {
        self.session = session
    }

    private let translateUrl = URL(string: "https://translation.googleapis.com/language/translate/v2")!
    
    let apiKey = valueForAPIKey(named: "API_CLIENT_GOOGLE")
    
    func getTranslation(of text: String,to language: String, callback: @escaping (Bool, String?)-> ()) {

        //Create request
        var request = URLRequest(url: translateUrl)
        request.httpMethod = "POST"

        //add the body of the request
        let body = "q=\(text)&target=\(language)&key=\(apiKey)"
        request.httpBody = body.data(using: .utf8)

        //Stop the current task if there is one so that you do not run multiple tasks at the same time
        task?.cancel()

        //Create new task
        task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {

                guard let data = data, error == nil,
                    let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        callback(false, nil)
                        return
                }

                guard let responseJSON = try? JSONDecoder().decode(TranslationDecodable.self, from: data),
                let translation = responseJSON.data.translations.first?.translatedText else {
                        callback(false, nil)
                        return
                }

                callback(true, translation)
            }
        }
        //Launch task
        task?.resume()
    }
}
