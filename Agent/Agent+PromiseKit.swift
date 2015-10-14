//
//  Agent+PromsiseKit.swift
//  Agent+PromsiseKit
//
//  Created by Kevin Farst on 10/14/15.
//  Copyright (c) 2015 Kevin Farst. All rights reserved.
//

import Foundation
import PromiseKit

public class AgentPromiseKit {
  
  public typealias Headers = Dictionary<String, String>
  public typealias Response = (NSHTTPURLResponse?, AnyObject?, NSError?) -> Void
  public typealias RawResponse = (NSHTTPURLResponse?, NSData?, NSError?) -> Void
  
  /**
  * Members
  */
  
  var base: NSURL?
  var headers: Dictionary<String, String>?
  var request: NSMutableURLRequest?
  let queue = NSOperationQueue()
  
  /**
  * Initialize
  */
  
  init(url: String, headers: Dictionary<String, String>?) {
    self.base = NSURL(string: url)
    self.headers = headers
  }
  
  convenience init(url: String) {
    self.init(url: url, headers: nil)
  }
  
  init(method: String, url: String, headers: Dictionary<String, String>?) {
    self.headers = headers
    self.request(method, path: url)
  }
  
  convenience init(method: String, url: String) {
    self.init(method: method, url: url, headers: nil)
  }
  
  /**
  * Request
  */
  
  func request(method: String, path: String) -> AgentPromiseKit {
    var u: NSURL
    if self.base != nil {
      u = self.base!.URLByAppendingPathComponent(path)
    } else {
      u = NSURL(string: path)!
    }
    
    self.request = NSMutableURLRequest(URL: u)
    self.request!.HTTPMethod = method
    
    if self.headers != nil {
      self.request!.allHTTPHeaderFields = self.headers
    }
    
    return self
  }
  
  /**
  * GET
  */
  
  public class func get(url: String) -> AgentPromiseKit {
    return AgentPromiseKit(method: "GET", url: url, headers: nil)
  }
  
  public class func get(url: String, headers: Headers) -> AgentPromiseKit {
    return AgentPromiseKit(method: "GET", url: url, headers: headers)
  }
  
  public class func get(url: String) -> URLDataPromise {
    return AgentPromiseKit.get(url).end()
  }
  
  public class func get(url: String, headers: Headers) -> URLDataPromise {
    return AgentPromiseKit.get(url, headers: headers).end()
  }
  
  public func get(url: String) -> URLDataPromise {
    return self.request("GET", path: url).end()
  }
  
  /**
  * POST
  */
  
  public class func post(url: String) -> AgentPromiseKit {
    return AgentPromiseKit(method: "POST", url: url, headers: nil)
  }
  
  public class func post(url: String, headers: Headers) -> AgentPromiseKit {
    return AgentPromiseKit(method: "POST", url: url, headers: headers)
  }
  
  public class func post(url: String) -> URLDataPromise {
    return AgentPromiseKit.post(url).end()
  }
  
  public class func post(url: String, headers: Headers, data: AnyObject) -> AgentPromiseKit {
    return AgentPromiseKit.post(url, headers: headers).send(data)
  }
  
  public class func post(url: String, data: AnyObject) -> AgentPromiseKit {
    return AgentPromiseKit.post(url).send(data)
  }
  
  public class func post(url: String, data: AnyObject) -> URLDataPromise {
    return AgentPromiseKit.post(url, data: data).send(data).end()
  }
  
  public class func post(url: String, headers: Headers, data: AnyObject) -> URLDataPromise {
    return AgentPromiseKit.post(url, headers: headers, data: data).send(data).end()
  }
  
  public func POST(url: String, data: AnyObject) -> URLDataPromise {
    return self.request("POST", path: url).send(data).end()
  }
  
  /**
  * PUT
  */
  
  public class func put(url: String) -> AgentPromiseKit {
    return AgentPromiseKit(method: "PUT", url: url, headers: nil)
  }
  
  public class func put(url: String, headers: Headers) -> AgentPromiseKit {
    return AgentPromiseKit(method: "PUT", url: url, headers: headers)
  }
  
  public class func put(url: String) -> URLDataPromise {
    return AgentPromiseKit.put(url).end()
  }
  
  public class func put(url: String, headers: Headers, data: AnyObject) -> AgentPromiseKit {
    return AgentPromiseKit.put(url, headers: headers).send(data)
  }
  
  public class func put(url: String, data: AnyObject) -> AgentPromiseKit {
    return AgentPromiseKit.put(url).send(data)
  }
  
  public class func put(url: String, data: AnyObject) -> URLDataPromise {
    return AgentPromiseKit.put(url, data: data).send(data).end()
  }
  
  public class func put(url: String, headers: Headers, data: AnyObject) -> URLDataPromise {
    return AgentPromiseKit.put(url, headers: headers, data: data).send(data).end()
  }
  
  public func PUT(url: String, data: AnyObject) -> URLDataPromise {
    return self.request("PUT", path: url).send(data).end()
  }
  
  /**
  * DELETE
  */
  
  public class func delete(url: String) -> AgentPromiseKit {
    return AgentPromiseKit(method: "DELETE", url: url, headers: nil)
  }
  
  public class func delete(url: String, headers: Headers) -> AgentPromiseKit {
    return AgentPromiseKit(method: "DELETE", url: url, headers: headers)
  }
  
  public class func delete(url: String) -> URLDataPromise {
    return AgentPromiseKit.delete(url).end()
  }
  
  public class func delete(url: String, headers: Headers) -> URLDataPromise {
    return AgentPromiseKit.delete(url, headers: headers).end()
  }
  
  public func delete(url: String) -> URLDataPromise {
    return self.request("DELETE", path: url).end()
  }
  
  /**
  * Methods
  */
  
  public func data(data: NSData?, mime: String) -> AgentPromiseKit {
    self.set("Content-Type", value: mime)
    self.request!.HTTPBody = data
    return self
  }
  
  public func send(data: AnyObject) -> AgentPromiseKit {
    do {
      let json = try NSJSONSerialization.dataWithJSONObject(data, options: NSJSONWritingOptions())
      return self.data(json, mime: "application/json")
    } catch _ {
      return self
    }
  }
  
  public func set(header: String, value: String) -> AgentPromiseKit {
    self.request!.setValue(value, forHTTPHeaderField: header)
    return self
  }
  
  public func end() -> URLDataPromise {
    return NSURLConnection.promise(self.request!)
  }
  
  public func raw() -> URLDataPromise {
    return NSURLConnection.promise(self.request!)
  }
  
}