//
//  PricesResultsTableViewController.m
//  LabsMobile Sample App
//
//  Created by Timo Kloss on 29/4/16.
//  Copyright © 2016 LabsMobile. All rights reserved.
//

#import "PricesResultsTableViewController.h"
#import "LabsMobile.h"
#import "AppDelegate.h"

@interface PricesResultsTableViewController ()

@property NSArray <LMOCountryPrice *> *countryPrices;

@end

@implementation PricesResultsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.countries ? self.countries : @"All Countries";
    
    LMOClient *labsMobileClient = ((AppDelegate *)[UIApplication sharedApplication].delegate).labsMobileClient;
    
    [labsMobileClient queryPricesWithCountries:self.countries block:^(LMOPricesResponse *response, NSError *error) {
        if (error)
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Could Not Query Prices" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            self.countryPrices = response.countryPrices;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.countryPrices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Price" forIndexPath:indexPath];
    LMOCountryPrice *countryPrice = self.countryPrices[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)", countryPrice.name, countryPrice.prefix];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.3f", countryPrice.credits];
    return cell;
}

@end
