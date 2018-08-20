//
//  LangageListViewController.swift
//  TravelerKit
//
//  Created by De knyf Gregory on 16/08/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import UIKit

class LanguageListViewController: UIViewController {
    var translateBrain: TranslateBrain!
}

extension LanguageListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Language.List.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LangageCell", for: indexPath)

        cell.textLabel?.text = Language.List[indexPath.row].name

        return cell
    }
}

extension LanguageListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //New language
        translateBrain.targetLanguage = Language.List[indexPath.row]

        //Close the list
        self.dismiss(animated: true, completion: nil)
    }
}
