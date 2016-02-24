//
//  CGCalculateModulePresenter.h
//  CargoGuro
//
//  Created by Viktoria on 24/02/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import "CGCalculateModuleViewOutput.h"
#import "CGCalculateModuleInteractorOutput.h"
#import "CGCalculateModuleModuleInput.h"

@protocol CGCalculateModuleViewInput;
@protocol CGCalculateModuleInteractorInput;
@protocol CGCalculateModuleRouterInput;

@interface CGCalculateModulePresenter : NSObject <CGCalculateModuleModuleInput, CGCalculateModuleViewOutput, CGCalculateModuleInteractorOutput>

@property (nonatomic, weak) id<CGCalculateModuleViewInput> view;
@property (nonatomic, strong) id<CGCalculateModuleInteractorInput> interactor;
@property (nonatomic, strong) id<CGCalculateModuleRouterInput> router;

@end
