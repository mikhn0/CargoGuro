//
//  CGFilterModuleViewController.h
//  CargoGuroViper
//
//  Created by Виктория on 03/03/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CGFilterModuleViewInput.h"

@protocol CGFilterModuleViewOutput;

@interface CGFilterModuleViewController : UIViewController <CGFilterModuleViewInput>

@property (nonatomic, strong) id<CGFilterModuleViewOutput> output;
@property (nonatomic)  NSInteger currentFilter;

@end
