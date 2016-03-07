//
//  CGCalculateModuleInteractor.h
//  CargoGuro
//
//  Created by Viktoria on 24/02/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import "CGCalculateModuleInteractorInput.h"

@protocol CGCalculateModuleInteractorOutput;

@interface CGCalculateModuleInteractor : NSObject <CGCalculateModuleInteractorInput>

@property (nonatomic, weak) id<CGCalculateModuleInteractorOutput> output;


@end
