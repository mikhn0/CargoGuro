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

+ (NSAttributedString *)setFontForDecimalPartInTopView:(NSString *)string demention:(NSString *)demention isCurrency:(BOOL)isCurrency {
    
    NSDictionary *normalAttributes = @{ NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Medium" size:12.0f]};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:normalAttributes];
    NSRange range = [string rangeOfString:@","];
    if (range.length != 0) {
        range.length = string.length - range.location;
        if (isCurrency) {
            range.length -= 1;
            range.location += 1;
            NSString *string1 = [string substringWithRange:range];
            NSRange rangeDecimal = NSMakeRange(0, 2);
            NSString *string2 = [string1 substringWithRange:rangeDecimal];
            NSString *newText = [string stringByReplacingCharactersInRange:range withString:string2];
            string = newText;
            attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:normalAttributes];
            range.location -= 1;
            range.length = string.length - range.location;
        }
        
        NSDictionary *smallAttributes = @{ NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Medium" size:9.0f]};
        [attributedString setAttributes:smallAttributes range:range];
    } else {
        range = [string rangeOfString:@"."];
        if (range.length != 0) {
            range.length = string.length - range.location;
            if (isCurrency) {
                range.length -= 1;
                range.location += 1;
                NSString *string1 = [string substringWithRange:range];
                NSRange rangeDecimal = NSMakeRange(0, 2);
                NSString *string2 = [string1 substringWithRange:rangeDecimal];
                NSString *newText = [string stringByReplacingCharactersInRange:range withString:string2];
                string = newText;
                attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:normalAttributes];
                range.location -= 1;
                range.length = string.length - range.location;
            }
            
            NSDictionary *smallAttributes = @{ NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Medium" size:9.0f]};
            [attributedString setAttributes:smallAttributes range:range];
        }
    }
    
    
    [attributedString insertAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@", demention]] atIndex:[string length]];
    
    return attributedString;
}

+ (NSAttributedString *)setFontForDecimalVWInTopView:(NSString *)string demention:(NSString *)demention isCurrency:(BOOL)isCurrency {
    
    NSDictionary *normalAttributes = @{ NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Medium" size:12.0f]};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:normalAttributes];
    NSRange range = [string rangeOfString:@","];
    if (range.length != 0) {
        range.length = string.length - range.location;
        if (isCurrency) {
            range.length -= 1;
            range.location += 1;
            NSString *string1 = [string substringWithRange:range];
            NSRange rangeDecimal = NSMakeRange(0, 6);
            NSString *string2 = [string1 substringWithRange:rangeDecimal];
            NSString *newText = [string stringByReplacingCharactersInRange:range withString:string2];
            string = newText;
            attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:normalAttributes];
            range.location -= 1;
            range.length = string.length - range.location;
        }
        
        NSDictionary *smallAttributes = @{ NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Medium" size:9.0f]};
        [attributedString setAttributes:smallAttributes range:range];
    } else {
        range = [string rangeOfString:@"."];
        if (range.length != 0) {
            range.length = string.length - range.location;
            if (isCurrency) {
                range.length -= 1;
                range.location += 1;
                NSString *string1 = [string substringWithRange:range];
                NSRange rangeDecimal = NSMakeRange(0, 6);
                NSString *string2 = [string1 substringWithRange:rangeDecimal];
                NSString *newText = [string stringByReplacingCharactersInRange:range withString:string2];
                string = newText;
                attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:normalAttributes];
                range.location -= 1;
                range.length = string.length - range.location;
            }
            
            NSDictionary *smallAttributes = @{ NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Medium" size:9.0f]};
            [attributedString setAttributes:smallAttributes range:range];
        }
    }
    
    
    [attributedString insertAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@", demention]] atIndex:[string length]];
    
    return attributedString;
}

@end
