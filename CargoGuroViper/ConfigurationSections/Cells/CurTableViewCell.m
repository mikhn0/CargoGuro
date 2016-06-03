//
//  CurTableViewCell.m
//  CargoGuruViper
//
//  Created by Виктория on 02.06.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import "CurTableViewCell.h"

@interface CurTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *currencySymbol;
@property (weak, nonatomic) IBOutlet UILabel *currencyLabel;

@end

@implementation CurTableViewCell

@synthesize currencySymbol = _currencySymbol;
@synthesize currencyLabel = _currencyLabel;
@synthesize selectedIcon = _selectedIcon;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (NSString *)currencyName {
    return _currencyLabel.text;
}

- (void)setCurrencyName:(NSString *)currencyName {
    _currencyLabel.text = currencyName;
}

- (NSString *)currencyImageName {
    return _currencySymbol.text;
}

- (void)setCurrencySymbolByName:(NSString *)currencySymbolByName {
    _currencySymbol.text = currencySymbolByName;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    _selectedIcon.hidden = !selected;
}

@end
