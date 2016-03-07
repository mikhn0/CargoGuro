//
//  HTTPClient.h
//  ModelAlliance
//
//  Created by Imac on 28.09.15.
//  Copyright © 2015 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "JSONResponseSerializerWithData.h"


//#define CURRENT_LANG ([self.currentLanguage isEqualToString:@"ru-US"] || [self.currentLanguage isEqualToString:@"ru-RU"] ? @"ru" : ([self.currentLanguage isEqualToString:@"en-US"]) ? @"en" : @"")


@interface HTTPClient : NSObject <NSURLConnectionDelegate> {
    NSMutableData *responseData;
}

@property (nonatomic, strong) NSString *currentLanguage;


- (AFHTTPSessionManager *)getSessionManager;
- (id)inputError:(id)error;

@end
