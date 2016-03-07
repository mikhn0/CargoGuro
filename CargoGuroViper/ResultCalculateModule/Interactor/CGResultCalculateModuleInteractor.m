//
//  CGResultCalculateModuleInteractor.m
//  CargoGuroViper
//
//  Created by Виктория on 25/02/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import "CGResultCalculateModuleInteractor.h"
#import "HTTPClient.h"
#import "CGResultCalculateModuleInteractorOutput.h"

@implementation CGResultCalculateModuleInteractor

#pragma mark - Методы CGResultCalculateModuleInteractorInput

- (void) getListOfTransitionOnSuccess: (CompletionResult) completion
                            onFailure: (CompletionError) failure {
    //get_complist
}

- (void) getCalculationWithDictionary: (NSDictionary *)      params
                            onSuccess: (CompletionResult)    completion
                            onFailure: (CompletionError)     failure
                            endOfLoad: (CompletionEnd)       endOfLoad {
    
    HTTPClient *httpClient = [[HTTPClient alloc] init];
    
    [[httpClient getSessionManager] GET:@"1/get_complist.php" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *companies = responseObject[@"companies"];
        __block NSInteger countOfCompany = companies.count;
        
        for (NSDictionary *company in companies) {
            NSLog(@"company ====== %@", company);
            NSMutableDictionary *mutableParams = params.mutableCopy;
            
            mutableParams[@"tNum"] = company[@"transportNumber"];
            
            __block NSString *companyName = company[@"transportName"];
            __block NSString *transportSite = company[@"transportSite"];
            
            [[httpClient getSessionManager] POST:@"1/get_calculation.php" parameters:mutableParams progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSMutableDictionary *responce = [responseObject mutableCopy];
                responce[@"transportName"] = companyName;
                responce[@"transportSite"] = transportSite;
                completion(responce.copy);
                
                countOfCompany--;
                if (countOfCompany == 0) {
                    endOfLoad(YES);
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"count of company ======= %li", (long)countOfCompany);
                failure([httpClient inputError:error]);
                
            }];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure([httpClient inputError:error]);
        
    }];
    
}

- (void) getAdvertOnSuccess:(CompletionResult)   success
                 onFailure:(CompletionError)    failure {
    HTTPClient *httpClient = [[HTTPClient alloc] init];
    [[httpClient getSessionManager] GET:@"1/get_advert.php" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSDictionary* jsonFromData = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:error.userInfo[@"JSONResponseSerializerWithDataKey"] options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"ERRROR ====== %@\n\n", jsonFromData );
        failure([httpClient inputError:error]);
        
    }];
}

- (void) getResultAdvertOnSuccess:(CompletionResult)    success
                        onFailure:(CompletionError)     failure {
    HTTPClient *httpClient = [[HTTPClient alloc] init];
    [[httpClient getSessionManager] GET:@"1/get_res_advert.php" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSDictionary* jsonFromData = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:error.userInfo[@"JSONResponseSerializerWithDataKey"] options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"ERRROR ====== %@\n\n", jsonFromData );
        failure([httpClient inputError:error]);
        
    }];
}


@end
