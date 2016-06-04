//
//  BaseTableViewCell.h
//  CargoGuruViper
//
//  Created by Виктория on 04.06.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIImage *imageByName;
@property (weak, nonatomic) IBOutlet UIImageView *selectedIcon;

@end
