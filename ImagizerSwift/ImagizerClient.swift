//
//  ImagizerClient.swift
//  ImagizerSwift
//
//  Created by Nicholas Pettas on 8/16/16.
//

import Foundation

public class ImagizerClient {
    public var host:String
    public var useHttps:Bool
    public var autoDpr:Bool = false
    public var dpr:Double = 1

    public init(host: String) {
        self.host = host
        self.useHttps = false
    }
    
    public init(host: String, useHttps:Bool) {
        self.host = host
        self.useHttps = useHttps
    }
    
    public func buildUrl(path:String, params: [String: AnyObject]) -> NSURL {
        let components = NSURLComponents.init()
        
        var localParams = params
        components.scheme = useHttps ? "https" : "http"
        components.host = self.host
        components.path = path
        
        // determine the device pixel ratio
        // by default Imagizer uses 1, so no need to pass 1
        let dpr = (self.getScreenMultiplier())
        if dpr != 1 {
            localParams["dpr"] = String(format: "%g", dpr)
        }

        if localParams.count > 0 {
            components.queryItems = handleQuery(localParams)
        }
        
        return components.URL!
    }
    
    func handleQuery(params:[String: AnyObject]) -> [NSURLQueryItem] {
        var urlParams = [NSURLQueryItem]()
        
        for (name, value) in params {
            urlParams.append(NSURLQueryItem(name: name, value: String(value)))
        }
        
        // sort array to ensure consistence results
        // for caching on imagizer and unit tests
        urlParams.sortInPlace{ $0.name < $1.name }
        
        return urlParams
    }
    
    private func getScreenMultiplier() -> Double {
        var dpr =  self.dpr
        
        if self.autoDpr {
            dpr = Double(UIScreen.mainScreen().scale)
        }
        
        return dpr
    }
}