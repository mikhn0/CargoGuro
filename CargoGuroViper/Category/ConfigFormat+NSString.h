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
+ (NSAttributedString *)setFontForDecimalPart:(NSString *)string;
+ (NSAttributedString *)setFontForDecimalPartInTopView:(NSString *)string demention:(NSString *)demention isCurrency:(BOOL)isCurrency ;
+ (NSAttributedString *)setFontForDecimalVWInTopView:(NSString *)string demention:(NSString *)demention isCurrency:(BOOL)isCurrency;

@end
