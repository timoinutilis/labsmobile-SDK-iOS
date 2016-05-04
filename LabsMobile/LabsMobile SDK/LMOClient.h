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

/** Validation code status for a phone number. */
typedef NS_ENUM(NSInteger, LMOCodeStatus) {
    /** No validation code was sent to the phone number yet. */
    LMOCodeStatusUnknown,
    /** A code was sent to the phone number, but it's not yet validated. */
    LMOCodeStatusPending,
    /** The phone number was validated. */
    LMOCodeStatusValid
};

typedef void (^LMOBooleanResultBlock)(BOOL succeeded, NSError *error);
typedef void (^LMOSMSResultBlock)(LMOSMSResponse *response, NSError *error);
typedef void (^LMOBalanceResultBlock)(LMOBalanceResponse *response, NSError *error);
typedef void (^LMOPricesResultBlock)(LMOPricesResponse *response, NSError *error);
typedef void (^LMOCodeStatusResultBlock)(LMOCodeStatus status, NSError *error);

extern NSString * const LMOHTTPErrorDomain;


/**
 LMOClient is the main class with methods for all API services.
 */
@interface LMOClient : NSObject

/**
 Initializes an LMOClient object with the specified account.
 
 @param username The LabsMobile username.
 @param password The LabsMobile password.
 
 @return The newly-initialized LabsMobile client.
 */
- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password;

/**
 Initializes an LMOClient object with the specified account and environment.
 
 @param username The LabsMobile username.
 @param password The LabsMobile password.
 @param environment The LabsMobile environment (env). You may specify nil for this parameter.
 
 @return The newly-initialized LabsMobile client.
 */
- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password environment:(NSString *)environment;

/**
 The LabsMobile username this client object was initialized with.
 */
@property (readonly) NSString *username;

/**
 The LabsMobile password this client object was initialized with.
 */
@property (readonly) NSString *password;

/**
 The LabsMobile environment (env) this client object was initialized with (can be nil).
 */
@property (readonly) NSString *environment;

/**************** SMS Service ****************/

/**
 Sends an SMS.
 
 @param smsData The data of the SMS.
 @param block The block to execute when the service responses. It's called in the main thread.
 */
- (void)sendSMS:(LMOSMSData *)smsData block:(LMOSMSResultBlock)block;

/**************** Query Services ****************/

/**
 Queries the balance for the LabsMobile account.
 
 @param block The block to execute when the service responses. It's called in the main thread.
 */
- (void)queryBalanceWithBlock:(LMOBalanceResultBlock)block;

/**
 Queries the prices for sending an SMS to a set of countries.

 @param countries A comma-separated list of ISO country codes. You may specify nil for this parameter to request all countries.
 @param block The block to execute when the service responses. It's called in the main thread.
 */
- (void)queryPricesWithCountries:(NSString *)countries block:(LMOPricesResultBlock)block;

/**************** OTP Services ****************/

/**
 Request a verification code to be send via SMS to a mobile number.
 
 @param phoneNumber The phone number, starting with the country code (without the '+' or '00' symbols).
 @param message The template message for the SMS to be sent. Include '%CODE%' for You may specify nil for this parameter.
 @param sender The sender of the SMS. You may specify nil for this parameter.
 @param block The block to execute when the service responses. It's called in the main thread.
 */
- (void)sendCodeForPhoneNumber:(NSString *)phoneNumber message:(NSString *)message sender:(NSString *)sender block:(LMOBooleanResultBlock)block;

/**
 Request the verification code to be re-sent to a mobile number.
 
 @param phoneNumber The phone number, starting with the country code (without the '+' or '00' symbols).
 @param message The template message for the SMS to be sent. You may specify nil for this parameter.
 @param sender The sender of the SMS. You may specify nil for this parameter.
 @param block The block to execute when the service responses. It's called in the main thread.
 */
- (void)resendCodeForPhoneNumber:(NSString *)phoneNumber message:(NSString *)message sender:(NSString *)sender block:(LMOBooleanResultBlock)block;

/**
 Verify a mobile number by sending the code that has been received.
 
 @param code The code that has been delivered to the phone.
 @param phoneNumber The phone number, starting with the country code (without the '+' or '00' symbols).
 @param block The block to execute when the service responses. It's called in the main thread.
 */
- (void)validateCode:(NSString *)code forPhoneNumber:(NSString *)phoneNumber block:(LMOBooleanResultBlock)block;

/**
 Check whether a mobile number is verified.
 
 @param phoneNumber The phone number, starting with the country code (without the '+' or '00' symbols).
 @param block The block to execute when the service responses. It's called in the main thread.
 */
- (void)checkCodeForPhoneNumber:(NSString *)phoneNumber block:(LMOCodeStatusResultBlock)block;

@end
