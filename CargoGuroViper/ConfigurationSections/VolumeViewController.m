//
//  VolumeViewController.m
//  CargoGuruViper
//
//  Created by a1 on 01.06.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import "VolumeViewController.h"
#import "VolTableViewCell.h"

static NSString * const kCurCellReuseIdentifier = @"VolCellReuseIdentifier";

@implementation VolumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentIndex = INDEX_VOLUME;
    [self setCustomNavigationBackButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setCustomNavigationBackButton];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *volues = VOLUME_NAME;
    return [volues count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VolTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCurCellReuseIdentifier forIndexPath:indexPath];
    cell.name = [VOLUME_NAME objectAtIndex:indexPath.row];
    
    [[cell selectedIcon] setHidden:YES];
    if (indexPath.row == self.currentIndex) {
        [[cell selectedIcon] setHidden:NO];
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return LocalizedString(@"VALUE"); //@"Объем";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.currentIndex = indexPath.row;
    [self.tableView reloadData];
    
    [[NSUserDefaults standardUserDefaults] setObject:@(indexPath.row) forKey:@"currentIndexVolume"];
    
    NSDictionary *userInfo = @{@"indexVolume":@(indexPath.row)};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeVolume" object:nil userInfo:userInfo];
}



@end
