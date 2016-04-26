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

@property LMOClient *client;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.client = [[LMOClient alloc] initWithUsername:@"username" password:@"password"];
}

- (IBAction)onSendSMSTapped:(id)sender
{
    LMOSMSData *smsData = [[LMOSMSData alloc] init];
    smsData.msisdn = @"34123456789";
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

@end
