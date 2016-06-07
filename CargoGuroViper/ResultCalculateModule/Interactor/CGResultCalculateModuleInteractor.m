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

#define GET_COMPLIST    @"2/get_complist.php"
#define GET_CALCULATION @"2/get_calculation.php"
#define GET_ADVERT      @"2/get_advert.php"
#define GET_RES_ADVERT  @"2/get_res_advert.php"
#define GET_CVT_PRICES  @"2/get_cvt_prices.php"
#define CLICKURL        @"2/clickurl.php"

#define kCOMPANIES          @"companies"
#define kTRANSPORT_NUMBER   @"transportNumber"
#define kTRANSPORT_NAME     @"transportName"
#define kTRANSPORT_SITE     @"transportSite"

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
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        // Get all companies that can potentially provide services
        [[httpClient getSessionManager] GET:GET_COMPLIST parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSArray *companies = responseObject[kCOMPANIES];
            __block NSInteger countOfCompany = companies.count;
            
            for (NSDictionary *company in companies) {
                
                //NSLog(@"company ====== %@", company);
                NSMutableDictionary *mutableParams = params.mutableCopy;
                
                mutableParams[@"tNum"] = company[kTRANSPORT_NUMBER];
                
                //NSLog(@"mutableParams ====== %@", mutableParams);
                
                __block NSString *companyName = company[kTRANSPORT_NAME];
                __block NSString *transportSite = company[kTRANSPORT_SITE];
                
                dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                    
                    // Get JSON with information about freight for current company
                    [[httpClient getSessionManager] POST:GET_CALCULATION parameters:mutableParams progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        
                        //NSLog(@"responseObject ====== %@", responseObject);
                        
                        NSMutableDictionary *response = [responseObject mutableCopy];
                        response[kTRANSPORT_NAME] = companyName;
                        response[kTRANSPORT_SITE] = transportSite;
                        completion(response.copy);
                        
                        countOfCompany--;
                        if (countOfCompany == 0) {
                            endOfLoad(YES);
                        }
                        
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        //NSLog(@"count of company ======= %li", (long)countOfCompany);
                        failure([httpClient inputError:error]);
                        
                    }];
                });
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure([httpClient inputError:error]);
        }];
        
    });
}

- (void) getAdvertOnSuccess:(CompletionResult)   success
                 onFailure:(CompletionError)    failure {
    HTTPClient *httpClient = [[HTTPClient alloc] init];
    [[httpClient getSessionManager] GET:GET_ADVERT parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
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
    [[httpClient getSessionManager] GET:GET_RES_ADVERT parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSDictionary* jsonFromData = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:error.userInfo[@"JSONResponseSerializerWithDataKey"] options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"ERRROR ====== %@\n\n", jsonFromData );
        failure([httpClient inputError:error]);
        
    }];
}


@end
