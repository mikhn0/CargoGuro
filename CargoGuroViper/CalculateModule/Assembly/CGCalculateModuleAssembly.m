//
//  CGCalculateModuleAssembly.m
//  CargoGuro
//
//  Created by Viktoria on 24/02/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import "CGCalculateModuleAssembly.h"

#import "CGCalculateModuleViewController.h"
#import "CGCalculateModuleInteractor.h"
#import "CGCalculateModulePresenter.h"
#import "CGCalculateModuleRouter.h"

#import <ViperMcFlurry/ViperMcFlurry.h>

@implementation CGCalculateModuleAssembly

- (CGCalculateModuleViewController *)viewCalculateModuleModule {
    return [TyphoonDefinition withClass:[CGCalculateModuleViewController class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterCalculateModuleModule]];
                              [definition injectProperty:@selector(moduleInput)
                                                    with:[self presenterCalculateModuleModule]];
                          }];
}

- (CGCalculateModuleInteractor *)interactorCalculateModuleModule {
    return [TyphoonDefinition withClass:[CGCalculateModuleInteractor class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterCalculateModuleModule]];
                          }];
}

- (CGCalculateModulePresenter *)presenterCalculateModuleModule {
    return [TyphoonDefinition withClass:[CGCalculateModulePresenter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(view)
                                                    with:[self viewCalculateModuleModule]];
                              [definition injectProperty:@selector(interactor)
                                                    with:[self interactorCalculateModuleModule]];
                              [definition injectProperty:@selector(router)
                                                    with:[self routerCalculateModuleModule]];
                          }];
}

- (CGCalculateModuleRouter *)routerCalculateModuleModule {
    return [TyphoonDefinition withClass:[CGCalculateModuleRouter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(transitionHandler)
                                                    with:[self viewCalculateModuleModule]];
                          }];
}

@end
