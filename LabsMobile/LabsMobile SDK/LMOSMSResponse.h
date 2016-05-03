//
//  LMOSMSResponse.h
//  LabsMobile
//
//  Created by Timo Kloss on 26/4/16.
//  Copyright © 2016 LabsMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMOSMSResponse : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (readonly) NSInteger code;
@property (readonly) NSString *message;
@property (readonly) NSString *subId;

@end
