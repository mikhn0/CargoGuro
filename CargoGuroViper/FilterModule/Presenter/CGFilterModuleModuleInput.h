//
//  CGFilterModuleModuleInput.h
//  CargoGuroViper
//
//  Created by Виктория on 03/03/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ViperMcFlurry/ViperMcFlurry.h>

@protocol CGFilterModuleModuleInput <RamblerViperModuleInput>

/**
 @author Виктория

 Метод инициирует стартовую конфигурацию текущего модуля
 */
- (void)configureModule;

@end
