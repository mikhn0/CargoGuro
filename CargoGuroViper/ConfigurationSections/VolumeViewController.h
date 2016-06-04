//
//  VolumeViewController.h
//  CargoGuruViper
//
//  Created by a1 on 01.06.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import "BaseConfigurationViewController.h"

@interface VolumeViewController : BaseConfigurationViewController

@property (nonatomic, strong) NSArray *volumeName;
@property (nonatomic, strong) NSArray *volumeImageName;
@property (nonatomic) NSInteger currentIndex;

@end
