//
//  CGResultCalculateModuleRouter.m
//  CargoGuroViper
//
//  Created by Виктория on 25/02/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import "CGResultCalculateModuleRouter.h"
#import "CGFilterModuleModuleInput.h"

#import <ViperMcFlurry/ViperMcFlurry.h>

@implementation CGResultCalculateModuleRouter

#pragma mark - Методы CGResultCalculateModuleRouterInput

- (void)transitionOnFilterModule {
    [self.transitionHandler openModuleUsingSegue:@"FilterSegue"];
}

@end
