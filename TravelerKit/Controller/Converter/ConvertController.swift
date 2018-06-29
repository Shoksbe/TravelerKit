//
//  ViewController.swift
//  TravelerKit
//
//  Created by De knyf Gregory on 23/06/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import UIKit

class ConvertController: UIViewController {
    // MARK: - Properties
    private var conversionBrain = ConversionBrain()

    // MARK: - Outlets
    @IBOutlet weak var unConvertedAmountTextField: UITextField!
    @IBOutlet weak var convertedAmountTextField: UITextField!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

}

// MARK: - Methods
extension ConvertController {
    override func viewDidLoad() {
        super.viewDidLoad()

        //Observe notification
        NotificationCenter.default.addObserver(self, selector: #selector(showAlertError(_:)), name: .errorCurrency, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: .currencyLoaded, object: nil)

    }

    ///Update the content of the unConvertedamount textfield
    private func updateDisplays() {
        //Unconverted display
        unConvertedAmountTextField.text = conversionBrain.unConvertedAmount

        //Converted display
        convertedAmountTextField.text = conversionBrain.convertedAmount
    }

    @objc private func showAlertError(_ notification: Notification) {
        guard let message = notification.userInfo?["error"] as? String else { return }

        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    ///Reload the data cars they do not load at the launching of the application because of the request Json
    @objc private func reloadData() {
        collectionView.reloadData()
        collectionView.layoutIfNeeded()

        // MARK: Find a better solution to do that
        for cell in collectionView.visibleCells as! [RateCollectionViewCell] {
            if let currency = cell.rateLabel.text, currency == "USD" {
                cell.isSelected = true
            }
        }
    }

    /// Change the currency used
    ///
    /// - Parameter newCurrency: the new currency to be used
    private func changeCurrency(to newCurrency: String) {
        currencyLabel.text = newCurrency
        conversionBrain.changeTargetCurrency(to: newCurrency)
        updateDisplays()
    }
}

// MARK: - Actions
extension ConvertController {
    @IBAction func didPressedKeyboardButton(_ sender: UIButton) {
        guard let buttonValue = sender.titleLabel?.text else { return }

        switch buttonValue {
        case "0","1","2","3","4","5","6","7","8","9":
            conversionBrain.addNumber(buttonValue)
        case ".":
            conversionBrain.addComma()
        case "del":
            conversionBrain.resetToZero()
        default:
            return
        }
        updateDisplays()
    }
}

// MARK: - UICollectionView
extension ConvertController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return conversionBrain.ratesName.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellRate", for: indexPath) as! RateCollectionViewCell
        cell.rateLabel.text = conversionBrain.ratesName[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        // MARK: Find a better solution to do that
        for cell in collectionView.visibleCells as! [RateCollectionViewCell] {
            if let currency = cell.rateLabel.text, currency == "USD" {
                cell.isSelected = false
            }
        }

        //Get the new currency data
        let cell = collectionView.cellForItem(at: indexPath)! as! RateCollectionViewCell
        guard let newCurrency = cell.rateLabel.text else { return }

        //Change currency
        changeCurrency(to: newCurrency)
    }
}
