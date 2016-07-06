//
//  CGCalculateModuleInteractorInput.h
//  CargoGuro
//
//  Created by Viktoria on 24/02/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol CGCalculateModuleInteractorInput <NSObject>


- (void)getDetailPlaceByPlaceIdWithParam:(NSDictionary *)params
                               onSuccess: (CompletionResult)    completion
                               onFailure: (CompletionError)     failure
                               endOfLoad: (CompletionEnd)       endOfLoad;

@end
