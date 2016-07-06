//
//  CurrencyViewController.m
//  CargoGuruViper
//
//  Created by a1 on 01.06.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import "CurrencyViewController.h"
#import "CurTableViewCell.h"
#import "ConfigFormat+NSString.h"

enum {
    kRub  = 0,
    kUsd  = 1,
    kEur  = 2,
    kKzt  = 3,
    kCny  = 4
};


static NSString * const kCurCellReuseIdentifier = @"CurCellReuseIdentifier";

@implementation CurrencyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentIndex = INDEX_CURRENCY;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setCustomNavigationBackButton];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *currencies = CURRENCY_NAME;
    return currencies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CurTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCurCellReuseIdentifier forIndexPath:indexPath];
    cell.name = [CURRENCY_NAME objectAtIndex:indexPath.row];
    cell.currencySymbolByName = [NSString printPriceWithCurrencySymbol:[CURRENCY_NAME objectAtIndex:indexPath.row] withLocale:[CURRENCY_LOCALE_NAME objectAtIndex:indexPath.row]];
    
    [[cell selectedIcon] setHidden:YES];
    if (indexPath.row == self.currentIndex) {
        [[cell selectedIcon] setHidden:NO];
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return LocalizedString(@"CURRENCY");
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.currentIndex = indexPath.row;
    [self.tableView reloadData];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@(indexPath.row) forKey:@"currentIndexCurrency"];
    [defaults synchronize];
    
    NSDictionary *userInfo = @{@"indexCurrency":@(indexPath.row)};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeCurrency" object:nil userInfo:userInfo];
}

@end
