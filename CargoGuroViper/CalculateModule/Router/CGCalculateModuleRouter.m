//
//  CGCalculateModuleRouter.m
//  CargoGuro
//
//  Created by Viktoria on 24/02/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import "CGCalculateModuleRouter.h"
#import "CGResultCalculateModuleModuleInput.h"

#import <ViperMcFlurry/ViperMcFlurry.h>

@implementation CGCalculateModuleRouter


- (void)transitionOnResultCalculateModule:(NSDictionary *)datas {
    [[self.transitionHandler openModuleUsingSegue:@"ResultCalculateSegue"] thenChainUsingBlock:^id<RamblerViperModuleOutput>(id<CGResultCalculateModuleModuleInput> moduleInput) {
        [moduleInput configureModuleWithData:datas];
        return nil;
    }];
}

#pragma mark - Методы CGCalculateModuleRouterInput

@end
