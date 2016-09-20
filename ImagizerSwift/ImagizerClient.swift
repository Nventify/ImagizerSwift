//
//  ImagizerClient.swift
//  ImagizerSwift
//
//  Created by Nicholas Pettas on 8/16/16.
//

import Foundation
#if os(OSX)
import AppKit
#else
import UIKit
#endif
import SystemConfiguration

@objc open class ImagizerClient: NSObject {
    fileprivate static let defaultQuality = 90
    fileprivate static let defaultDpr = 1.0
    fileprivate static let defaultImagizerHost = "demo.imagizercdn.com";
    
    open var host:String
    open var useHttps:Bool = false
    open var autoDpr:Bool = false
    open var dpr:Double = defaultDpr
    open var quality:Int = defaultQuality
    open var originImageHost:String?
    
    public override init() {
        self.host = ImagizerClient.defaultImagizerHost
    }
    
    public init(host: String) {
        self.host = host
    }
    
    public init(host: String, useHttps: Bool) {
        self.host = host
        self.useHttps = useHttps
    }
    
    open func buildUrl(_ path:String) -> URL {
        return self.buildUrl(path, params: [:])
    }
    
    open func buildUrl(_ path:String, params: NSDictionary) -> URL {
        var components = URLComponents.init()
        let localParams: NSMutableDictionary = NSMutableDictionary.init(dictionary: params)

        components.scheme = useHttps ? "https" : "http"
        components.host = self.host
        components.path = self.cleanPath(path)
        
        if originImageHost != nil {
            localParams["hostname"] = originImageHost
        }
        
        // determine the device pixel ratio
        // by default Imagizer uses 1, so no need to pass 1
        if localParams["dpr"] == nil {
            let dpr = (self.getScreenMultiplier())
            if dpr != ImagizerClient.defaultDpr {
                localParams["dpr"] = String(format: "%g", dpr)
            }
        }
        
        if localParams["quality"] == nil && self.quality != ImagizerClient.defaultQuality {
            localParams["quality"] = self.quality
        }

        if localParams.count > 0 {
            components.queryItems = self.handleQuery(localParams)
        }
        
        return components.url!
    }
    
    fileprivate func cleanPath(_ path: String) -> String {
        var path = path
        
        if !path.hasPrefix("/") {
            path = "/" + path
        }
        
        return path
    }
    
    fileprivate func handleQuery(_ params:NSDictionary) -> [URLQueryItem] {
        var urlParams = params.map { URLQueryItem(name:String(describing: $0), value:String(describing: $1))}
        
        // sort array to ensure consistence results
        // for caching on imagizer and unit tests
        urlParams.sort{ $0.name < $1.name }
        
        return urlParams
    }
    
    fileprivate func getScreenMultiplier() -> Double {
        var dpr =  self.dpr
        
        if self.autoDpr {
            #if os(OSX)
                if let screen = NSScreen.main() {
                    dpr = Double(screen.backingScaleFactor)
                }
            #elseif os(iOS)
                dpr = Double(UIScreen.main.scale)
            #endif
        }
        
        return dpr
    }
}
