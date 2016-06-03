//
//  CurTableViewCell.h
//  CargoGuruViper
//
//  Created by Виктория on 02.06.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString *currencyName;
@property (nonatomic, strong) NSString *currencySymbolByName;
@property (weak, nonatomic) IBOutlet UIImageView *selectedIcon;

@end
