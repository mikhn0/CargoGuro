//
//  CurrencyViewController.m
//  CargoGuruViper
//
//  Created by a1 on 01.06.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import "CurrencyViewController.h"
#import "CurTableViewCell.h"

enum {
    kRub  = 0,
    kUsd  = 1,
    kEur  = 2,
    kKzt  = 3,
    kCny  = 4
};


static NSString * const kCurCellReuseIdentifier = @"CurCellReuseIdentifier";

@interface CurrencyViewController ()

@end

@implementation CurrencyViewController

@synthesize currencyName = _currencyName;
@synthesize currencyImageName = _currencyImageName;

- (NSArray *)currencyName {
    return @[@"RUB", @"USD", @"EUR", @"KTZ", @"CNY"];
}

- (NSArray *)currencyLocaleName {
    return @[@"ru", @"en_US", @"EUR", @"KTZ", @"CNY"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CurTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCurCellReuseIdentifier forIndexPath:indexPath];
    cell.currencyName = [self.currencyName objectAtIndex:indexPath.row];
    cell.currencySymbolByName = [self printPriceWithCurrencySymbol:[self.currencyName objectAtIndex:indexPath.row] withLocale:[self.currencyLocaleName objectAtIndex:indexPath.row]];
    if (indexPath.row==kRub) {
        cell.selectedIcon.hidden = NO;
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Валюта";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *userInfo = @{@"indexCurrency":@(indexPath.row)};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeCurrency" object:nil userInfo:userInfo];
}

- (NSString *)printPriceWithCurrencySymbol:(NSString *)currency  withLocale:(NSString *)locale{
    
    NSNumberFormatter * numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setCurrencyCode:currency];
    //[numberFormatter setLocale:[NSLocale localeWithLocaleIdentifier:locale]];
    
    NSString * productPrice = [numberFormatter stringFromNumber:@0];
    
    return productPrice;
    
}

@end
