//
//  DimensionalTranslation+CGFloat.m
//  CargoGuruViper
//
//  Created by Виктория on 05.07.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import "DimensionalTranslation+NSString.h"

@implementation NSString (DimensionalTranslation)

+ (NSString *)transferVolume:(NSString *)value From:(NSInteger)startDem to:(NSInteger)endDem {
    NSString *transferVolume = value;
    CGFloat volume = [value floatValue];
    
    if (startDem == 0) { //m^3
        if (endDem == 1) { //cm^3
            
            volume = [value floatValue] * 1000000;
            transferVolume = [NSString stringWithFormat:@"%.0f", volume];
            
        } else if (endDem == 2) { //l
            
            volume = [value floatValue] * 1000;
            transferVolume = [NSString stringWithFormat:@"%.0f", volume];
            
        }
    } else if (startDem == 1) {
        if (endDem == 0) {
            
            volume = [value floatValue] / 1000000;
            transferVolume = [NSString stringWithFormat:@"%.6f", volume];
            
        } else if (endDem == 2) {
            
            volume = [value floatValue] / 1000;
            transferVolume = [NSString stringWithFormat:@"%.3f", volume];
            
        }
    } else if (startDem == 2) {
        if (endDem == 0) {
            
            volume = [value floatValue] / 1000;
            transferVolume = [NSString stringWithFormat:@"%.3f", volume];
            
        } else if (endDem == 1) {
            
            volume = [value floatValue] * 1000;
            transferVolume = [NSString stringWithFormat:@"%.0f", volume];
            
        }
    }
    return transferVolume;
}

+ (NSString *)transferWeight:(NSString *)value From:(NSInteger)startDem to:(NSInteger)endDem {
    NSString *transferWeight = value;
    CGFloat weight = [value floatValue];
    if (startDem == 0) { //kg
        if (endDem == 1) { //g
            
            weight = [value floatValue] * 1000;
            transferWeight = [NSString stringWithFormat:@"%.0f", weight];
            
        } else if (endDem == 2) { //t
            
            weight = [value floatValue] / 1000;
            transferWeight = [NSString stringWithFormat:@"%.3f", weight];
            
        }
    } else if (startDem == 1) {
        if (endDem == 0) {
            
            weight = [value floatValue] / 1000;
            transferWeight = [NSString stringWithFormat:@"%.3f", weight];
            
        } else if (endDem == 2) {
            
            weight = [value floatValue] / 1000000;
            transferWeight = [NSString stringWithFormat:@"%.6f", weight];
            
        }
    } else if (startDem == 2) {
        if (endDem == 0) {
            
            weight = [value floatValue] * 1000;
            transferWeight = [NSString stringWithFormat:@"%.0f", weight];
            
        } else if (endDem == 1) {
            
            weight = [value floatValue] * 1000000;
            transferWeight = [NSString stringWithFormat:@"%.0f", weight];
            
        }
    }
    return transferWeight;
}

@end
