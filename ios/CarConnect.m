//
//  CarConnect.m
//  CarConnect
//
//  Created by Jeffrey Mendez on 9/22/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"
#import "React/RCTEventEmitter.h"

@interface RCT_EXTERN_MODULE(CarConnect, RCTEventEmitter)
  RCT_EXTERN_METHOD(start:(BOOL *)background)
  RCT_EXTERN_METHOD(stop:(BOOL *)background)
  RCT_EXTERN_METHOD(connect)
  RCT_EXTERN_METHOD(disconnect)
@end
