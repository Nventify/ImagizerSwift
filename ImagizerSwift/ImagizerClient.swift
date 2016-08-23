//
//  ImagizerClient.swift
//  ImagizerSwift
//
//  Created by Nicholas Pettas on 8/16/16.
//

import Foundation

public class ImagizerClient {
    private static let defaultQuality = 90
    private static let defaultDpr = 1.0
    
    private var host:String
    private var useHttps:Bool = false
    public var autoDpr:Bool = false
    public var dpr:Double = defaultDpr
    public var quality:Int = defaultQuality
    
    public init(host: String) {
        self.host = host
    }
    
    public init(host: String, useHttps: Bool) {
        self.host = host
        self.useHttps = useHttps
    }
    
    public func buildUrl(path:String, params: [String: AnyObject]) -> NSURL {
        let components = NSURLComponents.init()
        
        var localParams = params
        components.scheme = useHttps ? "https" : "http"
        components.host = self.host
        components.path = self.cleanPath(path)
        
        // determine the device pixel ratio
        // by default Imagizer uses 1, so no need to pass 1
        let dpr = (self.getScreenMultiplier())
        if localParams["dpr"] == nil && dpr != ImagizerClient.defaultDpr {
            localParams["dpr"] = String(format: "%g", dpr)
        }
        
        if localParams["quality"] == nil && self.quality != ImagizerClient.defaultQuality {
            localParams["quality"] = self.quality
        }

        if localParams.count > 0 {
            components.queryItems = handleQuery(localParams)
        }
        
        return components.URL!
    }
    
    private func cleanPath(path: String) -> String {
        var path = path
        
        if !path.hasPrefix("/") {
            path = "/" + path
        }
        
        return path
    }
    
    private func handleQuery(params:[String: AnyObject]) -> [NSURLQueryItem] {
        var urlParams = params.map { NSURLQueryItem(name:$0, value:String($1))}
        
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