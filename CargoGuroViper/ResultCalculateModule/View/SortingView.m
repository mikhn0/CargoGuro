//
//  SortingView.m
//  CargoGuroViper
//
//  Created by Виктория on 05.03.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import "SortingView.h"

@interface SortingView () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end


@implementation SortingView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch {
    return !(touch.view != self);
}
//- (BOOL)gestureRecognizerShouldBegin:(UITapGestureRecognizer *)gestureRecognizer {
////    if (gestureRecognizer.view != self) {
////        return NO;
////    }
////    return YES;
//    
//    CGPoint point = [gestureRecognizer locationInView:gestureRecognizer.view];
//    id viewTouched = [gestureRecognizer.view hitTest:point withEvent:nil];
//    if ([viewTouched isKindOfClass:[UITableView class]]) {
//        return NO;
//    } else {
//        return YES;
//        // respond to touch action
//    }
//    
//}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeScreen:)];
    tapGest.delegate = self;
    [tapGest setCancelsTouchesInView:NO];
    [self setUserInteractionEnabled:YES];
    [self addGestureRecognizer:tapGest];
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

- (void)closeScreen:(UITapGestureRecognizer *)sender {
//    CGPoint point = [sender locationInView:sender.view];
//    id viewTouched = [sender.view.superview hitTest:point withEvent:nil];
//    if ([viewTouched isKindOfClass:[UITableViewCellContentView class]]) {
//        
//    } else {
        [self removeFromSuperview];
    //}
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
