//
//  LMOPricesResponse.h
//  LabsMobile
//
//  Created by Timo Kloss on 26/4/16.
//  Copyright © 2016 LabsMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 LMOCountryPrice encapsulates all information about one country.
 */
@interface LMOCountryPrice : NSObject

/**
 Internal initializer. Objects of this class are created by LMOClient.
 
 @param dictionary Dictionary with all values from the server response.
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

/**
 The ISO code of the country.
 */
@property (readonly) NSString *isoCode;

/**
 The prefix required for contacting a number in this country.
 */
@property (readonly) NSString *prefix;

/**
 The name of the country.
 */
@property (readonly) NSString *name;

/**
 The price for sending an SMS to this country, using the LabsMobile API.
 */
@property (readonly) float credits;

@end



/**
 LMOPricesResponse represents a response from the queryPrices service.
 */
@interface LMOPricesResponse : NSObject

/**
 Internal initializer. Objects of this class are created by LMOClient.
 
 @param dictionary Dictionary with all values from the server response.
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

/**
 A list of LMOCountryPrice objects.
 */
@property (readonly) NSArray <LMOCountryPrice *> *countryPrices;

@end
