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

@end


@implementation CurTableViewCell
@synthesize currencySymbol = _currencySymbol;

- (NSString *)currencyImageName {
    return _currencySymbol.text;
}

- (void)setCurrencySymbolByName:(NSString *)currencySymbolByName {
    _currencySymbol.text = currencySymbolByName;
}

@end
