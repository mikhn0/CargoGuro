//
//  CGCalculateModuleViewController.h
//  CargoGuro
//
//  Created by Viktoria on 24/02/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CGCalculateModuleViewInput.h"

@protocol CGCalculateModuleViewOutput;

@interface CGCalculateModuleViewController : UIViewController <CGCalculateModuleViewInput>

@property (nonatomic, strong) id<CGCalculateModuleViewOutput> output;

@end
