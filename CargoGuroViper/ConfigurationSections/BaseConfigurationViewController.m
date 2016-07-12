//
//  BaseConfigurationViewController.m
//  CargoGuruViper
//
//  Created by a1 on 01.06.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import "BaseConfigurationViewController.h"

@interface BaseConfigurationViewController ()


@end

@implementation BaseConfigurationViewController

- (void)setCustomNavigationBackButton
{
    self.backButton = [[UIButton alloc] initWithFrame: CGRectMake(15.0f, 25.0f, 80.0f, 30.0f)];
    [self.backButton setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [self.backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [self.backButton setTitle:LocalizedString(@"BACK") forState:UIControlStateNormal];
    [self.backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -14, 0, 0)];
    [self.backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    [self.customTopBar addSubview:self.backButton];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void) popBack {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateUI" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];

}


@end
