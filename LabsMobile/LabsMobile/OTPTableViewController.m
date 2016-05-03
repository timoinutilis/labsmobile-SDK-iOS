//
//  OTPTableViewController.m
//  LabsMobile Sample App
//
//  Created by Timo Kloss on 29/4/16.
//  Copyright © 2016 LabsMobile. All rights reserved.
//

#import "OTPTableViewController.h"
#import "LabsMobile.h"
#import "AppDelegate.h"

typedef NS_ENUM(NSInteger, State) {
    StateNotChecked,
    StateUnknown,
    StatePending,
};

typedef NS_ENUM(NSInteger, CellTag) {
    CellTagNoAction,
    CellTagCheck,
    CellTagSend,
    CellTagValidate,
    CellTagResend
};

@interface OTPTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITableViewCell *actionCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *action2Cell;

@property (nonatomic) State state;

@end

@implementation OTPTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.state = StateNotChecked;
}

- (void)setState:(State)state
{
    _state = state;
    self.action2Cell.tag = CellTagNoAction;
    switch (state)
    {
        case StateNotChecked:
            self.actionCell.textLabel.text = @"Check";
            self.actionCell.tag = CellTagCheck;
            break;
        case StateUnknown:
            self.actionCell.textLabel.text = @"Send Code";
            self.actionCell.tag = CellTagSend;
            break;
        case StatePending:
            self.actionCell.textLabel.text = @"Validate Code";
            self.actionCell.tag = CellTagValidate;
            self.action2Cell.textLabel.text = @"Resend Code";
            self.action2Cell.tag = CellTagResend;
            break;
    }
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    LMOClient *labsMobileClient = ((AppDelegate *)[UIApplication sharedApplication].delegate).labsMobileClient;
    
    switch ((CellTag)cell.tag)
    {
        case CellTagCheck: {
            [labsMobileClient checkCodeForPhoneNumber:self.phoneNumberTextField.text block:^(LMOCodeStatus status, NSError *error) {
                if (error)
                {
                    [self showAlertWithError:error];
                }
                else
                {
                    switch (status)
                    {
                        case LMOCodeStatusUnknown:
                            [self showAlertWithTitle:@"No Code Sent Yet"];
                            self.state = StateUnknown;
                            break;
                        case LMOCodeStatusPending:
                            [self showAlertWithTitle:@"Code Pending"];
                            self.state = StatePending;
                            break;
                        case LMOCodeStatusValid:
                            [self showAlertWithTitle:@"Phone Number Validated"];
                            // back to first state to try again
                            self.state = StateNotChecked;
                            break;
                    }
                }
            }];
            break;
        }
        case CellTagSend: {
            [labsMobileClient sendCodeForPhoneNumber:self.phoneNumberTextField.text message:nil sender:nil block:^(BOOL succeeded, NSError *error) {
                if (succeeded)
                {
                    [self showAlertWithTitle:@"Code Sent"];
                    self.state = StatePending;
                }
                else
                {
                    [self showAlertWithError:error];
                }
            }];
            break;
        }
        case CellTagValidate: {
            [labsMobileClient validateCode:self.codeTextField.text forPhoneNumber:self.phoneNumberTextField.text block:^(BOOL succeeded, NSError *error) {
                if (error)
                {
                    [self showAlertWithError:error];
                }
                else if (succeeded)
                {
                    [self showAlertWithTitle:@"Phone Number Validated"];
                    self.state = StateNotChecked;
                }
                else
                {
                    [self showAlertWithTitle:@"Code Invalid"];
                }
            }];
            break;
        }
        case CellTagResend: {
            [labsMobileClient resendCodeForPhoneNumber:self.phoneNumberTextField.text message:nil sender:nil block:^(BOOL succeeded, NSError *error) {
                if (succeeded)
                {
                    [self showAlertWithTitle:@"Code Resent"];
                }
                else
                {
                    [self showAlertWithError:error];
                }
            }];
            break;
        }
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)showAlertWithTitle:(NSString *)title
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showAlertWithError:(NSError *)error
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Something Went Wrong" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // show or hide "Code" section
    return (self.state == StatePending) ? 3 : 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return 1;
        case 1:
            // one or two available actions
            return (self.state == StatePending) ? 2 : 1;
        case 2:
            return 1;
    }
    return 0;
}

@end
