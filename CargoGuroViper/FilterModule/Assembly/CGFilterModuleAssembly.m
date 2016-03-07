//
//  CGFilterModuleAssembly.m
//  CargoGuroViper
//
//  Created by Виктория on 03/03/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import "CGFilterModuleAssembly.h"

#import "CGFilterModuleViewController.h"
#import "CGFilterModuleInteractor.h"
#import "CGFilterModulePresenter.h"
#import "CGFilterModuleRouter.h"

#import <ViperMcFlurry/ViperMcFlurry.h>

@implementation CGFilterModuleAssembly


- (CGFilterModuleViewController *)viewFilterModuleModule {
    return [TyphoonDefinition withClass:[CGFilterModuleViewController class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterFilterModuleModule]];
                              [definition injectProperty:@selector(moduleInput)
                                                    with:[self presenterFilterModuleModule]];
                          }];
}

- (CGFilterModuleInteractor *)interactorFilterModuleModule {
    return [TyphoonDefinition withClass:[CGFilterModuleInteractor class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterFilterModuleModule]];
                          }];
}

- (CGFilterModulePresenter *)presenterFilterModuleModule {
    return [TyphoonDefinition withClass:[CGFilterModulePresenter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(view)
                                                    with:[self viewFilterModuleModule]];
                              [definition injectProperty:@selector(interactor)
                                                    with:[self interactorFilterModuleModule]];
                              [definition injectProperty:@selector(router)
                                                    with:[self routerFilterModuleModule]];
                          }];
}

- (CGFilterModuleRouter *)routerFilterModuleModule {
    return [TyphoonDefinition withClass:[CGFilterModuleRouter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(transitionHandler)
                                                    with:[self viewFilterModuleModule]];
                          }];
}

@end
