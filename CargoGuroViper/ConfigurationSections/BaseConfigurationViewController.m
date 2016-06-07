//
//  BaseConfigurationViewController.m
//  CargoGuruViper
//
//  Created by a1 on 01.06.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import "BaseConfigurationViewController.h"
#import "AppDelegate.h"

@interface BaseConfigurationViewController ()

@end

@implementation BaseConfigurationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionToggleLeftDrawer:(id)sender {
    [[AppDelegate globalDelegate] toggleLeftDrawer:self animated:YES];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end
