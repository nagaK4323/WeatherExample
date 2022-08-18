//
//  APIServices.swift
//  WeatherExample
//
//  Created by Naga sashidhar kummara on 8/18/22.
//

import Foundation
import UIKit

enum ErorrType:Error {
    case BadURL
    case NoData
    case DecodingError
}

class APIServices {

    func ApiCall(complation:  @escaping(Result<[CommentsModel]? ,ErorrType>)-> Void){
        
        guard  let request = URL(string: "https://jsonplaceholder.typicode.com/comments")
                 else {
            return complation(.failure(.BadURL))
        }
        let session = URLSession.shared


        let task = session.dataTask(with: request , completionHandler: {data, response, error -> Void in
            guard let  data = data, error == nil  else{
                return complation(.failure(.NoData))
            }
            guard let jsonData = try? JSONDecoder().decode([CommentsModel].self, from: data) else{
                return complation(.failure(.DecodingError))
            }
            return complation(.success(jsonData))
                
         })

         task.resume()
    }
    
}


// MARK: - WebServiceClient
class HTTPClient {
  
  // MARK: - Shared Instance
  static let shared = HTTPClient()
  private var session = URLSession.shared
  
  private init() { }
  
}
typealias Parameters = Dictionary<String, Any?>
// MARK: Public Methods
extension HTTPClient {
  
  func sendRequest(toURL url :URL,
                   method: HTTPMethod,
                   headers: Parameters? = nil,
                   parameters: Parameters? = nil,
                   doShowLoader: Bool = true,
                   encryptedStr: String = "",
                   encryptionkey: String = "",
                   completionHandler: @escaping (Bool, Any?) -> Void) {

    print("HTTPClient: Request URL:     \(url)")
 
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    // Headers
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    if let headers = headers {
      for (key, value) in headers {
        if let value = value as? String {
          request.addValue(value, forHTTPHeaderField: key)
        }
      }
    }

    let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
      DispatchQueue.main.async {
          var statusCode = 200
        if let httpResponse = response as? HTTPURLResponse {
          statusCode = httpResponse.statusCode
        }
        print("BFSHTTPClient: StatusCode: \(statusCode)")
        if let data = data{
            let result = try? JSONSerialization.jsonObject(with: data, options: [])
             
            if result != nil {
//                print(result)
                completionHandler(true,result)
            }else{
                completionHandler(false,nil)
            }
            
        } else {
          completionHandler(false, nil)
        }
        if !(200...299).contains(statusCode) {
          print("Technical Error httpResponse: \(String(describing: url))")
          
        }
      }
    }
    task.resume()
  }
  
}

// MARK: - HTTPMethod
/// HTTPMethod
///  Copyright (c) 2014-2018 Alamofire Software Foundation (http://alamofire.org/)
/// Type representing HTTP methods. Raw `String` value is stored and compared case-sensitively, so
/// `HTTPMethod.get != HTTPMethod(rawValue: "get")`.
///
/// See https://tools.ietf.org/html/rfc7231#section-4.3
struct HTTPMethod: RawRepresentable, Equatable, Hashable {
  /// `CONNECT` method.
  static let connect = HTTPMethod(rawValue: "CONNECT")
  /// `DELETE` method.
  static let delete = HTTPMethod(rawValue: "DELETE")
  /// `GET` method.
  static let get = HTTPMethod(rawValue: "GET")
  /// `HEAD` method.
  static let head = HTTPMethod(rawValue: "HEAD")
  /// `OPTIONS` method.
  static let options = HTTPMethod(rawValue: "OPTIONS")
  /// `PATCH` method.
  static let patch = HTTPMethod(rawValue: "PATCH")
  /// `POST` method.
  static let post = HTTPMethod(rawValue: "POST")
  /// `PUT` method.
  static let put = HTTPMethod(rawValue: "PUT")
  /// `TRACE` method.
  static let trace = HTTPMethod(rawValue: "TRACE")
  
  let rawValue: String
  
  public init(rawValue: String) {
    self.rawValue = rawValue
  }
  
}

extension HTTPClient {
  
  var headers: Parameters {
    return (["Content-Type" :"application/json",
             "Accept" :"application/json"])
  }

}



extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
    
    
}
extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async { /// execute on main thread
                    self.image = UIImage(data: data)
                }
            }
            
            task.resume()
        }
    }
}
