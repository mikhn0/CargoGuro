//
//  LanTableViewCell.h
//  CargoGuruViper
//
//  Created by a1 on 02.06.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LanTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString *flagName;
@property (nonatomic, strong) UIImage *flagImageByName;
@property (weak, nonatomic) IBOutlet UIImageView *selectedIcon;
@property (nonatomic) NSInteger currentIndex;

@end
