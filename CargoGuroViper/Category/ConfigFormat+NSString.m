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

+ (NSAttributedString *)setFontForDecimalPart:(NSString *)string {
    NSRange range = [string rangeOfString:@","];
    range.length = string.length - range.location;
    
    
    NSDictionary *normalAttributes = @{ NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0f]};
    
    NSDictionary *smallAttributes = @{ NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Medium" size:12.0f]};
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:normalAttributes];
    [attributedString setAttributes:smallAttributes range:range];
    
    [attributedString insertAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@", CURRENCY_NAME[INDEX_CURRENCY]]] atIndex:[string length]];
    
    return attributedString;
}
@end
