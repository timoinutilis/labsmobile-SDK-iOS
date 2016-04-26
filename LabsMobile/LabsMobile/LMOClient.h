//
//  LMOClient.h
//  LabsMobile
//
//  Created by Timo Kloss on 26/4/16.
//  Copyright © 2016 LabsMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LabsMobile/LMOSMSData.h>
#import <LabsMobile/LMOSMSResponse.h>
#import <LabsMobile/LMOBalanceResponse.h>
#import <LabsMobile/LMOPricesResponse.h>

typedef void (^LMOBooleanResultBlock)(BOOL succeeded, NSError *error);
typedef void (^LMOSMSResultBlock)(LMOSMSResponse *response, NSError *error);
typedef void (^LMOBalanceResultBlock)(LMOBalanceResponse *response, NSError *error);
typedef void (^LMOPricesResultBlock)(LMOPricesResponse *response, NSError *error);

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
- (void)sendCodeWithBlock:(LMOBooleanResultBlock)block;

/* Request the verification code to be re-sent to a mobile number. */
- (void)resendCodeWithBlock:(LMOBooleanResultBlock)block;

/* Verify a mobile number by sending the code that has been received. */
- (void)validateCodeWithBlock:(LMOBooleanResultBlock)block;

/* Check whether a mobile number is verified. */
- (void)checkCodeWithBlock:(LMOBooleanResultBlock)block;

@end
