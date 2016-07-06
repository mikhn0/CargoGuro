//
//  CustomView.m
//  CargoGuruViper
//
//  Created by a1 on 06.07.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGFloat radius = 100.0;
    CGRect frame = CGRectMake(0, 0,
                              self.frame.size.width + radius,
                              self.frame.size.height + radius);
    
    return (CGRectContainsPoint(frame, point));
}

@end
