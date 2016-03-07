//
//  SortingView.m
//  CargoGuroViper
//
//  Created by Виктория on 05.03.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import "SortingView.h"

@interface SortingView () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end


@implementation SortingView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *resultTableIdentifier = @"FilterCell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:resultTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:resultTableIdentifier];
    }
    if (indexPath.row == self.currentSelectSorting) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    if (indexPath.row == 0) {
        
        cell.textLabel.text = @"По цене";
        
    } else if (indexPath.row == 1) {
        
        cell.textLabel.text = @"По перевозчику";
        
    } else if (indexPath.row == 2) {
        
        cell.textLabel.text = @"По способу";
        
    } else if (indexPath.row == 3) {
        
        cell.textLabel.text = @"По времени";
        
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate sortingResultsBy:indexPath.row withFlag:indexPath.row == self.currentSelectSorting ? NO:YES];
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
