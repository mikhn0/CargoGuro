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

- (IBAction)actionToggleLeftDrawer:(id)sender {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end
