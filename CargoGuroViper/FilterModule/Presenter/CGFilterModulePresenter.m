//
//  CGFilterModulePresenter.m
//  CargoGuroViper
//
//  Created by Виктория on 03/03/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import "CGFilterModulePresenter.h"

#import "CGFilterModuleViewInput.h"
#import "CGFilterModuleInteractorInput.h"
#import "CGFilterModuleRouterInput.h"

@implementation CGFilterModulePresenter

#pragma mark - Методы CGFilterModuleModuleInput

- (void)configureModule {
    // Стартовая конфигурация модуля, не привязанная к состоянию view
}

#pragma mark - Методы CGFilterModuleViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

- (void)applaySelectedFilter:(Filter)filter {
    [self.router backOnListOfTansfersWithFilter:filter];
}

#pragma mark - Методы CGFilterModuleInteractorOutput

@end
