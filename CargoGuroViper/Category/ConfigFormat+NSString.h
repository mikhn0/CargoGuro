//
//  ConfigFormat.h
//  CargoGuruViper
//
//  Created by Виктория on 05.06.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ConfigFormat)

+ (NSString *)printPriceWithCurrencySymbol:(NSString *)currency  withLocale:(NSString *)locale;
+ (NSString *)printCubeOfValue:(NSString *)value;

@end