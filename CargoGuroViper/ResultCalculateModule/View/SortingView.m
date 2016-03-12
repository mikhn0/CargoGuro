//
//  SortingView.m
//  CargoGuroViper
//
//  Created by Виктория on 05.03.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import "SortingView.h"
#import "CGResultCalculateModuleViewController.h"

@interface SortingView () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate> {
    NSMutableArray *flagArray;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end


@implementation SortingView

- (id)init {
    if ((self = [super init])) {
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch {
    return !(touch.view != self);
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeScreen:)];
    tapGest.delegate = self;
    [tapGest setCancelsTouchesInView:NO];
    [self setUserInteractionEnabled:YES];
    [self addGestureRecognizer:tapGest];
    
    flagArray = @[@(0), @(0), @(0), @(0)].mutableCopy;
    
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
        
        //Reset all flags besides selected
        [self resetAllFlagsBesides:indexPath.row];
        
        //Set image of checkmarks
        cell.accessoryView = [self setButtonByIndex:indexPath.row];
        
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
    [self.delegate sortingResultsBy:indexPath.row withFlag:self.arrowCurrentSorting];
    [self removeFromSuperview];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *checked = [flagArray objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    UIButton *button = (UIButton *)cell.accessoryView;
    
    [button setBackgroundImage:[self getImageByFlagArray:checked] forState:UIControlStateNormal];
}

- (void) resetAllFlagsBesides:(NSInteger)index {
    for (int i=0; i<flagArray.count; i++) {
        if (i != index) {
            flagArray[i] = @(None);
        }
    }
}

- (UIImage *)getImageByFlagArray:(NSNumber *)flag {
    UIImage *newImage;
    if ([flag isEqualToNumber:@(None)]) {
        newImage = nil;
    } else if ([flag isEqualToNumber:@(Top)]) {
        newImage = [UIImage imageNamed:@"top_arrow"];
    } else if ([flag isEqualToNumber:@(Bottom)]) {
        newImage = [UIImage imageNamed:@"bottom_arrow"];
    }
    return newImage;
}

- (UIButton *)setButtonByIndex:(NSInteger)index {
    
    //Change status selected checkmarks
    flagArray[index] = @(self.arrowCurrentSorting);
    
    //Change image of button in the rows
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *newImage = [self getImageByFlagArray:flagArray[index]];
    CGRect frame = CGRectMake(0.0, 0.0, 36.0, 36.0);
    button.frame = frame;
    [button setBackgroundImage:newImage forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(checkButtonTapped:event:)  forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor clearColor];
    return button;
}

- (void)checkButtonTapped:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
    if (indexPath != nil)
    {
        [self tableView: self.tableView accessoryButtonTappedForRowWithIndexPath: indexPath];
    }
}


- (void)closeScreen:(UITapGestureRecognizer *)sender {
    [self removeFromSuperview];
}


@end
