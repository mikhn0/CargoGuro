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
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        // Get all companies that can potentially provide services
        [[httpClient getSessionManager] GET:GET_COMPLIST parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSArray *companies = responseObject[kCOMPANIES];
            NSInteger countOfCompany = companies.count;
            dispatch_queue_t concurrent_queue = dispatch_queue_create("com.fruktorum.GetCalculationQueue", DISPATCH_QUEUE_CONCURRENT);
            
            for (NSDictionary *company in companies) {
                
                NSMutableDictionary *mutableParams = params.mutableCopy;
                
                mutableParams[@"tNum"] = company[kTRANSPORT_NUMBER];
                
                __block NSString *companyName = company[kTRANSPORT_NAME];
                __block NSString *transportSite = company[kTRANSPORT_SITE];
                __block NSDictionary *transportNames = company[kTRANSPORT_NAMES];
                
                countOfCompany--;
                if (countOfCompany % 10 == 0) {
                    dispatch_barrier_async(concurrent_queue, ^{
                        [self getCalculationByCompanyName:  companyName
                                             withSiteName:  transportSite
                                       withTransportNames:  transportNames
                                       withCountOfCompany:  countOfCompany
                                           withDictionary:  mutableParams
                                                onSuccess:^(NSDictionary *result) {
                                                    completion(result);
                                           } onFailure:^(NSString *error) {
                                               failure(error);
                                           } endOfLoad:^(BOOL theEnd) {
                                               endOfLoad(theEnd);
                                           }];
                    });
                } else {
                    dispatch_async(concurrent_queue, ^{
                        [self getCalculationByCompanyName: companyName
                                              withSiteName: transportSite
                                        withTransportNames: transportNames
                                        withCountOfCompany: countOfCompany
                                            withDictionary: mutableParams
                                                 onSuccess:^(NSDictionary *result) {
                                                     completion(result);
                                                 } onFailure:^(NSString *error) {
                                                     failure(error);
                                                 } endOfLoad:^(BOOL theEnd) {
                                                     endOfLoad(theEnd);
                                                 }];
                    });
                }
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure([httpClient inputError:error]);
        }];
    });
}

- (void) getCalculationByCompanyName: (NSString *)          companyName
                        withSiteName: (NSString *)          siteName
                  withTransportNames: (NSDictionary *)      transportNames
                  withCountOfCompany: (NSInteger)           countOfCompany
                      withDictionary: (NSDictionary *)      params
                           onSuccess: (CompletionResult)    completion
                           onFailure: (CompletionError)     failure
                           endOfLoad: (CompletionEnd)       endOfLoad {
    
    
    HTTPClient *httpClient = [[HTTPClient alloc] init];
    [[httpClient getSessionManager] POST:GET_CALCULATION parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (![responseObject objectForKey:@"failReason"]) {
            
            NSMutableDictionary *response = [responseObject mutableCopy];
            response[kTRANSPORT_NAME] = companyName;
            response[kTRANSPORT_SITE] = siteName;
            response[kTRANSPORT_NAMES] = transportNames;
            completion(response.copy);
            NSLog(@"responseObject ====== %@", response);
        } 
        if ( countOfCompany == 0 ) {
            //endOfLoad( YES );
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //NSLog(@"count of company ======= %li", (long)countOfCompany);
        failure([httpClient inputError:error]);
    }];
}

- (void) getAdvertOnSuccess:(CompletionResult)   success
                 onFailure:(CompletionError)    failure {
    HTTPClient *httpClient = [[HTTPClient alloc] init];
    [[httpClient getSessionManager] GET:GET_ADVERT parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"ERRROR ====== %@\n\n", error );
        failure([httpClient inputError:error]);
        
    }];
}

- (void) getResultAdvertOnSuccess:(CompletionResult)    success
                        onFailure:(CompletionError)     failure {
    HTTPClient *httpClient = [[HTTPClient alloc] init];
    [[httpClient getSessionManager] GET:GET_RES_ADVERT parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"ERRROR ====== %@\n\n", error );
        failure([httpClient inputError:error]);
        
    }];
}

- (void) getConvertPrices: (NSString *)         number
                 withCurr: (NSString *)         curr
                onSuccess: (CompletionResult)   success
                onFailure: (CompletionError)    failure {
    HTTPClient *httpClient = [[HTTPClient alloc] init];
    NSDictionary *params = @{@"number":number, @"curr":curr};
    [[httpClient getSessionManager] GET:GET_CVT_PRICES parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        id responseError = [httpClient inputError:error];
        if ([responseError isKindOfClass:[NSDictionary class]] && [responseError objectForKey:@"RUB"]) {
            success(responseError);
        } else {
            failure(responseError);
        }
    }];
}

@end
