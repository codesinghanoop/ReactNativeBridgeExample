//
//  counter.swift
//  ReactNativeiOSBridge
//
//  Created by Anoop Singh on 3/31/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation


@objc(Counter)

class Counter: NSObject {
  
  @objc
  static var counting = 0;
  
  @objc
  func reset(_ value: NSInteger) {
    Counter.counting = value;
  }
  
  @objc
  func incrementCounter() {
    let count = Counter.counting
    Counter.counting = count + 1;
    print("counter:",count)
  }
  
  @objc
  func decreaseCounter() {
    let count = Counter.counting
    Counter.counting = count - 1;
    print("counter:",count)
  }
  
  @objc
  func getStatus(_ callback: RCTResponseSenderBlock) {
    callback([NSNull(), Counter.counting])
  }
  
  @objc
  static func requiresMainQueueSetup() -> Bool {
    return true
  }
  
}
