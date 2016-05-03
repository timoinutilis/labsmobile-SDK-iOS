//
//  PricesTableViewController.m
//  LabsMobile Sample App
//
//  Created by Timo Kloss on 29/4/16.
//  Copyright © 2016 LabsMobile. All rights reserved.
//

#import "PricesTableViewController.h"
#import "PricesResultsTableViewController.h"

@interface PricesTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *countriesTextField;

@end

@implementation PricesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Query"])
    {
        PricesResultsTableViewController *vc = segue.destinationViewController;
        if (self.countriesTextField.text.length > 0)
        {
            vc.countries = self.countriesTextField.text;
        }
    }
}

@end
