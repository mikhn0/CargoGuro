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
#import "ConfigFormat+NSString.h"

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
{
    NSInteger currentCountry;
    NSInteger currentCurrency;
    NSInteger currentWeight;
    NSInteger currentVolume;
}
@property (nonatomic) NSArray *leftMenuSections;
@property (nonatomic) NSArray *countryImageName;
@property (nonatomic) NSArray *countryName;
@property (nonatomic) NSArray *configName;

@end

@implementation LeftTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.leftMenuSections = @[@"Поиск", @"Язык", @"Валюта", @"Вес", @"Объем", @"О проекте", @"Обратная связь"];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(kJVTableViewTopInset, 0.0, 0.0, 0.0);
    self.clearsSelectionOnViewWillAppear = NO;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    currentCountry = [[[NSUserDefaults standardUserDefaults] objectForKey:@"currentIndexCountry"] integerValue];
    currentCurrency = [[[NSUserDefaults standardUserDefaults] objectForKey:@"currentIndexCurrency"] integerValue];
    currentVolume = [[[NSUserDefaults standardUserDefaults] objectForKey:@"currentIndexVolume"] integerValue];
    currentWeight = [[[NSUserDefaults standardUserDefaults] objectForKey:@"currentIndexWeight"] integerValue];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguageWithIndexCountry:) name:@"ChangeLanguage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCurrencyWithIndex:) name:@"ChangeCurrency" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeVolumeWithIndex:) name:@"ChangeVolume" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeWeightWithIndex:) name:@"ChangeWeight" object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:kSearchIndex inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (NSArray *)countryImageName {
    return @[@"rus_flag", @"ch_flag", @"en_flag", @"en_flag"];
}

- (NSArray *)countryName {
    return @[@"RUS", @"中", @"ENG", @"DEU"];
}

- (NSArray *)configName {
    return @[@[@"RUB", @"USD", @"EUR", @"KTZ", @"CNY"], @[@"кг", @"г", @"тн"], @[[NSString printCubeOfValue:@"м"], [NSString printCubeOfValue:@"см"], @"л"]];
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
            cell.iconImage = [UIImage imageNamed:[self.countryImageName objectAtIndex:currentCountry]];
            cell.titleParameter = [self.countryName objectAtIndex:currentCountry];
        }
            break;
        case kCurrencyIndex:
        case kWeightIndex:
        case kVolumeIndex:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:kConfigCellReuseIdentifier forIndexPath:indexPath];
            cell.titleText = [self.leftMenuSections objectAtIndex:indexPath.row];
            cell.iconImage = nil;
            
            cell.titleParameter = [[self.configName objectAtIndex:indexPath.row-2] objectAtIndex:(indexPath.row == kCurrencyIndex ? currentCurrency : indexPath.row == kWeightIndex ? currentWeight : indexPath.row == kVolumeIndex ? currentVolume : 0)];
        }
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
            
        case kAboutProjectIndex:
            destinationViewController = [[AppDelegate globalDelegate] volumeViewController];
            break;
        case kContactUsIndex:
            destinationViewController = [[AppDelegate globalDelegate] volumeViewController];
            break;
            
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


#pragma mark - LanguageViewControllerDelegate
- (void)changeLanguageWithIndexCountry:(NSNotification *)notification {
    currentCountry = [notification.userInfo[@"indexCountry"] integerValue];
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:kLanguageIndex inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
}

- (void)changeCurrencyWithIndex:(NSNotification *)notification {
    currentCurrency = [notification.userInfo[@"indexCurrency"] integerValue];
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:kCurrencyIndex inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
}

- (void)changeVolumeWithIndex:(NSNotification *)notification {
    currentVolume = [notification.userInfo[@"indexVolume"] integerValue];
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:kVolumeIndex inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
}

- (void)changeWeightWithIndex:(NSNotification *)notification {
    currentWeight = [notification.userInfo[@"indexWeight"] integerValue];
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:kWeightIndex inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // Dispose of any resources that can be recreated.
}

@end
