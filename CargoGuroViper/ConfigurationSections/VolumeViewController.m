//
//  VolumeViewController.m
//  CargoGuruViper
//
//  Created by a1 on 01.06.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import "VolumeViewController.h"
#import "VolTableViewCell.h"
#import "ConfigFormat+NSString.h"

static NSString * const kCurCellReuseIdentifier = @"VolCellReuseIdentifier";

@implementation VolumeViewController

@synthesize volumeName = _volumeName;
@synthesize volumeImageName = _volumeImageName;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentIndex = [[[NSUserDefaults standardUserDefaults] objectForKey:@"currentIndexVolume"] integerValue];
}

- (NSArray *)volumeName {
    return @[[NSString printCubeOfValue:@"м"], [NSString printCubeOfValue:@"см"], @"л"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *volues = self.volumeName;
    return [volues count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VolTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCurCellReuseIdentifier forIndexPath:indexPath];
    cell.name = [self.volumeName objectAtIndex:indexPath.row];
    
    [[cell selectedIcon] setHidden:YES];
    if (indexPath.row == self.currentIndex) {
        [[cell selectedIcon] setHidden:NO];
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Объем";
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
