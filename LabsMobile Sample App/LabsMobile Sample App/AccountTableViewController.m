//
//  AccountTableViewController.m
//  LabsMobile Sample App
//
//  Created by Timo Kloss on 2/5/16.
//  Copyright © 2016 LabsMobile. All rights reserved.
//

#import "AccountTableViewController.h"
#import <LabsMobile/LabsMobile.h>
#import "AppDelegate.h"

@interface AccountTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *environmentTextField;

@end

@implementation AccountTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Start"])
    {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        if (self.environmentTextField.text.length > 0)
        {
            appDelegate.labsMobileClient = [[LMOClient alloc] initWithUsername:self.usernameTextField.text
                                                                      password:self.passwordTextField.text
                                                                   environment:self.environmentTextField.text];
        }
        else
        {
            appDelegate.labsMobileClient = [[LMOClient alloc] initWithUsername:self.usernameTextField.text
                                                                      password:self.passwordTextField.text];
        }
    }
}

@end
