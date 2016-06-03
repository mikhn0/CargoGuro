//
//  LanTableViewCell.m
//  CargoGuruViper
//
//  Created by a1 on 02.06.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import "LanTableViewCell.h"

@interface LanTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *flagImage;
@property (weak, nonatomic) IBOutlet UILabel *flagLabel;

@end

@implementation LanTableViewCell

@synthesize flagImage = _flagImage;
@synthesize flagLabel = _flagLabel;
@synthesize selectedIcon = _selectedIcon;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (NSString *)flagName {
    return _flagLabel.text;
}

- (void)setFlagName:(NSString *)flagName {
    _flagLabel.text = flagName;
}

- (UIImage *)flagImageName {
    return _flagImage.image;
}

- (void)setFlagImageByName:(UIImage *)flagImageByName {
    _flagImage.image = flagImageByName;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (self.currentIndex == [(UITableView *)self.superview indexPathForCell: self].row) {
        _selectedIcon.hidden = selected;
    } else {
        _selectedIcon.hidden = !selected;
    }
}

@end
