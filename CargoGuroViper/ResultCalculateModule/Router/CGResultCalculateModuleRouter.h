//
//  CGResultCalculateModuleRouter.h
//  CargoGuroViper
//
//  Created by Виктория on 25/02/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import "CGResultCalculateModuleRouterInput.h"

@protocol RamblerViperModuleTransitionHandlerProtocol;

@interface CGResultCalculateModuleRouter : NSObject <CGResultCalculateModuleRouterInput>

@property (nonatomic, weak) id<RamblerViperModuleTransitionHandlerProtocol> transitionHandler;

@end
