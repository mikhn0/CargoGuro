//
//  CGFilterModuleRouter.m
//  CargoGuroViper
//
//  Created by Виктория on 03/03/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import "CGFilterModuleRouter.h"

#import <ViperMcFlurry/ViperMcFlurry.h>

@implementation CGFilterModuleRouter

#pragma mark - Методы CGFilterModuleRouterInput

- (void)backOnListOfTansfersWithFilter:(Filter)filter {
    [self.transitionHandler openModuleUsingSegue:@"unwindToResultCalculateSegue"];//performSegue:@"unwindToResultCalculateSegue"];
}

@end
