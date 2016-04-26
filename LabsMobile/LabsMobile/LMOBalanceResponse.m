//
//  LMOBalanceQueryResponse.m
//  LabsMobile
//
//  Created by Timo Kloss on 26/4/16.
//  Copyright © 2016 LabsMobile. All rights reserved.
//

#import "LMOBalanceResponse.h"

@implementation LMOBalanceResponse

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _messages = [dictionary[@"messages"] integerValue];
    }
    return self;
}

@end
