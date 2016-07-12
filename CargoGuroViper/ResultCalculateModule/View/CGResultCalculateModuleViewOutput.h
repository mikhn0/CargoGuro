//
//  CGResultCalculateModuleViewOutput.h
//  CargoGuroViper
//
//  Created by Виктория on 25/02/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol CGResultCalculateModuleViewOutput <NSObject>

/**
 @author Виктория

 Метод сообщает презентеру о том, что view готова к работе
 */
@property (weak, nonatomic) UIImageView *imageIndicator;
@property (weak, nonatomic) UIView *loadView;

- (void)didTriggerViewReadyEvent;
- (void)reloadPrice:(NSString *)number withCurrency:(NSString *)curr;

@end
