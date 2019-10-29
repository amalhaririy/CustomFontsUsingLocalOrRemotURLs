//
//  Downloader.swift
//  CustomFonts
//
//  Created by Abdulrahman Qasem on 10/29/19.

//

import Foundation
import Alamofire
enum fontError:String ,Error {
    case loadingError
    case dataProviderError
    
    var localizedDescription: String {
        switch self {
        case .loadingError:
            return "Loading error"
        case .dataProviderError:
            return "Data provider error"
       
        }
    }
}

class Downloader {
    
    class func load(URL: URL , successWithName:@escaping (String)->Void , failure:@escaping (Error)->Void) {
        if URL.absoluteString.first == "/" { //  local paths
            guard let data = NSData(contentsOfFile: URL.absoluteString) else { return  }
            let dataProvider = CGDataProvider(data: data )
             self.registerFont(dataProvider: dataProvider, successWithName: successWithName, failure: failure)
            return
        }
        
        Alamofire.request(URL, method: .get, parameters: nil).responseData { (response) in //  local paths
            switch response.result {
            case .success(let data):
                 let dataProvider = CGDataProvider(data: data as CFData)
                self.registerFont(dataProvider: dataProvider, successWithName: successWithName, failure: failure)
                
                
            case .failure(let err):
                print("Faulure: %@", err.localizedDescription)
                failure(err)
            }
          
        }
    }
    
    
    private class func registerFont(dataProvider: CGDataProvider? ,successWithName:@escaping (String)->Void , failure:@escaping (Error)->Void)  {
        
        guard let data = dataProvider , let cgFont = CGFont(data)else {
            failure(fontError.dataProviderError)
            return
        }
        
        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(cgFont, &error)
        {
            print("Error loading Font!")
            //failure(fontError.loadingError) // font already exit **or** there is font with thw same name **or** registration failed
            successWithName(cgFont.postScriptName as String? ?? "")
        } else {
           // CTFontManagerRegisterGraphicsFont(cgFont, &error)
            successWithName(cgFont.postScriptName as String? ?? "")
        }
    }
}
