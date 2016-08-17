//
//  ImagizerClient.swift
//  ImagizerSwift
//
//  Created by Nicholas Pettas on 8/16/16.
//  Copyright © 2016 Nicholas Pettas. All rights reserved.
//

import Foundation

public class ImagizerClient {
    public var host:String
    private var useHttps:Bool
    private var autoDpr:Bool
    
    public init(host: String) {
        self.host = host
        self.useHttps = false
        self.autoDpr = true
    }
    
    public init(host: String, useHttps:Bool) {
        self.host = host
        self.useHttps = useHttps
        self.autoDpr = true
    }
    
    public init(host: String, autoDpr:Bool) {
        self.host = host
        self.autoDpr = autoDpr
        self.useHttps = false
    }
    
    public init(host: String, useHttps:Bool, autoDpr:Bool) {
        self.host = host
        self.useHttps = useHttps
        self.autoDpr = autoDpr
    }
    
    public func makeUrl(path:String, params: [String: String]) -> NSURL {
        let components = NSURLComponents.init()
        
        var localParams = params
        components.scheme = useHttps ? "https" : "http"
        components.host = self.host
        components.path = path
        
        if localParams["dpr"] == nil {
            localParams["dpr"] = String(getScreenMultiplier())
        }

        if localParams.count > 0 {
            components.queryItems = handleQuery(localParams)
        }
        
        return components.URL!
    }
    
    func handleQuery(params:[String: String]) -> [NSURLQueryItem] {
        var urlParams = [NSURLQueryItem]()
        
        for (name, value) in params {
            urlParams.append(NSURLQueryItem(name: name, value: value))
        }
        
        return urlParams
    }
    
    public func getScreenMultiplier() -> Int {
        return Int(UIScreen.mainScreen().scale)
    }
}