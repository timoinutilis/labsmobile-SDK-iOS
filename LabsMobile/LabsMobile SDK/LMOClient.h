//
//  LMOClient.h
//  LabsMobile
//
//  Created by Timo Kloss on 26/4/16.
//  Copyright © 2016 LabsMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMOSMSData.h"
#import "LMOSMSResponse.h"
#import "LMOBalanceResponse.h"
#import "LMOPricesResponse.h"

typedef NS_ENUM(NSInteger, LMOCodeStatus) {
    LMOCodeStatusUnknown,
    LMOCodeStatusPending,
    LMOCodeStatusValid
};

typedef void (^LMOBooleanResultBlock)(BOOL succeeded, NSError *error);
typedef void (^LMOSMSResultBlock)(LMOSMSResponse *response, NSError *error);
typedef void (^LMOBalanceResultBlock)(LMOBalanceResponse *response, NSError *error);
typedef void (^LMOPricesResultBlock)(LMOPricesResponse *response, NSError *error);
typedef void (^LMOCodeStatusResultBlock)(LMOCodeStatus status, NSError *error);

extern NSString * const LMOHTTPErrorDomain;


@interface LMOClient : NSObject

/* */
- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password;

/* */
- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password environment:(NSString *)environment;

@property (readonly) NSString *username;
@property (readonly) NSString *password;
@property (readonly) NSString *environment;


/* Sends an SMS. */
- (void)sendSMS:(LMOSMSData *)smsData block:(LMOSMSResultBlock)block;



/* Queries the balance for the LabsMobile account. */
- (void)queryBalanceWithBlock:(LMOBalanceResultBlock)block;

/* Queries the prices for sending an SMS to a set of countries. */
- (void)queryPricesWithCountries:(NSString *)countries block:(LMOPricesResultBlock)block;



/* Request a verification code to be send via SMS to a mobile number. */
- (void)sendCodeForPhoneNumber:(NSString *)phoneNumber message:(NSString *)message sender:(NSString *)sender block:(LMOBooleanResultBlock)block;

/* Request the verification code to be re-sent to a mobile number. */
- (void)resendCodeForPhoneNumber:(NSString *)phoneNumber message:(NSString *)message sender:(NSString *)sender block:(LMOBooleanResultBlock)block;

/* Verify a mobile number by sending the code that has been received. */
- (void)validateCode:(NSString *)code forPhoneNumber:(NSString *)phoneNumber block:(LMOBooleanResultBlock)block;

/* Check whether a mobile number is verified. */
- (void)checkCodeForPhoneNumber:(NSString *)phoneNumber block:(LMOCodeStatusResultBlock)block;

@end
