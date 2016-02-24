//
//  CGCalculateModuleViewOutput.h
//  CargoGuro
//
//  Created by Viktoria on 24/02/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CGCalculateModuleViewOutput <NSObject>

/**
 @author Viktoria

 Метод сообщает презентеру о том, что view готова к работе
 */
- (void)didTriggerViewReadyEvent;

@end
