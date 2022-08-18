//
//  NetworkConnectivity.swift
//  WeatherExample
//
//  Created by Naga sashidhar kummara on 8/18/22.
//

import Foundation

// MARK :- Network checking
struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()
    static var isConnectedToInternet:Bool {
        if let status = self.sharedInstance?.isReachable {
            return status
        }
        return false
    }
}
