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
    if (startDem == VOLUME_NAME[0]) { //m^3
        if (endDem == VOLUME_NAME[1]) { //cm^3
            volume = [value floatValue] * 1000000;
        } else if (endDem == VOLUME_NAME[2]) { //l
            volume = [value floatValue] * 1000;
        }
    } else if (startDem == VOLUME_NAME[1]) {
        if (endDem == VOLUME_NAME[0]) {
            volume = [value floatValue] / 1000000;
        } else if (endDem == VOLUME_NAME[2]) {
            volume = [value floatValue] / 1000;
        }
    } else if (startDem == VOLUME_NAME[2]) {
        if (endDem == VOLUME_NAME[0]) {
            volume = [value floatValue] / 1000;
        } else if (endDem == VOLUME_NAME[1]) {
            volume = [value floatValue] * 1000;
        }
    }
    transferVolume = [NSString stringWithFormat:@"%.2f", volume];
    return transferVolume;
}

+ (NSString *)transferWeight:(NSString *)value From:(NSString *)startDem to:(NSString *)endDem {
    NSString *transferWeight = value;
    CGFloat weight = [value floatValue];
    if (startDem == WEIGHT_NAME[0]) { //kg
        if (endDem == WEIGHT_NAME[1]) { //g
            weight = [value floatValue] * 1000;
        } else if (endDem == WEIGHT_NAME[2]) { //t
            weight = [value floatValue] / 1000;
        }
    } else if (startDem == WEIGHT_NAME[1]) {
        if (endDem == WEIGHT_NAME[0]) {
            weight = [value floatValue] / 1000;
        } else if (endDem == WEIGHT_NAME[2]) {
            weight = [value floatValue] / 1000000;
        }
    } else if (startDem == WEIGHT_NAME[2]) {
        if (endDem == WEIGHT_NAME[0]) {
            weight = [value floatValue] * 1000;
        } else if (endDem == WEIGHT_NAME[1]) {
            weight = [value floatValue] * 1000000;
        }
    }
    transferWeight = [NSString stringWithFormat:@"%.2f", weight];
    return transferWeight;
}

@end
