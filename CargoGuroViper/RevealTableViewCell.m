//
//  JVDrawerTableViewCell.m
//  JVFloatingDrawer
//
//  Created by Julian Villella on 2015-01-15.
//  Copyright (c) 2015 JVillella. All rights reserved.
//

#import "RevealTableViewCell.h"

static const CGFloat kJVCenterViewContainerCornerRadius = 5.0;

@interface RevealTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedParameter;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@end

@implementation RevealTableViewCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [self highlightCell:selected];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    [self highlightCell:highlighted];
}

- (void)highlightCell:(BOOL)highlight {
    UIColor *tintColor = [UIColor whiteColor];
    if(highlight) {
        tintColor = [UIColor colorWithWhite:1.0 alpha:0.6];
    }
    
    self.titleLabel.textColor = tintColor;
    self.iconImageView.tintColor = tintColor;
}

#pragma mark - Accessors

#pragma Title

- (NSString *)titleText {
    return self.titleLabel.text;
}

- (void)setTitleText:(NSString *)title {
    self.titleLabel.text = title;
}

#pragma Icon

- (UIImage *)iconImage {
    return self.iconImageView.image;
}

- (void)setIconImage:(UIImage *)icon {
    self.iconImageView.image = icon;
}

#pragma Parametr

- (NSString *)titleParameter {
    return self.selectedParameter.text;
}

- (void)setTitleParameter:(NSString *)titleParameter {
    self.selectedParameter.text = titleParameter;
}

#pragma Button

- (void)setSearchText:(BOOL)isFirsty {
    [self.searchButton setTitle:LocalizedString(@"SEARCH") forState:UIControlStateNormal];
    
    if (isFirsty) {
        CGSize size = CGSizeMake(112, 112);
        CAGradientLayer *layer = [CAGradientLayer layer];
        layer.frame = CGRectMake(0, 0, size.width, size.height);
        layer.colors = @[ (__bridge id)[UIColor colorWithRed:156.0/255.0 green:41.0/255.0 blue:119.0/255.0 alpha:1.0].CGColor ,   // start color
                          (__bridge id)[UIColor colorWithRed:81.0/255.0 green:24.0/255.0 blue:70.0/255.0 alpha:1.0].CGColor]; // end color
        
        UIGraphicsBeginImageContext(size);
        [layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.searchButton.backgroundColor = [UIColor colorWithPatternImage:image];
        
        self.searchButton.layer.cornerRadius = self.searchButton.frame.size.width+4;
        
        CALayer *layerShadow = self.searchButton.layer;
        layerShadow.shadowRadius  = 30.0;
        layerShadow.shadowColor   = [UIColor blackColor].CGColor;
        layerShadow.shadowOpacity = 0.6;
        layerShadow.shadowOffset  = CGSizeMake(35.0, 35.0);
        layerShadow.masksToBounds = NO;
        
        [self updateShadowPath];
    }
}

- (void)updateShadowPath {
    CALayer *layer = _searchButton.layer;
    
    CGFloat increase = layer.shadowRadius;
    CGRect centerViewContainerRect = _searchButton.bounds;
    centerViewContainerRect.origin.x -= increase;
    centerViewContainerRect.origin.y -= increase;
    centerViewContainerRect.size.width  += 2 * increase;
    centerViewContainerRect.size.height += 2 * increase;
    
    layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:centerViewContainerRect cornerRadius:kJVCenterViewContainerCornerRadius] CGPath];
    
}

- (IBAction)pressOnSearchButton:(id)sender {
    [self.delegate segueOnMainScreen];
}


@end
