//
//  ViewController.swift
//  CustomFonts
//
//  Created by Trum Gyorgy on 12/1/15.
//  Copyright (c) 2015 General Electric. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var customFontLabel: UILabel!
    @IBOutlet weak var urlTexField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customFontLabel.text = "Hello World"
    }
    
    
    
    @IBAction func pushNewFontButton(sender: AnyObject) {
        var url = "http://webpagepublicity.com/free-fonts/x/Xephyr%20Condensed.ttf"
        if !(urlTexField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true ) {
            url = urlTexField.text!
        }
        if let URL = URL(string: url) {
            Downloader.load(URL: URL, successWithName: { (fontName) in
                self.customFontLabel.font = UIFont(name: fontName, size: 20.0)
            }) {
                print("Faliure")
            }
        }
    }
    
  
}

