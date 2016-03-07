//
//  CGFilterModulePresenter.h
//  CargoGuroViper
//
//  Created by Виктория on 03/03/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import "CGFilterModuleViewOutput.h"
#import "CGFilterModuleInteractorOutput.h"
#import "CGFilterModuleModuleInput.h"

@protocol CGFilterModuleViewInput;
@protocol CGFilterModuleInteractorInput;
@protocol CGFilterModuleRouterInput;

@interface CGFilterModulePresenter : NSObject <CGFilterModuleModuleInput, CGFilterModuleViewOutput, CGFilterModuleInteractorOutput>

@property (nonatomic, weak) id<CGFilterModuleViewInput> view;
@property (nonatomic, strong) id<CGFilterModuleInteractorInput> interactor;
@property (nonatomic, strong) id<CGFilterModuleRouterInput> router;

@end
