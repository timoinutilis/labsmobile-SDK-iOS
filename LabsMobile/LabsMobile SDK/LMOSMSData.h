//
//  LMOSMSData.h
//  LabsMobile
//
//  Created by Timo Kloss on 26/4/16.
//  Copyright © 2016 LabsMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 LMOSMSData encapsulates all data related to an SMS that can be sent using the LabsMobile API.
 */
@interface LMOSMSData : NSObject

/**
 Internal method used by LMOClient.
 */
- (NSDictionary *)dictionary;

/**
 The recipient(s) of the SMS as an array of phone numbers, starting with the country code (without the '+' or '00' symbols).
 */
@property NSArray <NSString *> *recipients;

/**
 The text of the SMS.
 */
@property NSString *message;

/**
 The sender of the SMS.
 */
@property NSString *tpoa;

/**
 Message identifier to be used for the ACKs.
 */
@property NSString *subId;

/**
 A label, that can be used for statistics purposes.
 */
@property NSString *label;

/**
 Whether the SMS should be sent in test mode.
 */
@property BOOL test;

/**
 The URL where the ACK notifications will be sent to.
 */
@property NSString *ackUrl;

/**
 Toggle the short link functionality (see the API docs for more details).
 */
@property BOOL shortLink;

/**
 The click URL.
 */
@property NSString *clickUrl;

/**
 The Date in which to send the SMS (for scheduled messages).
 */
@property NSDate *scheduled;

/**
 Signals that the message is a long message, that should be sent as a multi-message SMS.
 */
@property BOOL longMessage;

/**
 Whether to set this SMS as a certified SMS.
 */
@property NSString *crt;

/**
 Whether the SMS message uses the UCS-2.
 */
@property BOOL ucs2;

/**
 Whether to ignore the filter that blocks sending duplicate SMS.
 */
@property BOOL noFilter;

@end
