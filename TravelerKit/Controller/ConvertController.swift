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
    private var conversionBrain: ConversionBrain!

    // MARK: - Outlets
    @IBOutlet weak var unConvertedAmountTextField: UITextField!
    @IBOutlet weak var convertedAmountTextField: UITextField!

}

// MARK: - Methods
extension ConvertController {
    override func viewDidLoad() {
        super.viewDidLoad()
        conversionBrain = ConversionBrain()
    }

    ///Update the content of the unConvertedamount textfield
    private func updateDisplays() {
        //Unconverted display
        unConvertedAmountTextField.text = conversionBrain.unConvertedAmount

        //Converted display
        convertedAmountTextField.text = conversionBrain.convertedAmount
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
