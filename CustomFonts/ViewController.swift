//
//  ViewController.swift
//  CustomFonts
//
//  Created by Abdulrahman Qasem on 10/29/19.
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
        if let path = urlTexField.text ,!(path.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ) {
            if let URL = URL(string: path) {
                Downloader.load(URL: URL, successWithName: { (fontName) in
                    self.customFontLabel.font = UIFont(name: fontName, size: 40)
                }) { error in
                    print(error.localizedDescription)
                }
            }
        }else{
            urlTexField.shake()
        }
        
    }
    
    @IBAction func localFont(_ sender: Any) {
        guard let path = Bundle.main.path(forResource: "horrendo", ofType: "ttf") else { return }
        if let URL = URL(string: path) {
            Downloader.load(URL: URL, successWithName: { (fontName) in
                self.customFontLabel.font = UIFont(name: fontName, size: 40)
            }) { error in
                print(error.localizedDescription)
            }
        }
    }
    
  
}

