//
//  WeightViewController.m
//  CargoGuruViper
//
//  Created by a1 on 01.06.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import "WeightViewController.h"
#import "WeightTableViewCell.h"

static NSString * const kCurCellReuseIdentifier = @"WeightCellReuseIdentifier";

@implementation WeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentIndex = INDEX_WEIGHT;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *weights = WEIGHT_NAME;
    return [weights count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WeightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCurCellReuseIdentifier forIndexPath:indexPath];
    cell.name = [WEIGHT_NAME objectAtIndex:indexPath.row];
    
    [[cell selectedIcon] setHidden:YES];
    if (indexPath.row == self.currentIndex) {
        [[cell selectedIcon] setHidden:NO];
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Вес";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.currentIndex = indexPath.row;
    [self.tableView reloadData];
    
    [[NSUserDefaults standardUserDefaults] setObject:@(indexPath.row) forKey:@"currentIndexWeight"];
    
    NSDictionary *userInfo = @{@"indexWeight":@(indexPath.row)};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeWeight" object:nil userInfo:userInfo];
}

@end
