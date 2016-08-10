//
//  CGCalculateModuleInteractor.m
//  CargoGuro
//
//  Created by Viktoria on 24/02/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import "CGCalculateModuleInteractor.h"
#import "HTTPClient.h"

#import "CGCalculateModuleInteractorOutput.h"

@implementation CGCalculateModuleInteractor

#pragma mark - Методы CGCalculateModuleInteractorInput
- (void)getDetailPlaceByPlaceIdWithParam:(NSDictionary *)params
                               onSuccess: (CompletionResult)    completion
                               onFailure: (CompletionError)     failure
                               endOfLoad: (CompletionEnd)       endOfLoad{
    
    NSURL *baseURL = [NSURL URLWithString:GET_DETAIL_PLACE];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    
    [manager GET:URI_PLACE_DETAIL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
            NSLog(@"responseObject ====== %@", responseObject[@"result"][@"address_components"]);
            completion(responseObject[@"result"][@"address_components"]);
         
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"count of company ======= %@", error);

    }];
}


@end