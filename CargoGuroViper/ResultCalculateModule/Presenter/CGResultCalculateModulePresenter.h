//
//  CGResultCalculateModulePresenter.h
//  CargoGuroViper
//
//  Created by Виктория on 25/02/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import "CGResultCalculateModuleViewOutput.h"
#import "CGResultCalculateModuleInteractorOutput.h"
#import "CGResultCalculateModuleModuleInput.h"

@protocol CGResultCalculateModuleViewInput;
@protocol CGResultCalculateModuleInteractorInput;
@protocol CGResultCalculateModuleRouterInput;

@interface CGResultCalculateModulePresenter : NSObject <CGResultCalculateModuleModuleInput, CGResultCalculateModuleViewOutput, CGResultCalculateModuleInteractorOutput>

@property (nonatomic, weak) id<CGResultCalculateModuleViewInput> view;
@property (nonatomic, strong) id<CGResultCalculateModuleInteractorInput> interactor;
@property (nonatomic, strong) id<CGResultCalculateModuleRouterInput> router;

@property (weak, nonatomic) UIImageView *imageIndicator;
@property (weak, nonatomic) UIView *loadView;

@end
