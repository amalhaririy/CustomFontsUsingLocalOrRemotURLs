//
//  Downloader.swift
//  CustomFonts
//
//  Created by Trum Gyorgy on 12/1/15.
//  Copyright (c) 2015 General Electric. All rights reserved.
//

import Foundation
import CoreGraphics
import CoreText
import UIKit
import Alamofire


class Downloader {
    class func load(URL: URL , successWithName:@escaping (String)->Void , failure:@escaping ()->Void) {
        Alamofire.request(URL, method: .get, parameters: nil).responseData { (response) in
            switch response.result {
            case .success(let data):
                
                let dataProvider = CGDataProvider(data: data as CFData)
                let cgFont = CGFont(dataProvider! )
                
                var error: Unmanaged<CFError>?
                if !CTFontManagerRegisterGraphicsFont(cgFont!, &error)
                {
                    print("Error loading Font!")
                    failure()
                } else {
                    successWithName((cgFont!).postScriptName! as String)
                }
                
            case .failure(let err):
                print("Faulure: %@", err.localizedDescription)
                failure()
            }
          
        }
    }
}
