//
//  Counter.m
//  ReactNativeiOSBridge
//
//  Created by Anoop Singh on 3/31/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"
#import "reactnative-swift-Header.h"

@interface RCT_EXTERN_MODULE(Counter, NSObject)

RCT_EXTERN_METHOD(reset: (NSInteger)value)

RCT_EXTERN_METHOD(incrementCounter)

RCT_EXTERN_METHOD(decreaseCounter)

RCT_EXTERN_METHOD(getStatus: (RCTResponseSenderBlock)callback)

@end


