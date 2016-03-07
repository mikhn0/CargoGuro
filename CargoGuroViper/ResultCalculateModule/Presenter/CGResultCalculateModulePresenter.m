//
//  CGResultCalculateModulePresenter.m
//  CargoGuroViper
//
//  Created by Виктория on 25/02/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import "CGResultCalculateModulePresenter.h"

#import "CGResultCalculateModuleViewInput.h"
#import "CGResultCalculateModuleInteractorInput.h"
#import "CGResultCalculateModuleRouterInput.h"


@interface CGResultCalculateModulePresenter () {
    NSTimer *myTimer;
}

@end

@implementation CGResultCalculateModulePresenter

#pragma mark - Методы CGResultCalculateModuleModuleInput

- (void)configureModule {
    // Стартовая конфигурация модуля, не привязанная к состоянию view
    //start animation load indicator

}

- (void)configureModuleWithData:(NSDictionary *)datas {
    
    self.view.datas = datas;
//    [self.interactor getAdvertOnSuccess:^(NSDictionary *result) {
//        NSLog(@"result ======== %@", result);
//    } onFailure:^(NSString *error) {
//        NSLog(@"ERROR ADVERT ===== %@", error);
//    }];
//    
//    [self.interactor getResultAdvertOnSuccess:^(NSDictionary *result) {
//        NSLog(@"result Advert ======== %@", result);
//    } onFailure:^(NSString *error) {
//        NSLog(@"ERROR ADVERT ========== %@", error);
//    }];
    myTimer = [NSTimer scheduledTimerWithTimeInterval:10.0
                                     target:self
                                   selector:@selector(targetMethod:)
                                   userInfo:nil
                                    repeats:NO];
    [self.interactor getCalculationWithDictionary:datas onSuccess:^(NSDictionary *result) {
        
        if (result[@"methods"] != [NSNull null] && [result[@"methods"] count] > 0) {
            
            for (int i=0; i<[result[@"methods"] count]; i++) {
                
                NSMutableDictionary *resultDictionary = result.mutableCopy;
                resultDictionary[@"methods"] = [result[@"methods"] objectAtIndex:i];
                
                [self.view addRowWithResult:resultDictionary.copy];
                
            }
            
        }
        
        
    } onFailure:^(NSString *error) {
        
        [self stopRotateIndicator];
        [self.view outPutError:error];
        //отобразить error
        
    } endOfLoad:^(BOOL theEnd) {
        
        [self stopRotateIndicator];
        
    }];
}

- (void)stopRotateIndicator {
    [self.imageIndicator.layer removeAllAnimations];
    self.imageIndicator.hidden = YES;
    self.loadView.hidden = YES;
    [myTimer invalidate];
    myTimer = nil;
}

-(void)targetMethod:(NSTimer *)timer {
    [self stopRotateIndicator];
}

#pragma mark - Методы CGResultCalculateModuleViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

- (void)didSelectFilter {
    [self.router transitionOnFilterModule];
}


#pragma mark - Методы CGResultCalculateModuleInteractorOutput

@end
