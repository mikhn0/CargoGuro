//
//  CGFilterModuleViewOutput.h
//  CargoGuroViper
//
//  Created by Виктория on 03/03/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
    Cost = 0,
    Transfer,
    Process,
    Time
};

typedef NSInteger Filter;

@protocol CGFilterModuleViewOutput <NSObject>

/**
 @author Виктория

 Метод сообщает презентеру о том, что view готова к работе
 */
- (void)didTriggerViewReadyEvent;
- (void)applaySelectedFilter:(Filter)filter;

@end
