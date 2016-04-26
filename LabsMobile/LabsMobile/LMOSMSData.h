//
//  LMOSMSData.h
//  LabsMobile
//
//  Created by Timo Kloss on 26/4/16.
//  Copyright © 2016 LabsMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMOSMSData : NSObject

- (NSDictionary *)dictionary;

@property NSString *msisdn;
@property NSString *message;
@property NSString *sender;
@property NSString *subId;
@property NSString *label;
@property BOOL test;
@property NSString *ackUrl;
@property BOOL shortLink;
@property NSString *clickUrl;
@property NSDate *scheduled;
@property BOOL longMessage;
@property NSString *crt;
@property BOOL ucs2;
@property BOOL noFilter;

@end
