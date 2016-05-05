//
//  LMOBalanceQueryResponse.h
//  LabsMobile
//
//  Created by Timo Kloss on 26/4/16.
//  Copyright © 2016 LabsMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 LMOBalanceResponse represents a response from the queryBalance service.
 */
@interface LMOBalanceResponse : NSObject

/**
 Internal initializer. Objects of this class are created by LMOClient.
 
 @param dictionary Dictionary with all values from the server response.
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

/**
 The credit of the account.
 */
@property float messages;

@end
