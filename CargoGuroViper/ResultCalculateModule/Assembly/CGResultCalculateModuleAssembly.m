//
//  CGResultCalculateModuleAssembly.m
//  CargoGuroViper
//
//  Created by Виктория on 25/02/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import "CGResultCalculateModuleAssembly.h"

#import "CGResultCalculateModuleViewController.h"
#import "CGResultCalculateModuleInteractor.h"
#import "CGResultCalculateModulePresenter.h"
#import "CGResultCalculateModuleRouter.h"

#import <ViperMcFlurry/ViperMcFlurry.h>

@implementation CGResultCalculateModuleAssembly


- (CGResultCalculateModuleViewController *)viewResultCalculateModuleModule {
    return [TyphoonDefinition withClass:[CGResultCalculateModuleViewController class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterResultCalculateModuleModule]];
                              [definition injectProperty:@selector(moduleInput)
                                                    with:[self presenterResultCalculateModuleModule]];
                          }];
}

- (CGResultCalculateModuleInteractor *)interactorResultCalculateModuleModule {
    return [TyphoonDefinition withClass:[CGResultCalculateModuleInteractor class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterResultCalculateModuleModule]];
                          }];
}

- (CGResultCalculateModulePresenter *)presenterResultCalculateModuleModule {
    return [TyphoonDefinition withClass:[CGResultCalculateModulePresenter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(view)
                                                    with:[self viewResultCalculateModuleModule]];
                              [definition injectProperty:@selector(interactor)
                                                    with:[self interactorResultCalculateModuleModule]];
                              [definition injectProperty:@selector(router)
                                                    with:[self routerResultCalculateModuleModule]];
                          }];
}

- (CGResultCalculateModuleRouter *)routerResultCalculateModuleModule {
    return [TyphoonDefinition withClass:[CGResultCalculateModuleRouter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(transitionHandler)
                                                    with:[self viewResultCalculateModuleModule]];
                          }];
}

@end
