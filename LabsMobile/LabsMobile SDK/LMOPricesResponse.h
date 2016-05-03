//
//  LMOPricesResponse.h
//  LabsMobile
//
//  Created by Timo Kloss on 26/4/16.
//  Copyright © 2016 LabsMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMOCountryPrice : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (readonly) NSString *isoCode;
@property (readonly) NSString *prefix;
@property (readonly) NSString *name;
@property (readonly) double credits;

@end


@interface LMOPricesResponse : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (readonly) NSArray <LMOCountryPrice *> *countryPrices;

@end
