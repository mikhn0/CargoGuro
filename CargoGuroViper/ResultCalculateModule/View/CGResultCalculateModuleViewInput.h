//
//  CGResultCalculateModuleViewInput.h
//  CargoGuroViper
//
//  Created by Виктория on 25/02/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CGResultCalculateModuleViewInput <NSObject>

/**
 @author Виктория

 Метод настраивает начальный стейт view
 */
@property (weak, nonatomic) NSDictionary *datas;

- (void)setupInitialState;
- (void)addRowWithResult:(NSDictionary *)result;
- (void)reloadCurrencyWuthPrice:(NSDictionary *)result;
- (void)outPutError:(NSString *)error;

@end
