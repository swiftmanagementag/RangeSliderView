//
//  ViewController.swift
//  RangeSliderView Example
//
//  Created by Omar Abdelhafith on 07/02/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import RangeSliderView
import UIKit

class ViewController: UIViewController {
    @IBOutlet var maximumValueLabel: UILabel!
    @IBOutlet var minimumValueLabel: UILabel!

    @IBAction func valueChanged(sender: UIControl) {
        guard let sender = sender as? RangeSliderView else { return }

        minimumValueLabel.text = "\(sender.minimumSelectedValue)"
        maximumValueLabel.text = "\(sender.maximumSelectedValue)"
    }
}
