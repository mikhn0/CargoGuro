//
//  CGResultCalculateModuleInteractorInput.h
//  CargoGuroViper
//
//  Created by Виктория on 25/02/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CompletionResult)(NSDictionary *result);
typedef void (^CompletionError)(NSString *error);
typedef void (^CompletionEnd)(BOOL theEnd);

@protocol CGResultCalculateModuleInteractorInput <NSObject>

- (void) getCalculationWithDictionary: (NSDictionary *)      params
                            onSuccess: (CompletionResult)    completion
                            onFailure: (CompletionError)     failure
                            endOfLoad: (CompletionEnd)       endOfLoad;

- (void) getAdvertOnSuccess:(CompletionResult)   success
                  onFailure:(CompletionError)    failure;

- (void) getResultAdvertOnSuccess:(CompletionResult)    success
                        onFailure:(CompletionError)     failure;

- (void) getConvertPrices: (NSString *)         number
                 withCurr: (NSString *)         curr
                onSuccess: (CompletionResult)   success
                onFailure: (CompletionError)    failure;
@end
