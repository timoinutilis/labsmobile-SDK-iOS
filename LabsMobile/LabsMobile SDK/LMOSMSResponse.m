//
//  LMOSMSResponse.m
//  LabsMobile
//
//  Created by Timo Kloss on 26/4/16.
//  Copyright © 2016 LabsMobile. All rights reserved.
//

#import "LMOSMSResponse.h"

@implementation LMOSMSResponse

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _code = [dictionary[@"code"] integerValue];
        _message = dictionary[@"message"];
        _subId = dictionary[@"subid"];
    }
    return self;
}

- (BOOL)success
{
    return (self.code == 0);
}

@end
