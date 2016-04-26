//
//  LMOBalanceQueryResponse.h
//  LabsMobile
//
//  Created by Timo Kloss on 26/4/16.
//  Copyright © 2016 LabsMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMOBalanceResponse : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property NSInteger messages;

@end
