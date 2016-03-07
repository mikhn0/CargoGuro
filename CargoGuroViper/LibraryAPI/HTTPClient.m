//
//  HTTPClient.m
//  ModelAlliance
//
//  Created by Imac on 28.09.15.
//  Copyright © 2015 Mac. All rights reserved.
//

#import "HTTPClient.h"

#define SERVER_URL @"http://api.cargo.guru"



@interface HTTPClient ()

@end

@implementation HTTPClient

#pragma mark - Request USER




#pragma mark - SessionManager 

- (AFHTTPSessionManager *)getSessionManager {
    NSURL *baseURL = [NSURL URLWithString:SERVER_URL];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    
    
    NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    
    
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"X-OS-ID"];
    [manager.requestSerializer setValue:[[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"X-OS-VERSION"];
    [manager.requestSerializer setValue:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forHTTPHeaderField:@"X-DEVICE-ID"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", NSStringFromCGSize([UIScreen mainScreen].bounds.size)] forHTTPHeaderField:@"X-DEVICE-INFO"];
    [manager.requestSerializer setValue:@"0.9" forHTTPHeaderField:@"X-CLIENT-VER"];
    [manager.requestSerializer setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forHTTPHeaderField:@"X-CLIENT-BUILD"];
    
    [manager.requestSerializer setValue:countryCode forHTTPHeaderField:@"X-CLIENT-COUNTRY"];
    
    manager.responseSerializer = [JSONResponseSerializerWithData serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {}
    }];
    [manager.reachabilityManager startMonitoring];
    NSLog(@"%@",manager.responseSerializer);
    return manager;
}


#pragma mark - WorkWithError

- (id)inputError:(id)error {
    id object;
    if (error) {
        
        
        if ([error isKindOfClass:[NSError class]] && [[error userInfo] objectForKey:@"JSONResponseSerializerWithDataKey"]) {
            NSError *deserializationError = nil;
            object = [NSJSONSerialization
               JSONObjectWithData:[[error userInfo] objectForKey:@"JSONResponseSerializerWithDataKey"]
               options:0
               error:&deserializationError];
        } else if ([[error userInfo] objectForKey:@"NSLocalizedDescription"]) {
            
            object = [[error userInfo] objectForKey:@"NSLocalizedDescription"];
            
        } else if ([[error userInfo] objectForKey:@"NSDebugDescription"]) {
            
            object = [[error userInfo] objectForKey:@"NSDebugDescription"];
            
        } else {
            
            object = error;
            
        }
    }
    return object;
}


- (NSString *)getStringFromObject:(id)object {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
        return @"";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

- (void)saveCookies{
    
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: cookiesData forKey: @"sessionCookies"];
    [defaults synchronize];
    
}

- (void)loadCookies{
    
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: @"sessionCookies"]];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (NSHTTPCookie *cookie in cookies){
        [cookieStorage setCookie: cookie];
    }
    
}

@end
