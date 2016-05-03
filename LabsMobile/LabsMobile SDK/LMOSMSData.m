//
//  LMOSMSData.m
//  LabsMobile
//
//  Created by Timo Kloss on 26/4/16.
//  Copyright © 2016 LabsMobile. All rights reserved.
//

#import "LMOSMSData.h"
#import "XMLDictionary.h"

@implementation LMOSMSData

- (NSDictionary *)dictionary
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[XMLDictionaryNodeNameKey] = @"sms";
    
    if (self.recipients)
    {
        NSMutableArray *recipients = [NSMutableArray array];
        for (NSString *recipient in self.recipients)
        {
            [recipients addObject:@{@"msisdn": recipient}];
        }
        dict[@"recipient"] = recipients;
    }
    
    if (self.message)
    {
        dict[@"message"] = self.message;
    }
    if (self.tpoa)
    {
        dict[@"tpoa"] = self.tpoa;
    }
    if (self.subId)
    {
        dict[@"subid"] = self.subId;
    }
    if (self.label)
    {
        dict[@"label"] = self.label;
    }
    if (self.test)
    {
        dict[@"test"] = @1;
    }
    if (self.ackUrl)
    {
        dict[@"ackurl"] = self.ackUrl;
    }
    if (self.shortLink)
    {
        dict[@"shortlink"] = @1;
    }
    if (self.clickUrl)
    {
        dict[@"clickurl"] = self.clickUrl;
    }
    if (self.scheduled)
    {
        dict[@"scheduled"] = [dateFormatter stringFromDate:self.scheduled];
    }
    if (self.longMessage)
    {
        dict[@"long"] = @1;
    }
    if (self.crt)
    {
        dict[@"crt"] = self.crt;
    }
    if (self.ucs2)
    {
        dict[@"ucs2"] = @1;
    }
    if (self.noFilter)
    {
        dict[@"nofilter"] = @1;
    }
    return dict;
}

@end
