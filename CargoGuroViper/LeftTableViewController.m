//
//  LeftTableViewController.m
//  JVFloatingDrawer
//
//  Created by Julian Villella on 2015-01-15.
//  Copyright (c) 2015 JVillella. All rights reserved.
//

#import "LeftTableViewController.h"
#import "RevealTableViewCell.h"
#import "AppDelegate.h"
#import "JVFloatingDrawerViewController.h"

enum {
    kSearchIndex    = 0,
    kLanguageIndex  = 1,
    kCurrencyIndex  = 2,
    kWeightIndex    = 3,
    kVolumeIndex    = 4,
    kAboutProjectIndex = 5,
    kContactUsIndex = 6
};

static const CGFloat kJVTableViewTopInset = 50.0;
static NSString * const kSearchCellReuseIdentifier = @"SearchCellReuseIdentifier";
static NSString * const kConfigCellReuseIdentifier = @"ConfigCellReuseIdentifier";
static NSString * const kInfoCellReuseIdentifier = @"InfoCellReuseIdentifier";

@interface LeftTableViewController () <RevealTableViewCellDelegate>

@property (nonatomic) NSArray *leftMenuSections;

@end

@implementation LeftTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.leftMenuSections = @[@"Поиск", @"Язык", @"Валюта", @"Вес", @"Объем", @"О проекте", @"Обратная связь"];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(kJVTableViewTopInset, 0.0, 0.0, 0.0);
    self.clearsSelectionOnViewWillAppear = NO;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:kSearchIndex inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case kSearchIndex:
        {
            return 120;
        }
            break;
            
        default:
            return 60;
            break;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RevealTableViewCell *cell;
    
    switch (indexPath.row) {
        case kSearchIndex:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:kSearchCellReuseIdentifier forIndexPath:indexPath];
            cell.searchText = @"Поиск";
            cell.delegate = self;
        }
            break;
            
        case kLanguageIndex:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:kConfigCellReuseIdentifier forIndexPath:indexPath];
            cell.titleText = [self.leftMenuSections objectAtIndex:indexPath.row];
            cell.iconImage = [UIImage imageNamed:@"rus_flag"];
        }
            break;
        case kCurrencyIndex:
        case kWeightIndex:
        case kVolumeIndex:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:kConfigCellReuseIdentifier forIndexPath:indexPath];
            cell.titleText = [self.leftMenuSections objectAtIndex:indexPath.row];        }
            break;
        case kAboutProjectIndex:
        case kContactUsIndex:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:kInfoCellReuseIdentifier forIndexPath:indexPath];
            cell.titleText = [self.leftMenuSections objectAtIndex:indexPath.row];
        }
            
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *destinationViewController = nil;

    switch (indexPath.row) {
        case kLanguageIndex:
            destinationViewController = [[AppDelegate globalDelegate] languageViewController];
            break;
        case kCurrencyIndex:
            destinationViewController = [[AppDelegate globalDelegate] currencyViewController];
            break;
        case kWeightIndex:
            destinationViewController = [[AppDelegate globalDelegate] weightViewController];
            break;
        case kVolumeIndex:
            destinationViewController = [[AppDelegate globalDelegate] volumeViewController];
            break;
            
//        case kAboutProjectIndex:
//            destinationViewController = [[AppDelegate globalDelegate] volumeViewController];
//            break;
//        case kContactUsIndex:
//            destinationViewController = [[AppDelegate globalDelegate] volumeViewController];
//            break;
            
        default:
            break;
    }

    
    [[[AppDelegate globalDelegate] drawerViewController] setCenterViewController:destinationViewController];
    [[AppDelegate globalDelegate] toggleLeftDrawer:self animated:YES];
}

#pragma mark - RevealTableViewCellDelegate
- (void)segueOnMainScreen {
    UIViewController *destinationViewController = nil;
    destinationViewController = [[AppDelegate globalDelegate] calculateModuleViewController];
    [[[AppDelegate globalDelegate] drawerViewController] setCenterViewController:destinationViewController];
    [[AppDelegate globalDelegate] toggleLeftDrawer:self animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
