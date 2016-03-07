//
//  CGFilterModuleRouter.h
//  CargoGuroViper
//
//  Created by Виктория on 03/03/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import "CGFilterModuleRouterInput.h"

@protocol RamblerViperModuleTransitionHandlerProtocol;

@interface CGFilterModuleRouter : NSObject <CGFilterModuleRouterInput>

@property (nonatomic, weak) id<RamblerViperModuleTransitionHandlerProtocol> transitionHandler;

@end
