//
//  LMOSMSResponse.h
//  LabsMobile
//
//  Created by Timo Kloss on 26/4/16.
//  Copyright © 2016 LabsMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 LMOSMSResponse represents a response from the sendSMS service.
 */
@interface LMOSMSResponse : NSObject

/**
 Internal initializer. Objects of this class are created by LMOClient.
 
 @param dictionary Dictionary with all values from the server response.
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

/**
 The custom response code that the server has responded.
 */
@property (readonly) NSInteger code;

/**
 The accompanying message received in the response.
 */
@property (readonly) NSString *message;

/**
 The subId.
 */
@property (readonly) NSString *subId;

/**
 Utility method that checks whether the SMS was sent successfully.
 */
@property (readonly, nonatomic) BOOL success;

@end
