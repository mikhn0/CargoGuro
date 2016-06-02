//
//  LanguageViewController.m
//  CargoGuruViper
//
//  Created by a1 on 01.06.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import "LanguageViewController.h"

enum {
    kRus  = 0,
    kChn  = 1,
    kEng  = 2,
    kDeu  = 3
};


static NSString * const kLanCellReuseIdentifier = @"LanCellReuseIdentifier";

@interface LanguageViewController ()

@end

@implementation LanguageViewController

@synthesize countryName = _countryName;
@synthesize countryImageName = _countryImageName;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSArray *)countryName {
    return @[@"Русский", @"中国人", @"English", @"Deutsch"];
}

- (NSArray *)countryImageName {
    return @[@"rus_flag", @"ch_flag", @"en_flag", @"en_flag"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case kSearchIndex:
            
            
        default:
            break;
    }
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
