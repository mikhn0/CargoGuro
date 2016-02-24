//
//  CGCalculateModuleRouter.h
//  CargoGuro
//
//  Created by Viktoria on 24/02/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import "CGCalculateModuleRouterInput.h"

@protocol RamblerViperModuleTransitionHandlerProtocol;

@interface CGCalculateModuleRouter : NSObject <CGCalculateModuleRouterInput>

@property (nonatomic, weak) id<RamblerViperModuleTransitionHandlerProtocol> transitionHandler;

@end
