//
//  SendSMSTableViewController.m
//  LabsMobile Sample App
//
//  Created by Timo Kloss on 29/4/16.
//  Copyright © 2016 LabsMobile. All rights reserved.
//

#import "SendSMSTableViewController.h"
#import "LabsMobile.h"
#import "AppDelegate.h"

@interface SendSMSTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;

@property BOOL optionTest;
@property BOOL optionUnicode;
@property BOOL optionLong;

@end

@implementation SendSMSTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2)
    {
        BOOL selected = NO;
        switch (indexPath.row)
        {
            case 0:
                self.optionTest = !self.optionTest;
                selected = self.optionTest;
                break;
            case 1:
                self.optionUnicode = !self.optionUnicode;
                selected = self.optionUnicode;
                break;
            case 2:
                self.optionLong = !self.optionLong;
                selected = self.optionLong;
                break;
        }
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = selected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    }
    else if (indexPath.section == 3)
    {
        // Prepare the SMS for sending
        LMOSMSData *smsData = [[LMOSMSData alloc] init];
        smsData.recipients = @[self.phoneNumberTextField.text];
        smsData.message = self.messageTextField.text;
        smsData.test = self.optionTest;
        smsData.ucs2 = self.optionUnicode;
        smsData.longMessage = self.optionLong;
        
        // Get the global LabsMobile client instance
        LMOClient *labsMobileClient = ((AppDelegate *)[UIApplication sharedApplication].delegate).labsMobileClient;
        
        // Send the SMS
        [labsMobileClient sendSMS:smsData block:^(LMOSMSResponse *response, NSError *error) {
            if (error)
            {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Could Not Send Message" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alert animated:YES completion:nil];
            }
            else
            {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:response.message message:nil preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
