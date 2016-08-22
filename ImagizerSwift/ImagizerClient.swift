//
//  ImagizerClient.swift
//  ImagizerSwift
//
//  Created by Nicholas Pettas on 8/16/16.
//

import Foundation

public class ImagizerClient {
    private var host:String
    private var useHttps:Bool = false
    public var autoDpr:Bool = false
    public var dpr:Double = Config.defaultDpr
    public var quality:Int = Config.defaultQuality
    
    public init(host: String) {
        // parse as NSURL to find if a scheme was passed
        // if not scheme was found use default http
        if let url = NSURL(string: host) {
            if url.scheme == "https" {
                self.useHttps = true
            }
            
            self.host = url.absoluteString.stringByReplacingOccurrencesOfString(url.scheme + "://", withString: "")
            
        } else {
            self.host = host
        }
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
        if localParams["dpr"] == nil && dpr != Config.defaultDpr {
            localParams["dpr"] = String(format: "%g", dpr)
        }
        
        if localParams["quality"] == nil && self.quality != Config.defaultQuality {
            localParams["quality"] = self.quality
        }

        if localParams.count > 0 {
            components.queryItems = handleQuery(localParams)
        }
        
        return components.URL!
    }
    
    private func handleQuery(params:[String: AnyObject]) -> [NSURLQueryItem] {
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