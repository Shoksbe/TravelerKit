//
//  LangageTableViewController.swift
//  TravelerKit
//
//  Created by De knyf Gregory on 13/08/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import UIKit

class LangageTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "langageCell", for: indexPath)

        cell.textLabel?.text = "Francais"

        return cell
        
    }

}
