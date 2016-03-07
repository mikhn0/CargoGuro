//
//  CGResultCalculateModuleModuleInput.h
//  CargoGuroViper
//
//  Created by Виктория on 25/02/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ViperMcFlurry/ViperMcFlurry.h>

@protocol CGResultCalculateModuleModuleInput <RamblerViperModuleInput>

/**
 @author Виктория

 Метод инициирует стартовую конфигурацию текущего модуля
 */
- (void)configureModule;
- (void)configureModuleWithData:(NSDictionary *)datas;

@end
