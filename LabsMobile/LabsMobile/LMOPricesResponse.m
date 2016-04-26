//
//  LMOPricesResponse.m
//  LabsMobile
//
//  Created by Timo Kloss on 26/4/16.
//  Copyright © 2016 LabsMobile. All rights reserved.
//

#import "LMOPricesResponse.h"

@implementation LMOCountryPrice

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _isoCode = dictionary[@"isocode"];
        _prefix = dictionary[@"prefix"];
        _name = dictionary[@"name"];
        _credits = [dictionary[@"credits"] doubleValue];
    }
    return self;
}

@end


@implementation LMOPricesResponse

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        NSMutableArray *countryPrices = [NSMutableArray array];
        NSArray *countries = dictionary[@"country"];
        for (NSDictionary *country in countries)
        {
            [countryPrices addObject:[[LMOCountryPrice alloc] initWithDictionary:country]];
        }
        _countryPrices = countryPrices;
    }
    return self;
}

@end
