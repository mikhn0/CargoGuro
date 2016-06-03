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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    UIViewController *destinationViewController = nil;
//    
//    switch (indexPath.row) {
//        case kLanguageIndex:
//            destinationViewController = [[AppDelegate globalDelegate] languageViewController];
//            break;
//        case kCurrencyIndex:
//            destinationViewController = [[AppDelegate globalDelegate] currencyViewController];
//            break;
//        case kWeightIndex:
//            destinationViewController = [[AppDelegate globalDelegate] weightViewController];
//            break;
//        case kVolumeIndex:
//            destinationViewController = [[AppDelegate globalDelegate] volumeViewController];
//            break;
//            
//            //        case kAboutProjectIndex:
//            //            destinationViewController = [[AppDelegate globalDelegate] volumeViewController];
//            //            break;
//            //        case kContactUsIndex:
//            //            destinationViewController = [[AppDelegate globalDelegate] volumeViewController];
//            //            break;
//            
//        default:
//            break;
//    }
//    
//    
//    [[[AppDelegate globalDelegate] drawerViewController] setCenterViewController:destinationViewController];
//    [[AppDelegate globalDelegate] toggleLeftDrawer:self animated:YES];
//}




@end
