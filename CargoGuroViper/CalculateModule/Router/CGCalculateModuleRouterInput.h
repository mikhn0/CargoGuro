//
//  CGCalculateModuleRouterInput.h
//  CargoGuro
//
//  Created by Viktoria on 24/02/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CGCalculateModuleRouterInput <NSObject>

//может быть этот метод поместить лучше в CGCalculateModuleRouterOutput
- (void)transitionOnResultCalculateModule:(NSDictionary *)datas;

@end
