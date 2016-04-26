//
//  LMOClient.m
//  LabsMobile
//
//  Created by Timo Kloss on 26/4/16.
//  Copyright © 2016 LabsMobile. All rights reserved.
//

#import "LMOClient.h"
#import "XMLDictionary.h"

typedef void (^LMOResultBlock)(NSDictionary *response, NSError *error);

NSString * const LMOHTTPErrorDomain = @"com.labsmobile.error.http";

@interface LMOClient()
@property NSURLSession *session;
@property NSURL *baseURL;
@end

@implementation LMOClient

- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password
{
    return [self initWithUsername:username password:password environment:nil];
}

- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password environment:(NSString *)environment
{
    if (self = [super init])
    {
        _username = username;
        _password = password;
        _environment = environment;
        
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        _baseURL = [NSURL URLWithString:@"https://api.labsmobile.com/"];
    }
    return self;
}

- (void)sendSMS:(LMOSMSData *)smsData block:(LMOSMSResultBlock)block
{
    NSDictionary *parameters = [smsData dictionary];
    [self requestWithPath:@"get/send.php" parameters:parameters block:^(NSDictionary *response, NSError *error) {
        if (response)
        {
            LMOSMSResponse *responseModel = [[LMOSMSResponse alloc] initWithDictionary:response];
            block(responseModel, nil);
        }
        else
        {
            block(nil, error);
        }
    }];
}

- (void)queryBalanceWithBlock:(LMOBalanceResultBlock)block
{
    [self requestWithPath:@"get/balance.php" parameters:nil block:^(NSDictionary *response, NSError *error) {
        if (response)
        {
            LMOBalanceResponse *responseModel = [[LMOBalanceResponse alloc] initWithDictionary:response];
            block(responseModel, nil);
        }
        else
        {
            block(nil, error);
        }
    }];
}

- (void)queryPricesWithCountries:(NSString *)countries block:(LMOPricesResultBlock)block
{
    NSDictionary *parameters = @{@"countries": countries,
                                 @"format": @"XML"};
    
    [self requestWithPath:@"get/prices.php" parameters:parameters block:^(NSDictionary *response, NSError *error) {
        if (response)
        {
            LMOPricesResponse *responseModel = [[LMOPricesResponse alloc] initWithDictionary:response];
            block(responseModel, nil);
        }
        else
        {
            block(nil, error);
        }
    }];
}

- (void)sendCodeWithBlock:(LMOBooleanResultBlock)block
{
}

- (void)resendCodeWithBlock:(LMOBooleanResultBlock)block
{
}

- (void)validateCodeWithBlock:(LMOBooleanResultBlock)block
{
}

- (void)checkCodeWithBlock:(LMOBooleanResultBlock)block
{
}



- (void)requestWithPath:(NSString *)path parameters:(NSDictionary *)parameters block:(LMOResultBlock)block;
{
    NSMutableDictionary *finalParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    finalParameters[@"username"] = self.username;
    finalParameters[@"password"] = self.password;
    if (self.environment)
    {
        finalParameters[@"env"] = self.environment;
    }
    
    NSString *query = [self stringWithParameters:finalParameters];
    path = [NSString stringWithFormat:@"%@?%@", path, query];
    
    NSLog(@"request: %@", path);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:path relativeToURL:self.baseURL]];
    
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                block(nil, error);
            });
        }
        else
        {
            NSInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
            NSLog(@"status: %ld", (long)statusCode);
            if (statusCode >= 200 && statusCode <= 299)
            {
                NSString *xmlString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"response: %@", xmlString);
                
                NSDictionary *xmlData = [NSDictionary dictionaryWithXMLData:data];
                dispatch_async(dispatch_get_main_queue(), ^{
                    block(xmlData, nil);
                });
            }
            else
            {
                NSError *statusError = [NSError errorWithDomain:LMOHTTPErrorDomain code:statusCode userInfo:@{NSLocalizedDescriptionKey: [NSHTTPURLResponse localizedStringForStatusCode:statusCode]}];
                dispatch_async(dispatch_get_main_queue(), ^{
                    block(nil, statusError);
                });
            }
        }
    }];
    [task resume];
}

- (NSString *)stringWithParameters:(NSDictionary *)parameters
{
    NSMutableArray *couples = [NSMutableArray array];
    for (NSString *key in parameters.allKeys)
    {
        id value = parameters[key];
        NSString *escapedKey = [key stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSString *escapedValue = nil;
        if ([value isKindOfClass:[NSString class]])
        {
            escapedValue = [((NSString *)value) stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        }
        else if ([value isKindOfClass:[NSNumber class]])
        {
            escapedValue = [((NSNumber *)value) stringValue];
        }
        [couples addObject:[NSString stringWithFormat:@"%@=%@", escapedKey, escapedValue]];
    }
    return [couples componentsJoinedByString:@"&"];
}

@end
