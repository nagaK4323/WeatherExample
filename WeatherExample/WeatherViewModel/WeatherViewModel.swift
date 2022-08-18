//
//  WeatherViewModel.swift
//  WeatherExample
//
//  Created by Naga sashidhar kummara on 8/18/22.
//

import Foundation
import UIKit

class WeatherViewModel {

    var userLocation: UserLocation? {
        didSet {
            DispatchQueue.main.async {
                self.vc?.tb.reloadData()
            }
        }
    }
    weak var vc:ViewController?
    
    func sumbit(urlStr:String,inputStr:String?){
        if let inputStr = inputStr,
           inputStr != ""{
            if Connectivity.isConnectedToInternet{
                print("Having network")
                getDataFromUrl(urlStr: urlStr ,queryStr: inputStr)
            }else{
                print("No network")
            }
            
        }else{
            print("query is empty")
        }
        
    }
    
    func getDataFromUrl(urlStr:String,queryStr:String){
        let params = [ "access_key":Constant.shared.access_key,"query":queryStr
        ]
        guard let url = URL(string: urlStr) else{return}
        var components = URLComponents(url:url, resolvingAgainstBaseURL: true)
        components?.queryItems = params.map { (key, value) in
                URLQueryItem(name: key, value: value)
            }
        if let components = components ,
           let convertUrl = components.url{
            HTTPClient.shared.sendRequest(toURL: convertUrl, method: .get) { status, result in
                if status == true {
                    if let result = result {
                        let decoder = JSONDecoder()
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: result)
                            let model =  try decoder.decode(UserLocation.self , from: jsonData)
                            self.userLocation = model
   
                        }catch{
                            print(error)
                            print(error.localizedDescription)
                            self.userLocation = nil
                            
                        }
                    }
                }else{
                }
            }
        }else{
            print("url is invalid")
        }

    }
    
    func numberRows()-> Int{
        if let _ = self.userLocation {
            return 1
        }
        return 0
        
    }
    func heightRow()-> CGFloat{
        if let _ = self.userLocation {
            return 110
        }
        return 0.0
    }
}
