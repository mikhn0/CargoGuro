//
//  ConfigFormat.m
//  CargoGuruViper
//
//  Created by Виктория on 05.06.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import "ConfigFormat+NSString.h"

@implementation NSString (ConfigFormat)

+ (NSString *)printPriceWithCurrencySymbol:(NSString *)currency  withLocale:(NSString *)locale {
    
    NSLocale *localeCode = [[NSLocale alloc] initWithLocaleIdentifier:locale];
    NSString *currencySymbol = [NSString stringWithFormat:@"%@",[localeCode displayNameForKey:NSLocaleCurrencySymbol value:currency]];
    return currencySymbol;
    
}

+ (NSString *)printCubeOfValue:(NSString *)value {
    NSString *cubedSymbol = @"\u00B3";
    NSString *tenCubed = [NSString stringWithFormat:@"%@%@", value, cubedSymbol];
    return tenCubed;
}

@end
