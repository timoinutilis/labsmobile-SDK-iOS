//
//  LMOClient.m
//  LabsMobile
//
//  Created by Timo Kloss on 26/4/16.
//  Copyright © 2016 LabsMobile. All rights reserved.
//

#import "LMOClient.h"
#import "XMLDictionary.h"

typedef void (^LMOResultBlock)(id response, NSError *error);

NSString * const LMOHTTPErrorDomain = @"com.labsmobile.error.http";

@interface LMOClient()
@property NSURLSession *session;
@property NSURL *baseURL;
@property XMLDictionaryParser *xmlDictionaryParser;
@end

@implementation LMOClient

/**************** Initialize ****************/

- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password
{
    return [self initWithUsername:username password:password environment:nil];
}

- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password environment:(NSString *)environment
{
    if (self = [super init])
    {
        NSParameterAssert(username);
        NSParameterAssert(password);
        
        _username = username;
        _password = password;
        _environment = environment;
        
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        _baseURL = [NSURL URLWithString:@"https://api.labsmobile.com/"];
        _xmlDictionaryParser = [[XMLDictionaryParser alloc] init];
    }
    return self;
}

/**************** SMS Service ****************/

- (void)sendSMS:(LMOSMSData *)smsData block:(LMOSMSResultBlock)block
{
    NSParameterAssert(smsData);
    NSParameterAssert(block);
    
    NSDictionary *parameters = [smsData dictionary];
    NSString *xml = [parameters XMLString];
    NSDictionary *body = @{@"XmlData": xml};
    [self requestWithPath:@"clients/" parameters:nil post:YES basicAuth:YES body:body xmlResponse:YES block:^(id response, NSError *error) {
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

/**************** Query Services ****************/

- (void)queryBalanceWithBlock:(LMOBalanceResultBlock)block
{
    NSParameterAssert(block);
    
    [self requestWithPath:@"get/balance.php" parameters:nil post:NO basicAuth:NO body:nil xmlResponse:YES block:^(id response, NSError *error) {
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
    NSParameterAssert(block);
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"format"] = @"XML";
    if (countries)
    {
        parameters[@"countries"] = countries;
    }
    
    [self requestWithPath:@"get/prices.php" parameters:parameters post:NO basicAuth:NO body:nil xmlResponse:YES block:^(id response, NSError *error) {
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

/**************** OTP Services ****************/

- (void)sendCodeForPhoneNumber:(NSString *)phoneNumber message:(NSString *)message sender:(NSString *)sender block:(LMOBooleanResultBlock)block
{
    NSParameterAssert(phoneNumber);
    NSParameterAssert(block);
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"phone_number"] = phoneNumber;
    if (message)
    {
        parameters[@"message"] = message;
    }
    if (sender)
    {
        parameters[@"sender"] = sender;
    }
    
    [self requestWithPath:@"otp/sendCode" parameters:parameters post:NO basicAuth:YES body:nil xmlResponse:NO block:^(id response, NSError *error) {
        if (response)
        {
            if ([response isEqualToString:@"1"])
            {
                block(YES, nil);
            }
            else
            {
                block(NO, nil);
            }
        }
        else
        {
            block(NO, error);
        }
    }];
}

- (void)resendCodeForPhoneNumber:(NSString *)phoneNumber message:(NSString *)message sender:(NSString *)sender block:(LMOBooleanResultBlock)block
{
    NSParameterAssert(phoneNumber);
    NSParameterAssert(block);
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"phone_number"] = phoneNumber;
    if (message)
    {
        parameters[@"message"] = message;
    }
    if (sender)
    {
        parameters[@"sender"] = sender;
    }
    
    [self requestWithPath:@"otp/resendCode" parameters:parameters post:NO basicAuth:YES body:nil xmlResponse:NO block:^(id response, NSError *error) {
        if (response)
        {
            if ([response isEqualToString:@"1"])
            {
                block(YES, nil);
            }
            else
            {
                block(NO, nil);
            }
        }
        else
        {
            block(NO, error);
        }
    }];
}

- (void)validateCode:(NSString *)code forPhoneNumber:(NSString *)phoneNumber block:(LMOBooleanResultBlock)block
{
    NSParameterAssert(code);
    NSParameterAssert(phoneNumber);
    NSParameterAssert(block);
    
    NSDictionary *parameters = @{@"phone_number": phoneNumber,
                                 @"code": code};
    
    [self requestWithPath:@"otp/validateCode" parameters:parameters post:NO basicAuth:YES body:nil xmlResponse:NO block:^(id response, NSError *error) {
        if (response)
        {
            if ([response isEqualToString:@"1"])
            {
                block(YES, nil);
            }
            else
            {
                block(NO, nil);
            }
        }
        else
        {
            block(NO, error);
        }
    }];
}

- (void)checkCodeForPhoneNumber:(NSString *)phoneNumber block:(LMOCodeStatusResultBlock)block
{
    NSParameterAssert(phoneNumber);
    NSParameterAssert(block);
    
    NSDictionary *parameters = @{@"phone_number": phoneNumber};
    
    [self requestWithPath:@"otp/checkCode" parameters:parameters post:NO basicAuth:YES body:nil xmlResponse:NO block:^(id response, NSError *error) {
        if (response)
        {
            if ([response isEqualToString:@"1"])
            {
                block(LMOCodeStatusValid, nil);
            }
            else if ([response isEqualToString:@"0"])
            {
                block(LMOCodeStatusPending, nil);
            }
            else
            {
                block(LMOCodeStatusUnknown, nil);
            }
        }
        else
        {
            block(LMOCodeStatusUnknown, error);
        }
    }];
}

/**************** Private Methods ****************/

/**
 Make an HTTP request for the LabsMobile API.
 
 @param path The service path relative to the LabsMobile base URL.
 @param parameters A dictionary with query parameters.
 @param post YES for a POST request, NO for GET.
 @param basicAuth YES for HTTP basic auth, NO for URL parameter auth.
 @param body Data for the HTTP body (for POST requests). Dictionary will be encoded like URL parameters.
 @param xmlResponse YES if the expected server response is in XML format, NO for plain text.
 @param block The block to execute when the service responses. It's called in the main thread.
 
 */
- (void)requestWithPath:(NSString *)path parameters:(NSDictionary *)parameters post:(BOOL)post basicAuth:(BOOL)basicAuth body:(NSDictionary *)body xmlResponse:(BOOL)xmlResponse block:(LMOResultBlock)block;
{
    NSMutableDictionary *finalParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    if (!basicAuth)
    {
        // URL auth
        finalParameters[@"username"] = self.username;
        finalParameters[@"password"] = self.password;
    }
    if (self.environment)
    {
        // optional environment
        finalParameters[@"env"] = self.environment;
    }
    
    // add query parameters to path
    NSString *query = [self stringWithParameters:finalParameters];
    path = [NSString stringWithFormat:@"%@?%@", path, query];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path relativeToURL:self.baseURL]];
    
    if (basicAuth)
    {
        // HTTP headers for basic auth
        NSString *auth = [NSString stringWithFormat:@"%@:%@", self.username, self.password];
        NSData *authData = [auth dataUsingEncoding:NSUTF8StringEncoding];
        NSString *encodedAuth = [authData base64EncodedStringWithOptions:0];
        [request addValue:[NSString stringWithFormat:@"Basic %@", encodedAuth] forHTTPHeaderField:@"Authorization"];
    }

    if (post)
    {
        request.HTTPMethod = @"POST";
        if (body)
        {
            // optional HTTP body
            NSString *encodedBody = [self stringWithParameters:body];
            request.HTTPBody = [encodedBody dataUsingEncoding:NSUTF8StringEncoding];
        }
    }
    
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            // standard NSURLSessionDataTask error
            dispatch_async(dispatch_get_main_queue(), ^{
                block(nil, error);
            });
        }
        else
        {
            NSInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
            if (statusCode >= 200 && statusCode <= 299)
            {
                // success
                id decodedResponse;
                if (xmlResponse)
                {
                    decodedResponse = [self.xmlDictionaryParser dictionaryWithData:data];
                }
                else
                {
                    decodedResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    block(decodedResponse, nil);
                });
            }
            else
            {
                // HTTP error
                NSError *statusError = [NSError errorWithDomain:LMOHTTPErrorDomain code:statusCode userInfo:@{NSLocalizedDescriptionKey: [NSHTTPURLResponse localizedStringForStatusCode:statusCode]}];
                dispatch_async(dispatch_get_main_queue(), ^{
                    block(nil, statusError);
                });
            }
        }
    }];
    [task resume];
}

/**
 Encode as URL query parameters.
 
 @param parameters Dictionary with parameters.
 */
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
