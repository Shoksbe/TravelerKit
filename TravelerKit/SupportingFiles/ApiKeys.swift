//
//  ApiKeys.swift
//  TravelerKit
//
//  Created by De knyf Gregory on 24/06/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import Foundation

func valueForAPIKey(named keyname: String) -> String {
    let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist")
    let plist = NSDictionary(contentsOfFile: filePath!)
    let value = plist?.object(forKey: keyname) as! String
    return value
}
