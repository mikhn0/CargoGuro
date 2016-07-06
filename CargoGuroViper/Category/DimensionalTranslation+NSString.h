//
//  DimensionalTranslation+CGFloat.h
//  CargoGuruViper
//
//  Created by Виктория on 05.07.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DimensionalTranslation)

+ (NSString *)transferVolume:(NSString *)value From:(NSString *)startDem to:(NSString *)endDem;
+ (NSString *)transferWeight:(NSString *)value From:(NSString *)startDem to:(NSString *)endDem;

@end
