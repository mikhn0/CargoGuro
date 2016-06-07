//
//  AboutUsViewController.m
//  CargoGuruViper
//
//  Created by Виктория on 06.06.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import "AboutUsViewController.h"
#import "AppDelegate.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

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

@end
