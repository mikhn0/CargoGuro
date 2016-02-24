//
//  CGCalculateModulePresenter.m
//  CargoGuro
//
//  Created by Viktoria on 24/02/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import "CGCalculateModulePresenter.h"

#import "CGCalculateModuleViewInput.h"
#import "CGCalculateModuleInteractorInput.h"
#import "CGCalculateModuleRouterInput.h"

@implementation CGCalculateModulePresenter

#pragma mark - Методы CGCalculateModuleModuleInput

- (void)configureModule {
    // Стартовая конфигурация модуля, не привязанная к состоянию view
}

#pragma mark - Методы CGCalculateModuleViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы CGCalculateModuleInteractorOutput

@end
