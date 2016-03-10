//
//  CGResultCalculateModuleViewController.h
//  CargoGuroViper
//
//  Created by Виктория on 25/02/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CGResultCalculateModuleViewInput.h"


enum {
    None = 0,
    Top,
    Bottom
};

typedef NSInteger Arrow;


@protocol CGResultCalculateModuleViewOutput;

@interface CGResultCalculateModuleViewController : UIViewController <CGResultCalculateModuleViewInput>

@property (nonatomic, strong) id<CGResultCalculateModuleViewOutput> output;
@property (nonatomic, weak) NSDictionary *datas;


- (void)addRowWithResult:(NSDictionary *)result;

@end
