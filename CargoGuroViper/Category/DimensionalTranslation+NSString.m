//
//  DimensionalTranslation+CGFloat.m
//  CargoGuruViper
//
//  Created by Виктория on 05.07.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import "DimensionalTranslation+NSString.h"

@implementation NSString (DimensionalTranslation)

+ (NSString *)transferVolume:(NSString *)value From:(NSString *)startDem to:(NSString *)endDem {
    NSString *transferVolume = value;
    CGFloat volume = [value floatValue];
    
    if ([startDem isEqualToString:VOLUME_NAME[0]]) { //m^3
        if ([endDem isEqualToString:VOLUME_NAME[1]]) { //cm^3
            
            volume = [value floatValue] * 1000000;
            transferVolume = [NSString stringWithFormat:@"%.0f", volume];
            
        } else if ([endDem isEqualToString:VOLUME_NAME[2]]) { //l
            
            volume = [value floatValue] * 1000;
            transferVolume = [NSString stringWithFormat:@"%.0f", volume];
            
        }
    } else if ([startDem isEqualToString:VOLUME_NAME[1]]) {
        if ([endDem isEqualToString:VOLUME_NAME[0]]) {
            
            volume = [value floatValue] / 1000000;
            transferVolume = [NSString stringWithFormat:@"%.6f", volume];
            
        } else if ([endDem isEqualToString:VOLUME_NAME[2]]) {
            
            volume = [value floatValue] / 1000;
            transferVolume = [NSString stringWithFormat:@"%.3f", volume];
            
        }
    } else if ([startDem isEqualToString:VOLUME_NAME[2]]) {
        if ([endDem isEqualToString:VOLUME_NAME[0]]) {
            
            volume = [value floatValue] / 1000;
            transferVolume = [NSString stringWithFormat:@"%.3f", volume];
            
        } else if ([endDem isEqualToString:VOLUME_NAME[1]]) {
            
            volume = [value floatValue] * 1000;
            transferVolume = [NSString stringWithFormat:@"%.0f", volume];
            
        }
    }
    return transferVolume;
}

+ (NSString *)transferWeight:(NSString *)value From:(NSString *)startDem to:(NSString *)endDem {
    NSString *transferWeight = value;
    CGFloat weight = [value floatValue];
    if ([startDem isEqualToString:WEIGHT_NAME[0]]) { //kg
        if ([endDem isEqualToString:WEIGHT_NAME[1]]) { //g
            
            weight = [value floatValue] * 1000;
            transferWeight = [NSString stringWithFormat:@"%.0f", weight];
            
        } else if ([endDem isEqualToString:WEIGHT_NAME[2]]) { //t
            
            weight = [value floatValue] / 1000;
            transferWeight = [NSString stringWithFormat:@"%.3f", weight];
            
        }
    } else if ([startDem isEqualToString:WEIGHT_NAME[1]]) {
        if ([endDem isEqualToString:WEIGHT_NAME[0]]) {
            
            weight = [value floatValue] / 1000;
            transferWeight = [NSString stringWithFormat:@"%.3f", weight];
            
        } else if ([endDem isEqualToString:WEIGHT_NAME[2]]) {
            
            weight = [value floatValue] / 1000000;
            transferWeight = [NSString stringWithFormat:@"%.6f", weight];
            
        }
    } else if ([startDem isEqualToString:WEIGHT_NAME[2]]) {
        if ([endDem isEqualToString:WEIGHT_NAME[0]]) {
            
            weight = [value floatValue] * 1000;
            transferWeight = [NSString stringWithFormat:@"%.0f", weight];
            
        } else if ([endDem isEqualToString:WEIGHT_NAME[1]]) {
            
            weight = [value floatValue] * 1000000;
            transferWeight = [NSString stringWithFormat:@"%.0f", weight];
            
        }
    }
    return transferWeight;
}

@end
