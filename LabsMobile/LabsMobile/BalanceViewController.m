//
//  BalanceViewController.m
//  LabsMobile Sample App
//
//  Created by Timo Kloss on 29/4/16.
//  Copyright © 2016 LabsMobile. All rights reserved.
//

#import "BalanceViewController.h"
#import "LabsMobile.h"
#import "AppDelegate.h"

@interface BalanceViewController ()

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@end

@implementation BalanceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    LMOClient *labsMobileClient = ((AppDelegate *)[UIApplication sharedApplication].delegate).labsMobileClient;
    
    [labsMobileClient queryBalanceWithBlock:^(LMOBalanceResponse *response, NSError *error) {
        if (error)
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Could Not Query Balance" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            self.numberLabel.text = @(response.messages).stringValue;
        }
    }];
}

@end
