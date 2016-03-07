//
//  CGFilterModuleInteractor.h
//  CargoGuroViper
//
//  Created by Виктория on 03/03/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import "CGFilterModuleInteractorInput.h"

@protocol CGFilterModuleInteractorOutput;

@interface CGFilterModuleInteractor : NSObject <CGFilterModuleInteractorInput>

@property (nonatomic, weak) id<CGFilterModuleInteractorOutput> output;

@end
