//
//  CGResultCalculateModuleInteractor.h
//  CargoGuroViper
//
//  Created by Виктория on 25/02/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import "CGResultCalculateModuleInteractorInput.h"

@protocol CGResultCalculateModuleInteractorOutput;

@interface CGResultCalculateModuleInteractor : NSObject <CGResultCalculateModuleInteractorInput>

@property (nonatomic, weak) id<CGResultCalculateModuleInteractorOutput> output;

@end
