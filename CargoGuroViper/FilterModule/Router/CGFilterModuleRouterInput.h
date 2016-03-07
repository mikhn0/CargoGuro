//
//  CGFilterModuleRouterInput.h
//  CargoGuroViper
//
//  Created by Виктория on 03/03/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGFilterModuleViewOutput.h"

@protocol CGFilterModuleRouterInput <NSObject>

- (void)backOnListOfTansfersWithFilter:(Filter)filter;

@end
