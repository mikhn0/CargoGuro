//
//  VolumeCalculateView.h
//  CargoGuruViper
//
//  Created by a1 on 14.06.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VolumeCalculateViewDelegate <NSObject>

- (void)resultCalculateVolume:(NSString *)resultString;

@end

@interface VolumeCalculateView : UIView

@property (weak, nonatomic) id <VolumeCalculateViewDelegate> delegate;

@end
