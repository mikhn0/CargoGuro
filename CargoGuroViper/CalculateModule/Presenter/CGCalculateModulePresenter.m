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

#import "CGCalculateModuleInteractor.h"
#import "CGCalculateModuleRouter.h"

@implementation CGCalculateModulePresenter

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (CGCalculateModulePresenter *)sharedinstance {
    static CGCalculateModulePresenter *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[CGCalculateModulePresenter alloc] init];
    });
    return _sharedInstance;
}

#pragma mark - Методы CGCalculateModuleModuleInput

- (void)configureModule {
    // Стартовая конфигурация модуля, не привязанная к состоянию view
}

#pragma mark - Методы CGCalculateModuleViewOutput

//- (void)didTriggerViewReadyEvent {
//	[self.view setupInitialState];
//}

- (void)searchTransition:(NSDictionary *)datas {
    
    [self.router transitionOnResultCalculateModule:datas];

}

#pragma mark - Методы CGCalculateModuleInteractorOutput

@end
