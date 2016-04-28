//
//  ViewController.m
//  LabsMobile Dev App
//
//  Created by Timo Kloss on 26/4/16.
//  Copyright © 2016 LabsMobile. All rights reserved.
//

#import "ViewController.h"
#import <LabsMobile/LabsMobile.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;

@property LMOClient *client;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)onLoginTapped:(id)sender
{
    self.client = [[LMOClient alloc] initWithUsername:self.usernameTextField.text password:self.passwordTextField.text];
}

- (IBAction)onSendSMSTapped:(id)sender
{
    LMOSMSData *smsData = [[LMOSMSData alloc] init];
    smsData.recipients = @[self.phoneNumberTextField.text];
    smsData.message = @"Hello SMS!";
    smsData.test = YES;
    
    [self.client sendSMS:smsData block:^(LMOSMSResponse *response, NSError *error) {
        if (response)
        {
            NSLog(@"response: %@", response.message);
        }
        else
        {
            NSLog(@"error: %@", error.localizedDescription);
        }
    }];
}

- (IBAction)onQueryBalanceTapped:(id)sender
{
    [self.client queryBalanceWithBlock:^(LMOBalanceResponse *response, NSError *error) {
        if (response)
        {
            NSLog(@"messages: %ld", (long)response.messages);
        }
        else
        {
            NSLog(@"error: %@", error.localizedDescription);
        }
    }];
}

- (IBAction)onQueryPricesTapped:(id)sender
{
    [self.client queryPricesWithCountries:@"DE,ES,FR" block:^(LMOPricesResponse *response, NSError *error) {
        if (response)
        {
            NSLog(@"prices");
        }
        else
        {
            NSLog(@"error: %@", error.localizedDescription);
        }
    }];
}
- (IBAction)onOTPSendTapped:(id)sender
{
    [self.client sendCodeForPhoneNumber:self.phoneNumberTextField.text message:@"Your code is %CODE%" sender:@"Test" block:^(BOOL succeeded, NSError *error) {
        if (succeeded)
        {
            NSLog(@"succeeded");
        }
        else
        {
            NSLog(@"error %@", error.localizedDescription);
        }
    }];
}

- (IBAction)onOTPResendTapped:(id)sender
{
    [self.client resendCodeForPhoneNumber:self.phoneNumberTextField.text message:@"Your code again is %CODE%" sender:@"Test" block:^(BOOL succeeded, NSError *error) {
        if (succeeded)
        {
            NSLog(@"succeeded");
        }
        else
        {
            NSLog(@"error %@", error.localizedDescription);
        }
    }];
}

- (IBAction)onOTPValidateTapped:(id)sender
{
    [self.client validateCode:self.codeTextField.text forPhoneNumber:self.phoneNumberTextField.text block:^(BOOL succeeded, NSError *error) {
        if (succeeded)
        {
            NSLog(@"succeeded");
        }
        else
        {
            NSLog(@"error %@", error.localizedDescription);
        }
    }];
}

- (IBAction)onOTPCheckTapped:(id)sender
{
    [self.client checkCodeForPhoneNumber:self.phoneNumberTextField.text block:^(LMOCodeStatus status, NSError *error) {
        if (error)
        {
            NSLog(@"error %@", error.localizedDescription);
        }
        else
        {
            switch (status)
            {
                case LMOCodeStatusUnknown:
                    NSLog(@"unknown");
                    break;
                case LMOCodeStatusPending:
                    NSLog(@"pending");
                    break;
                case LMOCodeStatusValid:
                    NSLog(@"valid");
                    break;
            }
        }
    }];
}

@end
