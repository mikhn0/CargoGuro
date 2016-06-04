//
//  BaseTableViewCell.m
//  CargoGuruViper
//
//  Created by Виктория on 04.06.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface BaseTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation BaseTableViewCell

@synthesize leftImageView = _leftImageView;
@synthesize titleLabel = _titleLabel;

- (NSString *)name {
    return _titleLabel.text;
}

- (void)setName:(NSString *)name {
    _titleLabel.text = name;
}

- (UIImage *)imageName {
    return _leftImageView.image;
}

- (void)setImageByName:(UIImage *)imageByName {
    _leftImageView.image = imageByName;
}

@end
