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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
